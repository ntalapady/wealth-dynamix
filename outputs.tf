###############################################
# Root Outputs
###############################################

output "storage_accounts" {
  description = "Map of created storage accounts keyed by client-environment pair."

  value = {
    for key, module in module.storage_accounts :
    key => {
      name               = module.storage_account_name
      resource_group     = module.resource_group_name
      id                 = module.storage_account_id
      primary_blob_url   = module.primary_blob_endpoint
    }
  }
}
