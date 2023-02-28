# Terraform Equinix Fabric AWS DX

Terraform module for creating AWS DX hosted connection via Equinix Fabric with options to create AWS vgw, Private VIF, and enable route propagation.

To run this project, you will need to set the following environment variables or the [shared configuration and credentials files](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html).
- EQUINIX_API_CLIENTID
- EQUINIX_API_CLIENTSECRET
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY

See the [Developer Platform](https://developer.equinix.com/docs?page=/dev-docs/fabric/overview) page on how to generate Client ID and Client Secret.

## Sample usage

```hcl
module "aws-dx" {
  source          = "bayupw/aws-dx/equinix"
  version         = "1.0.0"

  metro_code               = "NY"
  notifications            = ["myemail@equinix.com"]
  aws_region               = "us-east-1"
  aws_account_id           = "123456789012"
  device_uuid              = "e5b3690f-fe79-45fc-8fcd-f4cb544b1bf4"
  device_interface_id      = 3
  dx_name                  = "aws-equinix-dx"
  create_vgw               = true
  vpc_id                   = "vpc-059246dc85237011e"
  attach_vgw               = true
  vgw_name                 = "equinix-vgw"
  vgw_asn                  = "64512"
  router_asn               = "64513"
  bgp_auth_key             = "Equinix123#"
  create_pvif              = true
  pvif_name                = "equinix-pvif"
  enable_route_propagation = true
  subnet_id                = "subnet-09b8d929e14a21288"
}
```

## Contributing

Report issues/questions/feature requests on in the [issues](https://github.com/bayupw/terraform-equinix-aws-dx/issues/new) section.

## License

Apache 2 Licensed. See [LICENSE](https://github.com/bayupw/terraform-equinix-aws-dx/tree/master/LICENSE) for full details.