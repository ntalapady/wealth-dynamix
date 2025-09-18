###############################################
# Module Outputs
###############################################

output "storage_account_name" {
  description = "The name of the storage account."
  value       = azurerm_storage_account.sa.name
}

output "storage_account_id" {
  description = "The ID of the storage account."
  value       = azurerm_storage_account.sa.id
}

output "resource_group_name" {
  description = "The name of the resource group used."
  value       = local.effective_rg_name
}

output "primary_blob_endpoint" {
  description = "The primary blob endpoint of the storage account."
  value       = azurerm_storage_account.sa.primary_blob_endpoint
}
