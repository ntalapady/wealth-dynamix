variable "organization" {
  type = string
}

variable "client" {
  type = string
}

variable "environment" {
  type = string
}

variable "location" {
  type    = string
  default = "uksouth"
}

variable "create_resource_group" {
  type    = bool
  default = true
}

variable "resource_group_name" {
  type    = string
  default = ""
  description = "If provided and create_resource_group = false, module will use this existing RG name."
}

variable "sku_name" {
  type    = string
  default = "Standard_LRS"
  description = "Storage account sku_name (Standard_LRS, Standard_GRS, etc.)"
}

variable "default_tags" {
  type = map(string)
  default = {}
}
