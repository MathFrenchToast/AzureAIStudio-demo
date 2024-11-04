# automaticaly registered by azure rm provider
/*
resource "azurerm_resource_provider_registration" "webprovider" {
  name  = "Microsoft.Web"
}
*/

# Create the App Service Plan
/*
resource "azurerm_service_plan" "asp" {
  name                = "chat-playground-asp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name = "F1"
}


# Create the web app
resource "azurerm_linux_web_app" "webapp" {
  name                = "chat-playground"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.asp.id
  https_only          = true

  site_config {
    linux_fx_version = "DOCKER|azure-samples/chat-playground:latest"
  }

   app_settings = {
    "MODEL_ENDPOINT"   = "https://your-model-endpoint-url"
    "MODEL_API_KEY"    = "your-api-key"
  }

  identity {
    type = "SystemAssigned"
  }
}
*/