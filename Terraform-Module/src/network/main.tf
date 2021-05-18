provider "azurerm" {
  features {}
}

locals {
  location = var.location
  resource_group_name = var.resource_group_name
  network_name = var.network_name
}

resource "azurerm_virtual_network" "terraform_test_vnet" {
  name                = local.network_name
  location            = local.location
  resource_group_name = local.resource_group_name
  address_space       = [var.address_range]
}

resource "azurerm_subnet" "terraform_test_subnet" {
  name                 = "${local.network_name}-subnet"
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.terraform_test_vnet.name
  address_prefixes     = [var.subnet_range]
}

resource "azurerm_network_security_group" "terraform_test_nsg" {
  name                = "${local.network_name}-nsg"
  location            = local.location
  resource_group_name = local.resource_group_name

  security_rule {
    name                       = "LB_Access"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = azurerm_public_ip.terraform_test_lb_public_ip.ip_address
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "terraform_test_nsg_association" {
  subnet_id                 = azurerm_subnet.terraform_test_subnet.id
  network_security_group_id = azurerm_network_security_group.terraform_test_nsg.id
}

resource "azurerm_public_ip" "terraform_test_lb_public_ip" {
  name                = "${local.network_name}-publicip"
  location            = local.location
  resource_group_name = local.resource_group_name
  allocation_method   = "Static"
}

resource "azurerm_lb" "terraform_test_lb" {
  name                = "${local.network_name}-lb"
  location            = local.location
  resource_group_name = local.resource_group_name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.terraform_test_lb_public_ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "terraform_test_lb_backend" {
  loadbalancer_id = azurerm_lb.terraform_test_lb.id
  name            = "BackEndAddressPool"
}