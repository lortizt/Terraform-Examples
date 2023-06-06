resource "azurerm_linux_virtual_machine" "machine_server" {
  resource_group_name             = var.project_resource_group_name
  name                            = var.virtual_machine_data.virtual_machine_name
  location                        = var.location
  size                            = "Standard_F2"
  admin_username                  = var.virtual_machine_data.virtual_machine_username
  admin_password                  = var.virtual_machine_data.virtual_machine_password
  disable_password_authentication = false
  computer_name                   = var.virtual_machine_data.virtual_machine_name

  network_interface_ids = [
    azurerm_network_interface.internal_net_interface.id,
  ]

  source_image_reference {
    publisher = var.source_vm_image_reference.publisher
    offer     = var.source_vm_image_reference.offer
    sku       = var.source_vm_image_reference.sku
    version   = var.source_vm_image_reference.version
  }
}
