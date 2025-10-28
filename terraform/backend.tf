terraform {
  backend "azurerm" {
    resource_group_name  = "wordpress-rg"
    storage_account_name = "tfstateayomide"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

