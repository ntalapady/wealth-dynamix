variable "organization" {
  description = "Short organization prefix (used in naming). Lowercase, alphanumeric only recommended."
  type        = string
  default     = "acme"
}

variable "clients" {
  description = "List of client identifiers. Example: [\"clienta\",\"clientb\"]"
  type        = list(string)
}

variable "environments" {
  description = "List of environments to create storage accounts for (e.g. dev,test,staging,prod)."
  type        = list(string)
  default     = ["dev","test","staging","prod"]
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "uksouth"
}

variable "default_tags" {
  description = "Tags applied to every resource (merged with client/env tags)"
  type        = map(string)
  default     = {
    ManagedBy = "terraform"
    Project   = "multi-client-storage"
  }
}

# Optional SKU/replication per environment (you can extend)
variable "env_storage_sku" {
  description = "Map of environment -> sku (Standard_LRS etc.)"
  type        = map(string)
  default     = {
    dev     = "Standard_LRS"
    test    = "Standard_LRS"
    staging = "Standard_GRS"
    prod    = "Standard_GRS"
  }
}
