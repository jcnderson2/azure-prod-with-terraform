variable "rg_name" {
  description = "Resource group for firewall"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "firewall_subnet_id" {
  description = "Subnet ID for the Azure Firewall"
  type        = string
}