provider "azurerm" {
  features {}
}

# Data source to reference the existing resource group
data "azurerm_resource_group" "example" {
  name = "PrismaCloudDemoEnv"
}

resource "azurerm_storage_account" "example" {
  name                     = "examplestorageacct"
  resource_group_name      = data.azurerm_resource_group.example.name
  location                 = data.azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  // Misconfiguration 1: High severity - Blob public access should be disabled
  enable_blob_public_access = true

  // Misconfiguration 2: Medium severity - Minimum TLS version should be set to 1.2
  min_tls_version = "TLS1_0"

  // Misconfiguration 3: Low severity - HTTPS traffic only should be enabled
  enable_https_traffic_only = false

  tags = {
    Owner = "Lorenzo Nardi"
    App   = "PrismaAppSecurity"
  }
}
