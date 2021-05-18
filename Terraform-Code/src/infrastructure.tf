resource "azurerm_resource_group" "terraform_example_infrastructure" {
  name     = "${local.terraform_example_name}-infrastructure"
  location = local.terraform_example_location
}

module "VMs" {
  source                          = "./terraform-module/vm"
  location                        = local.terraform_example_location
  resource_group_name             = azurerm_resource_group.terraform_example_infrastructure.name
  backend_address_pool_id         = module.network.lb_backend_address_pool_id
  machine_password                = "KieranTestyTest1"
  nic_subnet_id                   = module.network.subnet_id
  prefix                          = "COT-svr"
  vm_number                       = "2"
  vm_size                         = "standard_DS1_v2"
  vm_sku                          = "2019-Datacenter"
  certificate                     = module.key_vault.certificate
  key_vault_id                    = module.key_vault.key_vault_id
}