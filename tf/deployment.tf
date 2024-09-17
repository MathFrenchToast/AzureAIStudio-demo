resource "azurerm_cognitive_deployment" "model" {
  name                 = "gpt-4"
  cognitive_account_id = azurerm_cognitive_account.AIServicesResource.id
  version_upgrade_option = "OnceNewDefaultVersionAvailable"
  model {
    format  = "OpenAI"
    name    = "gpt-4o-mini"
    # version = "0125-Preview"
  }

  sku {
    name = "Standard"
    tier = "Free"
  }

  rai_policy_name = "Microsoft.DefaultV2"
}