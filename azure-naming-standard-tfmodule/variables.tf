variable "location" {
  type        = string
  description = "(Required) Location for the deployment"
}

variable "local_market_shortcut" {
  type        = string
  description = "(Required) Abbreviated form of the local market, used for naming convention."
  default     = ""
}

variable "environment" {
  type        = string
  description = "(Required) Environment for the deployment"
  default     = ""
  validation {
    condition     = can(regex("^(dev|prd|mgmt|stg|tst|sbox|pprd)$", var.environment))
    error_message = "Environment must be one of dev, prd, mgmt, pprd, sbox, stg or tst"
  }
}

variable "data_disk_inc" {
  type        = string
  description = "(Optional) Increment value for data disk"
  default     = ""
}

variable "key_func" {
  type        = string
  description = "Key function value to differentiate"
  default     = ""
}

variable "hub" {
  type        = string
  description = "Resource being deployed in hub"
  default     = ""
}

variable "sub" {
  type        = string
  description = "(Optional) Subscription identifier where the resources are being deployed"
  default     = ""
}

variable "subnet_cidr" {
  type        = string
  description = "(Optional) Subscription identifier where the resources are being deployed"
  default     = ""
}

variable "context" {
  type        = string
  description = "(Optional) Context identifier of which resources are being deployed"
  default     = ""
}

variable "inc" {
  type = string
  #description = "(Optional) Context identifier of which resources are being deployed"
  default = ""
}

variable "local_market" {
  type        = string
  description = "(Optional) Local market identifier for the deployment"
  default     = ""

}

variable "application_id" {
  type        = string
  description = "(Optional) Application ID of the deployment"
  default     = ""
}

variable "routing_domain" {
  type        = string
  description = "Identifier for a logical grouping of network routes, used to define routing policies within the Hub"
  default     = ""
}

variable "security_zone" {
  type        = string
  description = "(Optional) security zone ID for NSG"
  default     = ""
}

variable "resource" {
  type        = string
  description = "(Optional) Resource identifier for networking resources"
  default     = ""
}

variable "subscription_id" {
  type        = string
  description = "(Optional) Subscription id where the resources are being deployed"
  default     = ""
}

variable "md5_identifier" {
  type        = string
  description = "(Optional) md5_identifier to generate unique md5 hash value for a subscription."
  default     = ""
}

variable "vnet_name_suffix" {
  type        = string
  description = "(Optional) Suffix to construct Vnet name other then hub vnet"
  default     = ""
}

variable "er_provider" {
  type        = string
  description = "(Optional) Provider for Express Route"
  default     = ""
}

variable "pip_suffix" {
  type        = string
  description = "(Optional) Provider for Public Ip Address"
  default     = ""
}

variable "location-map" {
  description = "Azure location map used for naming abbreviations"
  type        = map(any)
  default = {
    "Global"               = "Global",
    "Australia Central 2"  = "cau2",
    "Australia Central"    = "cau",
    "Australia East"       = "eau",
    "Australia Southeast"  = "seau",
    "australiacentral"     = "cau",
    "australiacentral2"    = "cau2",
    "australiaeast"        = "eau",
    "australiasoutheast"   = "seau",
    "Brazil South"         = "sbr",
    "brazilsouth"          = "sbr",
    "Canada Central"       = "cac",
    "Canada East"          = "eca",
    "canadacentral"        = "cac",
    "canadaeast"           = "eca",
    "Central India"        = "cin",
    "Central US"           = "cus",
    "centralindia"         = "cin",
    "centralus"            = "cus",
    "East Asia"            = "eaa",
    "East US 2"            = "eus2",
    "East US"              = "eus",
    "eastasia"             = "eaa",
    "eastus"               = "eus",
    "eastus2"              = "eus2",
    "France Central"       = "frc",
    "France South"         = "frs",
    "francecentral"        = "frc",
    "francesouth"          = "frs",
    "Germany North"        = "nge",
    "Germany West Central" = "gwc",
    "germanynorth"         = "nge",
    "germanywestcentral"   = "gwc",
    "Italy North"          = "itn",
    "italynorth"           = "itn",
    "Japan East"           = "eja",
    "Japan West"           = "wja",
    "japaneast"            = "eja",
    "japanwest"            = "wja",
    "Korea Central"        = "cko",
    "Korea South"          = "sko",
    "koreacentral"         = "cko",
    "koreasouth"           = "sko",
    "North Central US"     = "ncus",
    "North Europe"         = "neu",
    "northcentralus"       = "ncus",
    "northeurope"          = "neu",
    "South Africa North"   = "nsa",
    "South Africa West"    = "wsa",
    "South Central US"     = "scus",
    "South India"          = "sin",
    "southafricanorth"     = "nsa",
    "southafricawest"      = "wsa",
    "southcentralus"       = "scus",
    "Southeast Asia"       = "sea",
    "southeastasia"        = "sea",
    "southindia"           = "si",
    "UAE Central"          = "cua",
    "UAE North"            = "nua",
    "uaecentral"           = "cua",
    "uaenorth"             = "nua",
    "UK South"             = "uks",
    "UK West"              = "ukw",
    "uksouth"              = "uks",
    "ukwest"               = "ukw",
    "West Central US"      = "wcus",
    "West Europe"          = "weu",
    "West India"           = "win",
    "West US 2"            = "wus2",
    "West US"              = "wus",
    "westcentralus"        = "wcus",
    "westeurope"           = "weu",
    "westindia"            = "win",
    "westus"               = "wus",
    "westus2"              = "wus2"
  }
}

#----------------------------------------------------------
# Application Gateway related variables
#----------------------------------------------------------
variable "fe_type" {
  type        = string
  description = "(Optional) Frontend type for Application Gateway"
  default     = ""
}
variable "ip_version" {
  type        = string
  description = "(Optional) IP version for Application Gateway"
  default     = ""
}
variable "agwbe_port" {
  type        = string
  description = "(Optional) Backend port for Application Gateway"
  default     = ""
}
variable "agwhp_type" {
  type        = string
  description = "(Optional) Health probe type for Application Gateway"
  default     = ""
}
variable "agwrrl_type" {
  type        = string
  description = "(Optional) Routing rule type for Application Gateway"
  default     = ""
}
variable "agwbs_type" {
  type        = string
  description = "(Optional) Backend settings type for Application Gateway"
  default     = ""
}
variable "agwls_port" {
  type        = string
  description = "(Optional) Listener port for Application Gateway"
  default     = ""
}
