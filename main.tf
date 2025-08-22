terraform {
  required_version = ">= 1.5.0"
}

module "rg_main" {
  source   = "./modules/prod-rg-1"
  name     = "prod-rg-1"
  location = "eastus"

  tags = {
    Env        = "dev"
    managed-by = "terraform"
  }
}