resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.project_resource_group_name
}

resource "azurerm_subnet" "example" {
  name                 = "internal"
  resource_group_name  = var.project_resource_group_name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "internal_net_interface" {
  name                = format("NIC-%s", var.virtual_machine_data.virtual_machine_name)
  resource_group_name = var.project_resource_group_name
  location            = var.location

  ip_configuration {
    name                          = "internal_static_ip"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.private_ip_address
  }
}

resource "azurerm_network_security_group" "nsg" {
  name                = format("NSG-%s", var.virtual_machine_data.virtual_machine_name)
  location            = var.location
  resource_group_name = var.project_resource_group_name
}

resource "azurerm_network_interface_security_group_association" "nsg_association" {
  network_interface_id      = azurerm_network_interface.internal_net_interface.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
