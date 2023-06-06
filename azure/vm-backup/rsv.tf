resource "azurerm_recovery_services_vault" "rsv" {
  name                = format("RSV-%s", var.virtual_machine_data.virtual_machine_name)
  location            = var.location
  resource_group_name = var.project_resource_group_name
  sku                 = "Standard"

  soft_delete_enabled = true
}

resource "azurerm_backup_policy_vm" "rvp" {
  name                = format("RVP-%s", var.virtual_machine_data.virtual_machine_name)
  resource_group_name = data.azurerm_resource_group.project_rg.name
  recovery_vault_name = azurerm_recovery_services_vault.rsv.name

  timezone = "UTC"

  backup {
    frequency = "Weekly"
    time      = "19:00"
    weekdays  = ["Friday"]
  }

  retention_weekly {
    count    = 10
    weekdays = ["Friday"]
  }
}

resource "azurerm_backup_protected_vm" "bpvm" {
  resource_group_name = data.azurerm_resource_group.project_rg.name
  recovery_vault_name = azurerm_recovery_services_vault.rsv.name
  source_vm_id        = azurerm_linux_virtual_machine.machine_server.id
  backup_policy_id    = azurerm_backup_policy_vm.rvp.id
}
