

# variable "storage_account_enabled" {
#   type    = bool
#   default = false
# }

# variable "storage_account_name" {
#   type    = string
#   default = null
# }
variable "environment_name" {
  description = "Environment key to select config (lab | nlv | lv)"
  type        = string
}
variable "location"      { type = string }
variable "environment"   { type = string }
variable "routing_domain"{ type = string }
variable "application_id"{ type = string }
variable "context"       { type = string }
variable "seq"           { type = string }  # 3-digit sequential number
variable "security_zone" { type = string }
variable "subnet_cidr"   { type = string }
variable "local_market_shortcut" { type = string }
variable "local_market" { type = string }
variable "key_func"     { type = string }
variable "vnet_name_suffix" { type = string }
variable "pip_suffix" { type = string }