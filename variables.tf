

# variable "storage_account_enabled" {
#   type    = bool
#   default = false
# }

# variable "storage_account_name" {
#   type    = string
#   default = null
# }
variable "environment_name" {
  description = "Environment key to select config (lab | non-live | live)"
  type        = string
}
// The following variables were previously used for naming inputs.
// Configuration now sources these from environment YAML (local.env.*),
// so set safe defaults to prevent interactive prompts during plan/apply.
variable "location" {
  type    = string
  default = ""
}
variable "environment" {
  type    = string
  default = ""
}
variable "routing_domain" {
  type    = string
  default = ""
}
variable "application_id" {
  type    = string
  default = ""
}
variable "context" {
  type    = string
  default = ""
}
variable "seq" {
  type    = string
  default = ""
}
variable "security_zone" {
  type    = string
  default = ""
}
variable "subnet_cidr" {
  type    = string
  default = ""
}
variable "local_market_shortcut" {
  type    = string
  default = ""
}
variable "local_market" {
  type    = string
  default = ""
}
variable "key_func" {
  type    = string
  default = ""
}
variable "vnet_name_suffix" {
  type    = string
  default = ""
}
variable "pip_suffix" {
  type    = string
  default = ""
}
