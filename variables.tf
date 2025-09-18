###############################################
# Root-level Variables
# These variables define the inputs for this solution
###############################################

# Organization short code for naming convention
variable "organization" {
  description = "Short prefix for the organization (used in resource naming)."
  type        = string
  default     = "acme"
}

# List of client identifiers
variable "clients" {
  description = "List of client identifiers."
  type        = list(string)
}

# List of environments to deploy (dev, test, staging, prod, etc.)
variable "environments" {
  description = "List of environments to create resources for."
  type        = list(string)
  default     = ["dev", "test", "staging", "prod"]
}

# Azure location for resource deployment
variable "location" {
  description = "Azure region where all resources will be created."
  type        = string
  default     = "uksouth"
}

# Common tags applied to every resource
variable "default_tags" {
  description = "A map of default tags applied to all resources."
  type        = map(string)
  default     = {
    ManagedBy = "terraform"
    Project   = "multi-client-storage"
  }
}

# Optional: Define different storage SKUs per environment
# Example: dev/test use LRS, staging/prod use GRS
variable "env_storage_sku" {
  description = "Mapping of environment to SKU for storage account."
  type        = map(string)
  default     = {
    dev     = "Standard_LRS"
    test    = "Standard_LRS"
    staging = "Standard_GRS"
    prod    = "Standard_GRS"
  }
}
