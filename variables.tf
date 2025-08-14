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