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
  version = jsondecode(file("${path.root}/version.json")).module_version
  tags = merge(
    try(local.env.tags, {}),
    var.tags,
    {
      environment = var.environment_name
      version     = local.version
      appId       = try(local.env.application_id, try(local.env.tags.appId, null))
    }
  )
}

# --------------------------
# Resource Group
# --------------------------
module "resource-group" {
  source = "git::https://github.vodafone.com/vfgroup-aibooster/aibooster-azure-vendor-modules.git//avm_modules/terraform-azurerm-avm-res-resources-resourcegroup-main?ref=main"

  name     = module.naming.standard["resource-group"]
  location = local.env.location
  tags     = local.tags
}

module "key-vault" {
  source = "git::https://github.vodafone.com/vfgroup-aibooster/aibooster-azure-vendor-modules.git//avm_modules/terraform-azurerm-avm-res-keyvault-vault-main?ref=main"
  count  = local.env.resources.key_vault.enabled ? 1 : 0

  name                = module.naming.standard["key-vault"]
  resource_group_name = module.resource-group.name
  location            = local.env.location
  tenant_id           = data.azurerm_client_config.current.tenant_id
  tags                = local.tags
}

module "storage-account" {
  source = "git::https://github.vodafone.com/vfgroup-aibooster/aibooster-azure-vendor-modules.git//avm_modules/terraform-azurerm-avm-res-storage-storageaccount-main?ref=main"
  count  = local.env.resources.storage_account.enabled ? 1 : 0

  name                            = module.naming.standard["storage-account"]
  resource_group_name             = module.resource-group.name
  location                        = local.env.location
  shared_access_key_enabled       = false
  default_to_oauth_authentication = true
  tags                            = local.tags
}

module "naming" {
  source = "git::https://github.vodafone.com/vfgroup-aibooster/aibooster-azure-vendor-modules.git//common_modules/azure-naming-standard-tfmodule?ref=main"

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

# --------------------------
# API Management (conditional)
# --------------------------
module "api-management" {
  source = "git::https://github.vodafone.com/vfgroup-aibooster/aibooster-azure-vendor-modules.git//avm_modules/terraform-azurerm-avm-res-apimanagement-service-main?ref=main"
  count  = local.env.resources.api_management.enabled ? 1 : 0

  name                = module.naming.standard["api-management"]
  resource_group_name = module.resource-group.name
  location            = local.env.location
  publisher_name      = local.env.api_management.publisher_name
  publisher_email     = local.env.api_management.publisher_email
  tags                = local.tags
}

# --------------------------
# Container Apps (conditional)
# --------------------------
module "containerapp" {
  source = "git::https://github.vodafone.com/vfgroup-aibooster/aibooster-azure-vendor-modules.git//avm_modules/terraform-azurerm-avm-res-app-containerapp-main?ref=main"
  count  = local.env.resources.containerapp.enabled ? 1 : 0

  name                                  = module.naming.standard["container-app"]
  resource_group_name                   = module.resource-group.name
  location                              = local.env.location
  container_app_environment_resource_id = local.env.containerapp.environment_resource_id
  template                              = local.env.containerapp.template
  tags                                  = local.tags
}

# --------------------------
# AKS (conditional)
# --------------------------
module "aks" {
  source = "git::https://github.vodafone.com/vfgroup-aibooster/aibooster-azure-vendor-modules.git//avm_modules/terraform-azurerm-avm-res-containerservice-managedcluster-main?ref=main"
  count  = local.env.resources.aks.enabled ? 1 : 0

  name                = module.naming.standard["aks"]
  resource_group_name = module.resource-group.name
  location            = local.env.location

  default_node_pool = local.env.aks.default_node_pool
  dns_prefix        = "${module.naming.standard["aks"]}-dns"
  tags              = local.tags
}

# --------------------------
# PostgreSQL Flexible Server (conditional)
# --------------------------
module "postgresql" {
  source = "git::https://github.vodafone.com/vfgroup-aibooster/aibooster-azure-vendor-modules.git//avm_modules/terraform-azurerm-avm-res-dbforpostgresql-flexibleserver-main?ref=main"
  count  = local.env.resources.postgresql.enabled ? 1 : 0

  name                = module.naming.standard["postgresql"]
  resource_group_name = module.resource-group.name
  location            = local.env.location
  tags                = local.tags
}

# --------------------------
# MySQL Flexible Server (conditional)
# --------------------------
module "mysql" {
  source = "git::https://github.vodafone.com/vfgroup-aibooster/aibooster-azure-vendor-modules.git//avm_modules/terraform-azurerm-avm-res-dbformysql-flexibleserver-main?ref=main"

  count = local.env.resources.mysql.enabled ? 1 : 0

  name                = module.naming.standard["mysql"]
  resource_group_name = module.resource-group.name
  location            = local.env.location
  tags                = local.tags
}

# --------------------------
# Cosmos DB (conditional)
# --------------------------
module "cosmosdb" {
  source = "git::https://github.vodafone.com/vfgroup-aibooster/aibooster-azure-vendor-modules.git//avm_modules/terraform-azurerm-avm-res-documentdb-databaseaccount-main?ref=main"
  count  = local.env.resources.cosmosdb.enabled ? 1 : 0

  name                = module.naming.standard["cosmosdb"]
  resource_group_name = module.resource-group.name
  location            = local.env.location
  tags                = local.tags
}

# --------------------------
# Azure Cognitive Search (conditional)
# --------------------------
module "search" {
  source = "git::https://github.vodafone.com/vfgroup-aibooster/aibooster-azure-vendor-modules.git//avm_modules/terraform-azurerm-avm-res-search-searchservice-main?ref=main"

  count = local.env.resources.search.enabled ? 1 : 0

  name                = module.naming.standard["search"]
  resource_group_name = module.resource-group.name
  location            = local.env.location
  tags                = local.tags
}

# --------------------------
# SQL Server (conditional)
# --------------------------
module "sql-server" {
  source = "git::https://github.vodafone.com/vfgroup-aibooster/aibooster-azure-vendor-modules.git//avm_modules/terraform-azurerm-avm-res-sql-server-main?ref=main"
  count  = local.env.resources.sql_server.enabled ? 1 : 0

  name                = module.naming.standard["sql-server"]
  resource_group_name = module.resource-group.name
  location            = local.env.location
  server_version      = local.env.sql_server.server_version
  tags                = local.tags
}

# --------------------------
# SQL Managed Instance (conditional)
# --------------------------
module "sql-managed-instance" {
  source = "git::https://github.vodafone.com/vfgroup-aibooster/aibooster-azure-vendor-modules.git//avm_modules/terraform-azurerm-avm-res-sql-managedinstance-main?ref=main"
  count  = local.env.resources.sql_managed_instance.enabled ? 1 : 0

  name                = module.naming.standard["sql-managed-instance"]
  resource_group_name = module.resource-group.name
  location            = local.env.location

  vcores                       = local.env.sql_managed_instance.vcores
  storage_size_in_gb           = local.env.sql_managed_instance.storage_size_in_gb
  subnet_id                    = local.env.sql_managed_instance.subnet_id
  administrator_login          = local.env.sql_managed_instance.administrator_login
  administrator_login_password = local.env.sql_managed_instance.administrator_login_password
  license_type                 = local.env.sql_managed_instance.license_type
  sku_name                     = local.env.sql_managed_instance.sku_name
  tags                         = local.tags
}

# --------------------------
# ML Workspace (conditional)
# --------------------------
module "ml-workspace" {
  source = "git::https://github.vodafone.com/vfgroup-aibooster/aibooster-azure-vendor-modules.git//avm_modules/terraform-azurerm-avm-res-machinelearningservices-workspace-main?ref=main"
  count  = local.env.resources.ml_workspace.enabled ? 1 : 0

  name                = module.naming.standard["ml-workspace"]
  resource_group_name = module.resource-group.name
  location            = local.env.location
  tags                = local.tags
}

# --------------------------
# AI Foundry (conditional)
# --------------------------
module "ai-foundry" {
  source = "git::https://github.vodafone.com/vfgroup-aibooster/aibooster-azure-vendor-modules.git//avm_modules/terraform-azurerm-avm-ptn-aiml-ai-foundry-main?ref=main"
  count  = local.env.resources.ai_foundry.enabled ? 1 : 0

  base_name                  = module.naming.standard["ai-foundry"]
  resource_group_resource_id = module.resource-group.resource_id
  location                   = local.env.location
  tags                       = local.tags
}
