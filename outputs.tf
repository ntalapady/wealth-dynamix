output "storage_accounts" {
  description = "Map of created storage accounts keyed by client-env"
  value = {
    for k, m in module.storage_accounts :
    k => {
      name               = m.storage_account_name
      resource_group     = m.resource_group_name
      id                 = m.storage_account_id
      primary_blob_endpoint = m.primary_blob_endpoint
    }
  }
  sensitive = false
}
