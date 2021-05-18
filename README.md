# Example.Terraform.COT

## Tools Used

Terraform Readme generator - found [here](https://github.com/terraform-docs/terraform-docs)

Terraform Variable generator - found [here](https://github.com/alexandrst88/terraform-variables-generator)

## File Structure

```
Terraform
├── ModuleRepo
├── Terraform-Code
│   ├── build
│   │   └── build_module.ps1
│   ├── src
│   │   ├── infrastructure.tf
│   │   ├── key_vault.tf
│   │   ├── main.tf
│   │   ├── network.tf
│   │   └── provider.tf
│   └── test
│       └── tfvalidate.ps1
├── Terraform-Module
│   ├── build
│   │   └── terraform-module.nuspec
│   └── src
│       ├── key_vault
│       │   ├── main.tf
│       │   ├── outputs.tf
│       │   └── variables.tf
│       ├── network
│       │   ├── main.tf
│       │   ├── outputs.tf
│       │   └── variables.tf
│       └── VM
│           ├── main.tf
│           ├── resources.ps1
│           └── variables.tf
├── .gitignore
└── README.md
```

## Packaging the modules

The modules are packaged using nuget. This creates a local nupkg file stored in it's directory which is then referenced to install the modules for terraform to use. 

There is a nuspec file located in the terraform-module directory which is used to package up the required files.

## Installing the modules

To use this repo, you'll need to install the terraform modules. If you run the `build_module.ps1` file in `terraform-code\build` it will install the terraform modules into the correct directory under src ready for the terraform code to reference. You will need to do this **before** your `terraform init`. 

There is also a `tfvalidate` file in the test directory to run a couple of tests on your terraform code to ensure the configuration is good. 

## Requirements

| Name                                                         | Version |
| ------------------------------------------------------------ | ------- |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>2.0   |

## Providers

| Name                                                         | Version |
| ------------------------------------------------------------ | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~>2.0   |

## Modules

| Name                                                         | Source                       | Version |
| ------------------------------------------------------------ | ---------------------------- | ------- |
| <a name="module_VMs"></a> [VMs](#module\_VMs)                | ./terraform-module/vm        |         |
| <a name="module_key_vault"></a> [key\_vault](#module\_key\_vault) | ./terraform-module/key_vault |         |
| <a name="module_network"></a> [network](#module\_network)    | ./terraform-module/network   |         |

## Resources

| Name                                                         | Type     |
| ------------------------------------------------------------ | -------- |
| [azurerm_resource_group.terraform_example_infrastructure](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.terraform_example_key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.terraform_example_networking](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

No outputs.



# Module.Key_vault

This module creates a key vault that also generates a certificate that is used in the infrastructure module.

## Requirements

No requirements.

## Providers

| Name                                                         | Version |
| ------------------------------------------------------------ | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a     |

## Modules

No modules.

## Resources

| Name                                                         | Type        |
| ------------------------------------------------------------ | ----------- |
| [azurerm_key_vault.terraform_test_key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource    |
| [azurerm_key_vault_certificate.terraform_test_certificate_1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_certificate) | resource    |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name                                                         | Description                                       | Type  | Default | Required |
| ------------------------------------------------------------ | ------------------------------------------------- | ----- | ------- | :------: |
| <a name="input_cert_name"></a> [cert\_name](#input\_cert\_name) | The name of the Cert                              | `any` | n/a     |   yes    |
| <a name="input_cert_subject"></a> [cert\_subject](#input\_cert\_subject) | The subject for the Cert                          | `any` | n/a     |   yes    |
| <a name="input_key_vault_name"></a> [key\_vault\_name](#input\_key\_vault\_name) | Name of the key vault                             | `any` | n/a     |   yes    |
| <a name="input_location"></a> [location](#input\_location)   | Location of resources                             | `any` | n/a     |   yes    |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group for the resources to be created in | `any` | n/a     |   yes    |

## Outputs

| Name                                                         | Description |
| ------------------------------------------------------------ | ----------- |
| <a name="output_certificate"></a> [certificate](#output\_certificate) | n/a         |
| <a name="output_key_vault_id"></a> [key\_vault\_id](#output\_key\_vault\_id) | n/a         |

# Module.network

This module creates Virtual network with a subnet which has a NSG attached to it. It creates a Public IP address and creates a load balancer with the public IP address to act as the front end configuration.

## Requirements

No requirements.

## Providers

| Name                                                         | Version |
| ------------------------------------------------------------ | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a     |

## Modules

No modules.

## Resources

| Name                                                         | Type     |
| ------------------------------------------------------------ | -------- |
| [azurerm_lb.terraform_test_lb](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb) | resource |
| [azurerm_lb_backend_address_pool.terraform_test_lb_backend](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool) | resource |
| [azurerm_network_security_group.terraform_test_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_public_ip.terraform_test_lb_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_subnet.terraform_test_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.terraform_test_nsg_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_virtual_network.terraform_test_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name                                                         | Description                                       | Type  | Default | Required |
| ------------------------------------------------------------ | ------------------------------------------------- | ----- | ------- | :------: |
| <a name="input_address_range"></a> [address\_range](#input\_address\_range) | address range for the VNET                        | `any` | n/a     |   yes    |
| <a name="input_location"></a> [location](#input\_location)   | Location of resources                             | `any` | n/a     |   yes    |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | Name for the VNET                                 | `any` | n/a     |   yes    |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group for the resources to be created in | `any` | n/a     |   yes    |
| <a name="input_subnet_range"></a> [subnet\_range](#input\_subnet\_range) | address range for the subnet                      | `any` | n/a     |   yes    |

## Outputs

| Name                                                         | Description |
| ------------------------------------------------------------ | ----------- |
| <a name="output_lb_backend_address_pool_id"></a> [lb\_backend\_address\_pool\_id](#output\_lb\_backend\_address\_pool\_id) | n/a         |
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | n/a         |



# Module.VM

This module creates a defined amount of virtual machines that sits the load balancer created in the networking module. There is a custom script that is ran on each virtual machine to install chocolatey and IIS, along with some further additions. 

## Requirements

No requirements.

## Providers

| Name                                                         | Version |
| ------------------------------------------------------------ | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a     |
| <a name="provider_random"></a> [random](#provider\_random)   | n/a     |

## Modules

No modules.

## Resources

| Name                                                         | Type     |
| ------------------------------------------------------------ | -------- |
| [azurerm_availability_set.winvm_as](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/availability_set) | resource |
| [azurerm_network_interface.winvm_nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface_backend_address_pool_association.winvm_nic_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_backend_address_pool_association) | resource |
| [azurerm_virtual_machine_extension.install_resources](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_windows_virtual_machine.winvm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name                                                         | Description                                                  | Type  | Default | Required |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ----- | ------- | :------: |
| <a name="input_backend_address_pool_id"></a> [backend\_address\_pool\_id](#input\_backend\_address\_pool\_id) | ID Of backend address pool                                   | `any` | n/a     |   yes    |
| <a name="input_certificate"></a> [certificate](#input\_certificate) | certificate ID that needs to be added that is in the key vault referenced above | `any` | n/a     |   yes    |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | ID of the key vault the certificate sits in                  | `any` | n/a     |   yes    |
| <a name="input_location"></a> [location](#input\_location)   | Location of resources                                        | `any` | n/a     |   yes    |
| <a name="input_machine_password"></a> [machine\_password](#input\_machine\_password) | Password for the machines being created                      | `any` | n/a     |   yes    |
| <a name="input_nic_subnet_id"></a> [nic\_subnet\_id](#input\_nic\_subnet\_id) | Subnet ID for the NICs to be created in                      | `any` | n/a     |   yes    |
| <a name="input_prefix"></a> [prefix](#input\_prefix)         | Prefix for VMs, Nics and disks                               | `any` | n/a     |   yes    |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group for the resources to be created in            | `any` | n/a     |   yes    |
| <a name="input_vm_number"></a> [vm\_number](#input\_vm\_number) | number of VMs to create                                      | `any` | n/a     |   yes    |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size)    | Size of VM                                                   | `any` | n/a     |   yes    |
| <a name="input_vm_sku"></a> [vm\_sku](#input\_vm\_sku)       | Sku of VM                                                    | `any` | n/a     |   yes    |

## Outputs

No outputs.