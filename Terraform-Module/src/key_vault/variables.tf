variable "key_vault_name" {
  description = "Name of the key vault"
}

variable "location" {
  description = "Location of resources"
}

variable "resource_group_name" {
  description = "Resource group for the resources to be created in"
}

variable "cert_subject" {
  description = "The subject for the Cert"
}

variable "cert_name" {
  description = "The name of the Cert"
}
