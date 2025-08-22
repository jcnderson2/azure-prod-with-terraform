variable "resource_group_name" {
  description = "The name of the Azure Resource Group"
  type        = string
  default     = "prod-rg-1"
}

variable "location" {
  description = "Azure region to deploy resources"
  type        = string
  default     = "EastUS"
}

variable "default_tags" {
  description = "Default tags applied to all resources"
  type        = map(string)
  default = {
    managed-by  = "terraform"
    environment = "dev"
    owner       = "jacob"
  }
}

variable "hub_vnet_name" {
  description = "Name of the Hub Virtual Network"
  type        = string
  default     = "vnet-hub"
}

variable "hub_vnet_cidr" {
  description = "Address space for the Hub VNet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "hub_subnets" {
  description = "Subnets for the Hub VNet"
  type = map(object({
    name           = string
    address_prefix = string
  }))
  default = {
    gateway    = { name = "GatewaySubnet", address_prefix = "10.0.0.0/27" }
    firewall   = { name = "AzureFirewallSN", address_prefix = "10.0.0.32/26" }
    shared     = { name = "snet-shared", address_prefix = "10.0.1.0/24" }
    management = { name = "snet-management", address_prefix = "10.0.2.0/24" }
    data       = { name = "snet-data", address_prefix = "10.0.3.0/24" }
  }
}