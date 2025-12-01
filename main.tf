provider "azurerm" {
  features {}
  storage_use_azuread             = true
  resource_provider_registrations = "none"

}

data "azurerm_client_config" "current" {}


locals {
  env = yamldecode(
    file("${path.root}/environments/${var.environment_name}/config.yml")
  )
}

# --------------------------
# Resource Group
# --------------------------
module "resource-group" {
  source   = "git::https://github.com/valini01/repo-modules-env.git//modules/terraform-azurerm-avm-res-resources-resourcegroup-main?ref=main"
  name     = module.naming.standard["resource-group"]
  location = local.env.location
}

# --------------------------
# Key Vault (conditionall)
# --------------------------
module "key-vault" {
  source              = "git::https://github.com/valini01/repo-modules-env.git//modules/terraform-azurerm-avm-res-keyvault-vault-main?ref=main"
  count               = local.env.resources.key_vault.enabled ? 1 : 0

  name                = module.naming.standard["key-vault"]
  resource_group_name = module.resource-group.name
  location            = local.env.location
  tenant_id           = data.azurerm_client_config.current.tenant_id
}

# --------------------------
# Storage Account (conditional)
# --------------------------
module "storage-account" {
  source              = "git::https://github.com/valini01/repo-modules-env.git//modules/terraform-azurerm-avm-res-storage-storageaccount-main?ref=main"
  count               = local.env.resources.storage_account.enabled ? 1 : 0

  name                           = module.naming.standard["storage-account"]
  resource_group_name            = module.resource-group.name
  location                       = local.env.location
  shared_access_key_enabled      = false
  default_to_oauth_authentication = true
}

module "naming" {
  source = "../repo-modules-env/modules/azure-naming-standard-tfmodule"

  # Required inputs from YAML
  location       = local.env.location
  environment    = local.env.environment
  routing_domain = local.env.routing_domain
  application_id = local.env.application_id
  context        = local.env.context
  inc            = local.env.seq

  # Optional inputs from YAML
  local_market_shortcut = local.env.local_market_shortcut
  local_market          = local.env.local_market
  security_zone         = local.env.security_zone
  subnet_cidr           = local.env.subnet_cidr
  key_func              = local.env.key_func
  vnet_name_suffix      = local.env.vnet_name_suffix
  pip_suffix            = local.env.pip_suffix
  hub                   = local.env.hub
  data_disk_inc         = local.env.data_disk_inc
  fe_type               = local.env.fe_type
  ip_version            = local.env.ip_version
  agwbe_port            = local.env.agwbe_port
  agwhp_type            = local.env.agwhp_type
  agwrrl_type           = local.env.agwrrl_type
  agwbs_type            = local.env.agwbs_type
  agwls_port            = local.env.agwls_port
}
