###############################################
# Module Main Logic
# Creates resource group (optional) and storage account
###############################################

locals {
  # Clean inputs for Azure naming rules
  org    = lower(regex_replace(var.organization, "[^a-z0-9]", ""))
  client = lower(regex_replace(var.client, "[^a-z0-9]", ""))
  env    = lower(regex_replace(var.environment, "[^a-z0-9]", ""))

  # Base name for the storage account
  base_name      = "${local.org}${local.client}${local.env}"
  base_truncated = substr(local.base_name, 0, 20) # Reserve 4 chars for suffix
}

# Random suffix ensures globally unique storage account names
resource "random_id" "suffix" {
  byte_length = 2 # 4 hex chars
}

# Create Resource Group if required
resource "azurerm_resource_group" "rg" {
  count    = var.create_resource_group ? 1 : 0
  name     = "${local.org}-${local.client}-${local.env}-rg"
  location = var.location

  tags = merge(
    var.default_tags,
    {
      Client      = var.client
      Environment = var.environment
    }
  )
}

# Determine the effective resource group name
locals {
  effective_rg_name = var.create_resource_group
    ? azurerm_resource_group.rg[0].name
    : (var.resource_group_name != "" ? var.resource_group_name : "${local.org}-${local.client}-${local.env}-rg")
}

# Create the Storage Account
resource "azurerm_storage_account" "sa" {
  name                     = "${local.base_truncated}${random_id.suffix.hex}"
  resource_group_name      = local.effective_rg_name
  location                 = var.location

  account_tier             = "Standard"
  account_replication_type = replace(var.sku_name, "Standard_", "")

  kind                     = "StorageV2"
  allow_blob_public_access = false
  enable_https_traffic_only = true
  min_tls_version          = "TLS1_2"

  tags = merge(
    var.default_tags,
    {
      Org         = var.organization
      Client      = var.client
      Environment = var.environment
    }
  )
}
