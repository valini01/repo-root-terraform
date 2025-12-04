output "resource_group_name" {
  value = module.resource-group.name
}

output "key_vault_name" {
  value       = local.env.resources.key_vault.enabled ? module.key-vault[0].name : null
  description = "Deployed Key Vault name (null when disabled)."
}

output "storage_account_name" {
  value       = local.env.resources.storage_account.enabled ? module.storage-account[0].name : null
  description = "Deployed Storage Account name (null when disabled)."
}

output "api_management_name" {
  value       = local.env.resources.api_management.enabled ? module.api-management[0].name : null
  description = "API Management name (null when disabled)."
}

output "containerapp_name" {
  value       = local.env.resources.containerapp.enabled ? module.containerapp[0].name : null
  description = "Container App name (null when disabled)."
}

output "aks_name" {
  value       = local.env.resources.aks.enabled ? module.aks[0].name : null
  description = "AKS cluster name (null when disabled)."
}

output "postgresql_name" {
  value       = local.env.resources.postgresql.enabled ? module.postgresql[0].name : null
  description = "PostgreSQL Flexible Server name (null when disabled)."
}

output "mysql_name" {
  value       = local.env.resources.mysql.enabled ? module.mysql[0].name : null
  description = "MySQL Flexible Server name (null when disabled)."
}

output "cosmosdb_name" {
  value       = local.env.resources.cosmosdb.enabled ? module.cosmosdb[0].name : null
  description = "Cosmos DB account name (null when disabled)."
}

output "search_name" {
  value       = local.env.resources.search.enabled ? module.search[0].name : null
  description = "Azure Cognitive Search service name (null when disabled)."
}

output "sql_server_name" {
  value       = local.env.resources.sql_server.enabled ? module.sql-server[0].name : null
  description = "SQL Server name (null when disabled)."
}

output "sql_managed_instance_name" {
  value       = local.env.resources.sql_managed_instance.enabled ? module.sql-managed-instance[0].name : null
  description = "SQL Managed Instance name (null when disabled)."
}

output "ml_workspace_name" {
  value       = local.env.resources.ml_workspace.enabled ? module.ml-workspace[0].name : null
  description = "ML Workspace name (null when disabled)."
}

output "ai_foundry_name" {
  value       = local.env.resources.ai_foundry.enabled ? module.ai-foundry[0].name : null
  description = "AI Foundry name (null when disabled)."
}

output "effective_tags" {
  value       = local.tags
  description = "Unified tags applied to all resources/modules."
}
