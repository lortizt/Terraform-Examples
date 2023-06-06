# Auth data
variable "auth_data" {
  type        = map(string)
  description = "Auth data used by azurerm provider"
  default = {
    subscription_id = ""
    client_id       = ""
    client_secret   = ""
    tenant_id       = ""
  }
}

variable "location" {
  default = "West Europe"
}

# General data used by multiple resources
variable "project_resource_group_name" {
  type    = string
  default = "rg-test"
}

# Network configuration
variable "private_ip_address" {}

# Virtual machine configuration
variable "virtual_machine_data" {
  type        = map(string)
  description = "Virtual machine base config data"
  default = {
    virtual_machine_name     = ""
    virtual_machine_username = ""
    virtual_machine_password = ""
  }
}

# use 'az image list' to get the main results
variable "source_vm_image_reference" {
  type = map(string)
  default = {
    publisher = ""
    offer     = ""
    sku       = ""
    version   = ""
  }
}

# Storage configuration
variable "vm_os_disk" {
  type = map(string)
  default = {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
    disk_size_gb         = "200"
  }
}
