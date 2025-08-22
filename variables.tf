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
    firewall   = { name = "AzureFirewallSN", address_prefix = "10.0.0.64/26" }
    shared     = { name = "snet-shared", address_prefix = "10.0.1.0/24" }
    management = { name = "snet-management", address_prefix = "10.0.2.0/24" }
    data       = { name = "snet-data", address_prefix = "10.0.3.0/24" }
  }
}

variable "spoke_vnets" {
  description = "Map of spoke VNets with address spaces and subnets"
  type = map(object({
    name          = string
    address_space = list(string)
    subnets = map(object({
      name           = string
      address_prefix = string
    }))
  }))
  default = {
    spoke1 = {
      name          = "vnet-spoke1"
      address_space = ["10.1.0.0/16"]
      subnets = {
        app = { name = "snet-app", address_prefix = "10.1.0.0/24" }
        db  = { name = "snet-db", address_prefix = "10.1.1.0/24" }
      }
    }
    spoke2 = {
      name          = "vnet-spoke2"
      address_space = ["10.2.0.0/16"]
      subnets = {
        web = { name = "snet-web", address_prefix = "10.2.0.0/24" }
      }
    }
    spoke3 = {
      name          = "vnet-spoke3"
      address_space = ["10.3.0.0/16"]
      subnets = {
        batch = { name = "snet-batch", address_prefix = "10.3.0.0/24" }
      }
    }
  }
}