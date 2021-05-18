variable "backend_address_pool_id" {
  description = "ID Of backend address pool"
}

variable "location" {
  description = "Location of resources"
}

variable "machine_password" {
  description = "Password for the machines being created"
}

variable "nic_subnet_id" {
  description = "Subnet ID for the NICs to be created in"
}

variable "prefix" {
  description = "Prefix for VMs, Nics and disks"
}

variable "resource_group_name" {
  description = "Resource group for the resources to be created in"
}

variable "vm_number" {
  description = "number of VMs to create"
  validation {
    condition     = can(regex("^[0-9]+$", var.vm_number))
    error_message = "VM Number can only be a number!"
  }
}

variable "vm_size" {
  description = "Size of VM"
}

variable "vm_sku" {
  description = "Sku of VM"
}

variable "key_vault_id" {
  description = "ID of the key vault the certificate sits in"
}

variable "certificate" {
  description = "certificate ID that needs to be added that is in the key vault referenced above"
}

