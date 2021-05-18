resource "azurerm_resource_group" "terraform_example_key_vault" {
  name     = "${local.terraform_example_name}-key_vault"
  location = local.terraform_example_location
}

module "key_vault" {
  source                          = "./terraform-module/key_vault"
  location                        = local.terraform_example_location
  resource_group_name             = azurerm_resource_group.terraform_example_key_vault.name
  key_vault_name                  = "COT-KeyVault"
  cert_subject                    = "CN=Test"
  cert_name                       = "COT-Cert"
}