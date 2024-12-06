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

resource "azurerm_function_app" "example" {
  name                       = "example-function-app"
  location                   = azurerm_storage_account.example.location
  resource_group_name        = azurerm_storage_account.example.resource_group_name
  app_service_plan_id        = azurerm_app_service_plan.example.id
  storage_account_name       = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key
  os_type                    = "Windows"
  runtime_stack              = "dotnet"

  // Misconfiguration 1: High severity - HTTPS only should be enabled
  https_only = false

  // Misconfiguration 2: Medium severity - FTPS should be required
  ftps_state = "Disabled"

  // Misconfiguration 3: Low severity - Remote debugging should be disabled
  remote_debugging_enabled = true

  tags = {
    BU    = "Cloud"
    Owner = "Lorenzo Nardi"
    App   = "DefenderDemoEnv"
  }
}

resource "azurerm_app_service_plan" "example" {
  name                = "example-app-service-plan"
  location            = azurerm_storage_account.example.location
  resource_group_name = azurerm_storage_account.example.resource_group_name
  sku {
    tier = "Standard"
    size = "S1"
  }

  tags = {
    BU    = "Cloud"
    Owner = "Lorenzo Nardi"
    App   = "DefenderDemoEnv"
  }
}