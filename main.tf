terraform {
  required_version = ">= 1.5.0"
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}