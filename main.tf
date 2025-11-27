provider "azurerm" {
  features {}
  storage_use_azuread             = true
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
  source = "../repo-root-terraform/azure-naming-standard-tfmodule"

  # Required inputs
  location                 = var.location            # e.g. "uksouth"
  environment              = var.environment         # e.g. "prd"
  routing_domain           = var.routing_domain      # e.g. "130"
  application_id           = var.application_id      # e.g. "00101"
  context                  = var.context             # e.g. "app" or service code
  inc                      = var.seq                 # e.g. "001"

  # Optional inputs (set if you need them)
  local_market_shortcut    = var.local_market_shortcut  # e.g. "uk"
  local_market             = var.local_market
  security_zone            = var.security_zone          # for NSG/subnets
  subnet_cidr              = var.subnet_cidr            # e.g. "100_90_12_0-29"
  key_func                 = var.key_func               # for `kvk`
  vnet_name_suffix         = var.vnet_name_suffix
  pip_suffix               = var.pip_suffix
}