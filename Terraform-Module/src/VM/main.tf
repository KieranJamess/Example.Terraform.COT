provider "azurerm" {
  features {}
}

locals {
  prefix = var.prefix
  location = var.location
  resource_group_name = var.resource_group_name
  vm_number = var.vm_number
  resourcesScript = try(file("./terraform-module/vm/resources.ps1"), null)
  base64EncodedScript = base64encode(local.resourcesScript)
}

resource "random_string" "random" {
  count            = local.vm_number
  length           = 6
  special          = false
}

resource "azurerm_availability_set" "winvm_as" {
  name                        = "${local.prefix}-as"
  location                    = local.location
  resource_group_name         = local.resource_group_name
}

resource "azurerm_network_interface" "winvm_nic" {
  count                         = local.vm_number
  name                          = "${local.prefix}-${random_string.random.*.result[count.index]}-nic"
  location                      = local.location
  resource_group_name           = local.resource_group_name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.nic_subnet_id
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "winvm_nic_association" {
  count                   = local.vm_number
  network_interface_id    = azurerm_network_interface.winvm_nic.*.id[count.index]
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = var.backend_address_pool_id
}

resource "azurerm_windows_virtual_machine" "winvm" {
  count                            = local.vm_number
  name                             = "${local.prefix}-${random_string.random.*.result[count.index]}"
  location                         = local.location
  resource_group_name              = local.resource_group_name
  network_interface_ids            = [azurerm_network_interface.winvm_nic.*.id[count.index]]
  size                             = var.vm_size
  admin_username                   = "COTAdminUser"
  admin_password                   = var.machine_password
  availability_set_id              = azurerm_availability_set.winvm_as.id

  secret {
    key_vault_id = var.key_vault_id

    certificate {
      url   = var.certificate
      store = "My"
    }
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = var.vm_sku
    version   = "latest"
  }

  os_disk {
    name                 = "${local.prefix}-${random_string.random.*.result[count.index]}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb         = "128"
  }

  tags = {
    os          = var.vm_sku
    year        = formatdate("YYYY", timestamp())
    month       = formatdate("MM", timestamp())
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_virtual_machine_extension" "install_resources" {
  count                      = local.vm_number
  name                       = "Resources-${local.prefix}${count.index + 1}"
  virtual_machine_id         = azurerm_windows_virtual_machine.winvm.*.id[count.index]
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.9"
  auto_upgrade_minor_version = true
  protected_settings         = <<SETTINGS
  {
   "commandToExecute": "powershell -command \"[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('${local.base64EncodedScript }')) | Out-File -filepath postBuild.ps1\" && powershell -ExecutionPolicy Unrestricted -File postBuild.ps1"
  }
  SETTINGS

  depends_on                 = [azurerm_windows_virtual_machine.winvm]
  lifecycle {
    ignore_changes = [
      type,
      type_handler_version,
      settings,
    ]
  }
}