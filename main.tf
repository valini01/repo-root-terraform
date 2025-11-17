provider "azurerm" {
  subscription_id = "104ad005-3dec-497b-88a0-cd0ead048652"
  features {}
  # Enable Azure AD (Entra ID) authentication for storage data plane operations
  # (Supported in recent azurerm provider versions). Falls back to key auth if unsupported.
  # Use managed identity instead of service principal secrets if running in an environment
  # where MSI is available (e.g., Azure VM, Cloud Shell). On local Windows this will be ignored.
  storage_use_azuread = true
  
}

data "azurerm_client_config" "current" {}

# 🎯 Dynamic Environment Configuration Loading
# This gets automatically replaced by the pipeline templates:
# - LAB: lab-customer-config.yml
# - NLV: nlv-customer-config.yml  
# - LV:  lv-customer-config.yml
locals {
  env = yamldecode(
    file("${path.root}/environments/ENV_FILE.yml")  # Default to LAB, pipeline replaces this
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

# --------------------------
