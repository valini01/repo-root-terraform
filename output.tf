output "resource_group_name" {
  value = module.resource-group.name
}

# output "storage_account_name" {
#   value = local.env.resources.storage_account.enabled ? module.storage-account[0].name : null
# }

# output "key_vault_name" {
#   value = local.env.resources.key_vault.enabled ? module.key-vault[0].name : null
# }
