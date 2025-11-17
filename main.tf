provider "azurerm" {
  features {}
  storage_use_azuread = true
  resource_provider_registrations = "none"
  # subscription_id                 = var.subscriptionId
  # tenant_id                       = var.tenantId
}

data "azurerm_client_config" "current" {}


locals {
  env = yamldecode(
    file("${path.root}/environments/${var.environment_name}.yml")  
  )
}

# --------------------------
# Resource Group
# --------------------------
module "resource-group" {
  source   = "git::https://github.com/valini01/repo-modules-env.git//modules/terraform-azurerm-avm-res-resources-resourcegroup-main?ref=main"
  name     = local.env.resources.resource_group.name
  location = local.env.location
}

# --------------------------
# Key Vault (conditionall)
# --------------------------
module "key-vault" {
  source              = "git::https://github.com/valini01/repo-modules-env.git//modules/terraform-azurerm-avm-res-keyvault-vault-main?ref=main"
  count               = local.env.resources.key_vault.enabled ? 1 : 0

  name                = local.env.resources.key_vault.name
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

  name                           = local.env.resources.storage_account.name
  resource_group_name            = module.resource-group.name
  location                       = local.env.location
  shared_access_key_enabled      = false
  default_to_oauth_authentication = true
}

