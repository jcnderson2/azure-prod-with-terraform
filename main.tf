terraform {
  required_version = ">= 1.5.0"
}

module "rg_main" {
  source   = "./modules/resource-group"
  name     = "prod-rg-1"
  location = "eastus"
}

module "hub_vnet" {
  source         = "./modules/vnet-hub"
  location       = var.location
  vnet_name      = var.hub_vnet_name
  address_space  = var.hub_vnet_cidr
  subnets        = var.hub_subnets
  resource_group = module.rg_main.name
}

module "spoke_vnets" {
  source         = "./modules/vnet-spoke"
  for_each       = var.spoke_vnets
  location       = var.location
  vnet_name      = each.value.name
  address_space  = each.value.address_space
  subnets        = each.value.subnets
  resource_group = module.rg_main.name
}

module "vnet_peering" {
  source         = "./modules/vnet-peering"
  hub_vnet_id    = module.hub_vnet.hub_vnet_id
  hub_vnet_name  = var.hub_vnet_name
  spoke_vnets    = {
    for k, v in module.spoke_vnets :
    k => { name = v.spoke_vnet_name, vnet_id = v.spoke_vnet_id }
  }
  resource_group = module.rg_main.name
}