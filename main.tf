data "equinix_ecx_l2_sellerprofile" "aws" {
  name  = "AWS Direct Connect"
}

resource "equinix_ecx_l2_connection" "this" {
  name                = var.dx_name
  profile_uuid        = data.equinix_ecx_l2_sellerprofile.aws.id
  speed               = var.speed
  speed_unit          = var.speed_unit
  notifications       = var.notifications
  device_uuid         = var.device_uuid
  device_interface_id = var.device_interface_id
  seller_region       = var.aws_region
  seller_metro_code   = var.metro_code
  authorization_key   = var.aws_account_id

  timeouts {
    create = "10m"
    delete = "10m"
  }

  lifecycle {
    ignore_changes = all
  }
}

# if resource creation failed due to 10 mins timed out, set variable `accept_dx = false` then run a `terraform apply` again
# https://github.com/hashicorp/terraform-provider-aws/issues/26335
# https://github.com/hashicorp/terraform-provider-aws/pull/27584
resource "aws_dx_connection_confirmation" "this" {
  connection_id = one([for action_data in one(equinix_ecx_l2_connection.this.actions).required_data : action_data["value"] if action_data["key"] == "awsConnectionId"])
}

# use data source if connection aws_dx_connection_confirmation failed but status is accepted
# data "aws_dx_connection" "this" {
#   name  = equinix_ecx_l2_connection.aws.name
# }

resource "aws_vpn_gateway" "this" {
  count = var.create_vgw ? 1 : 0

  amazon_side_asn = var.vgw_asn

  tags = {
    Name = var.vgw_name
  }
}

resource "aws_vpn_gateway_attachment" "this" {
  count = var.attach_vgw ? 1 : 0

  vpc_id         = var.vpc_id
  vpn_gateway_id = aws_vpn_gateway.this[0].id
}

resource "aws_dx_private_virtual_interface" "this" {
  count = var.create_pvif ? 1 : 0

  connection_id  = aws_dx_connection_confirmation.this.id
  name           = var.pvif_name
  vlan           = equinix_ecx_l2_connection.this.zside_vlan_stag
  address_family = "ipv4"
  bgp_asn        = var.router_asn
  bgp_auth_key   = var.bgp_auth_key
  mtu            = var.dx_mtu
  vpn_gateway_id = aws_vpn_gateway.this[0].id

  timeouts {
    create = "20m"
    delete = "20m"
  }
}

data "aws_dx_router_configuration" "this" {
  count = var.create_pvif ? 1 : 0

  virtual_interface_id   = aws_dx_private_virtual_interface.this[0].id
  router_type_identifier = var.router_type_identifier
}

data "aws_route_table" "this" {
  count = var.enable_route_propagation ? 1 : 0

  subnet_id = var.subnet_id
}

resource "aws_vpn_gateway_route_propagation" "this" {
  count = var.enable_route_propagation ? 1 : 0

  vpn_gateway_id = aws_vpn_gateway.this[0].id
  route_table_id = data.aws_route_table.this[0].id
}