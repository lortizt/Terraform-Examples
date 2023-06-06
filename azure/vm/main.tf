provider "azurerm" {
  subscription_id = var.auth_data.subscription_id
  client_id       = var.auth_data.client_id
  client_secret   = var.auth_data.client_secret
  tenant_id       = var.auth_data.tenant_id
  features {
    #
  }
}

terraform {
    #
}
