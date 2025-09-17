# create an object that enumerates each client+env pair
locals {
  client_env_map = {
    for client in local.clients_normalized :
    client => {
      envs = local.envs_normalized
    }
  }
}

# Flatten into a map keyed by "client-env" for for_each
locals {
  client_env_flat = merge([
    for c, v in local.client_env_map :
    {
      for e in v.envs :
      "${c}-${e}" => {
        client      = c
        environment = e
      }
    }
  ]...)
}

module "storage_accounts" {
  source = "./modules/storage_account"

  for_each = local.client_env_flat

  organization = var.organization
  client       = each.value.client
  environment  = each.value.environment
  location     = var.location

  # Pass a resource group name pattern or let module create it
  create_resource_group = true

  # naming/tagging
  default_tags = var.default_tags

  # per-env SKU (fallback to a default if missing)
  sku_name = lookup(var.env_storage_sku, each.value.environment, "Standard_LRS")
}
