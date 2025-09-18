###############################################
# Root Main File
# Iterates through client/environment combinations
###############################################

# For each client-environment pair, create one storage account
module "storage_accounts" {
  source = "./modules/storage_account"

  for_each = local.client_env_flat

  organization          = var.organization
  client                = each.value.client
  environment           = each.value.environment
  location              = var.location
  create_resource_group = true

  default_tags = var.default_tags

  # Select SKU based on environment mapping
  sku_name = lookup(var.env_storage_sku, each.value.environment, "Standard_LRS")
}