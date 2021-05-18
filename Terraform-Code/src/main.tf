terraform {
  backend "azurerm" {
    storage_account_name = "cottfstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    access_key           = "XXXXX"
  }
}

locals {
  terraform_example_name     = "COT-kjtf"
  terraform_example_location = "westeurope"
}