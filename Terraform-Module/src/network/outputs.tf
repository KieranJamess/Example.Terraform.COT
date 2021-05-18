output "lb_backend_address_pool_id" {
    value = azurerm_lb_backend_address_pool.terraform_test_lb_backend.id
}

output "subnet_id" {
    value = azurerm_subnet.terraform_test_subnet.id
}