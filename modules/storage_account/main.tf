locals {
  org = lower(regex_replace(var.organization, "/[^a-z0-9]/", ""))

  # clean client/env strings
  client = lower(regex_replace(var.client, "/[^a-z0-9]/", ""))
  env    = lower(regex_replace(var.environment, "/[^a-z0-9]/", ""))

  # base for storage account name (must be 3-24 chars, lowercase letters and numbers)
  sa_base = "${local.org}${local.client}${local.env}" # we'll truncate and append suffix

  # compute allowed base length (reserve 4 chars for random hex suffix)
  base_max = 20
  sa_base_trunc = substr(local.sa_base, 0, local.base_max)

  # final sa name will be sa_base_trunc + random suffix
}

resource "random_id" "sa_suffix" {
  byte_length = 2   # 2 bytes => 4 hex chars
}

# Resource Group (create if requested)
resource "azurerm_resource_group" "rg" {
  count    = var.create_resource_group ? 1 : 0
  name     = "${local.org}-${local.client}-${local.env}-rg"
  location = var.location
  tags     = merge(var.default_tags, { Client = var.client, Environment = var.environment })
}

# effective resource group name to use
locals {
  effective_rg_name = var.create_resource_group ? azurerm_resource_group.rg[0].name : (
    var.resource_group_name != "" ? var.resource_group_name : "${local.org}-${local.client}-${local.env}-rg"
  )
}

resource "azurerm_storage_account" "sa" {
  name                     = lower("${local.sa_base_trunc}${random_id.sa_suffix.hex}")
  resource_group_name      = local.effective_rg_name
  location                 = var.location
  account_tier             = contains(["Standard"], substr(var.sku_name, 0, 8)) ? "Standard" : "Standard"
  account_replication_type = contains(var.sku_name, "GRS") || contains(var.sku_name, "ZRS") ? var.sku_name : replace(var.sku_name, "Standard_", "")

  # Use StorageV2 for modern features
  kind                     = "StorageV2"

  allow_blob_public_access = false
  min_tls_version          = "TLS1_2"
  enable_https_traffic_only = true

  tags = merge(
    var.default_tags,
    {
      Client      = var.client
      Environment = var.environment
      Org         = var.organization
      CreatedBy   = "terraform-module/storage_account"
    }
  )
}
