provider "azurerm" {
  features {}
  version = "=4.20.0"
}

# Data source to reference the existing resource group
data "azurerm_resource_group" "example" {
  name = "PrismaCloudDemoEnv"
}

# Example resource using the existing resource group
resource "azurerm_storage_account" "example" {
  name                     = "teststorageacc0"
  resource_group_name      = data.azurerm_resource_group.example.name
  location                 = data.azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  https_traffic_only_enabled  = "false" # misconfiguration
  min_tls_version = "TLS1_0" # misconfiguration
  
  tags = {
    owner = "Lorenzo Nardi"
  }
}
