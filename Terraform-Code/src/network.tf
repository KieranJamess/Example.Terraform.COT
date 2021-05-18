resource "azurerm_resource_group" "terraform_example_networking" {
  name     = "${local.terraform_example_name}-networking"
  location = local.terraform_example_location
}

module "network" {
  source                          = "./terraform-module/network"
  location                        = local.terraform_example_location
  resource_group_name             = azurerm_resource_group.terraform_example_networking.name
  network_name                    = "COT-Network"
  address_range                   = "10.0.0.0/16"
  subnet_range                    = "10.0.1.0/24"
}