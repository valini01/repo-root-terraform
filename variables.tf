

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
