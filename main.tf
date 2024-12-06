provider "azurerm" {
  features {}
}

resource "azurerm_storage_account" "example" {
  name                     = "examplestorageacc"
  resource_group_name      = "Defender-demo-env"
  location                 = "West Europe"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  // Misconfiguration 1: High severity - Blob public access should be disabled
  enable_blob_public_access = true

  // Misconfiguration 2: Medium severity - Minimum TLS version should be set to 1.2
  min_tls_version = "TLS1_0"

  // Misconfiguration 3: Low severity - HTTPS traffic only should be enabled
  enable_https_traffic_only = false

  tags = {
    BU    = "Cloud"
    Owner = "Lorenzo Nardi"
    App   = "DefenderDemoEnv"
  }
}