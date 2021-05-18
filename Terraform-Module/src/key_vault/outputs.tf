output "certificate" {
    value = azurerm_key_vault_certificate.terraform_test_certificate_1.secret_id
}

output "key_vault_id" {
    value = azurerm_key_vault.terraform_test_key_vault.id
}