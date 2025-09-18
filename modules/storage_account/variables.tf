###############################################
# Module Variables
###############################################

variable "organization" {
  description = "Organization prefix for naming."
  type        = string
}

variable "client" {
  description = "Client identifier."
  type        = string
}

variable "environment" {
  description = "Environment name (dev, test, staging, prod, etc.)."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
  default     = "uksouth"
}

variable "create_resource_group" {
  description = "Whether to create a new resource group or use an existing one."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "Optional: Name of an existing resource group to use."
  type        = string
  default     = ""
}

variable "sku_name" {
  description = "Storage account SKU (Standard_LRS, Standard_GRS, etc.)."
  type        = string
  default     = "Standard_LRS"
}

variable "default_tags" {
  description = "Default tags for all resources."
  type        = map(string)
  default     = {}
}
