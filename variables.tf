variable "metro_code" {
  description = "Metro location."
  type        = string
  default     = "NY"
}

variable "create_vgw" {
  description = "Set to true to create a new VGW."
  type        = bool
  default     = true
}

variable "attach_vgw" {
  description = "Set to true to attach VGW to an existing VPC."
  type        = bool
  default     = true
}

variable "enable_route_propagation" {
  description = "Set to true to enable route propagation."
  type        = bool
  default     = true
}

variable "create_pvif" {
  description = "Set to true to create private VIF."
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "Existing VPC ID for vgw attachment."
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "Existing subnet ID for route propagation."
  type        = string
  default     = null
}

variable "dx_name" {
  description = "AWS DX connection name."
  type        = string
  default     = "aws-dx-connection"
}

variable "dx_mtu" {
  description = "AWS DX MTU."
  type        = number
  default     = 1500
}

variable "pvif_name" {
  description = "AWS Private VIF name."
  type        = string
  default     = "pvif-50mb"
}

variable "notifications" {
  description = "List of email addresses that will receive device status notifications."
  type        = list(string)
  default     = ["myemail@equinix.com"]
}

variable "speed" {
  description = "AWS DX speed."
  type        = string
  default     = "50"
}

variable "speed_unit" {
  description = "AWS DX speed unit."
  type        = string
  default     = "MB"
}

variable "device_uuid" {
  description = "Equinix device UUID."
  type        = string
}

variable "device_interface_id" {
  description = "Equinix device interface ID."
  type        = number
  default     = 3
}

variable "aws_region" {
  description = "AWS region."
  type        = string
  default     = "us-east-1"
}

variable "aws_account_id" {
  description = "AWS account ID."
  type        = string
}

variable "router_type_identifier" {
  description = "AWS DX Router Type ID."
  type        = string
  default     = "CiscoSystemsInc-2900SeriesRouters-IOS124"
}

variable "vgw_name" {
  description = "AWS VGW name."
  type        = string
  default     = "transit-vgw"
}

variable "vgw_asn" {
  description = "AWS vgw BGP AS Number."
  type        = string
  default     = "64512"
}

variable "router_asn" {
  description = "Router peer BGP AS Number."
  type        = string
  default     = "64513"
}

variable "bgp_auth_key" {
  description = "BGP authentication key."
  type        = string
  default     = "Equinix123#"
}