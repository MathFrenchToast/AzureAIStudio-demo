resource "azurerm_cognitive_deployment" "model" {
  name                 = "gpt-4o-mini"  # reusing same name as model to ease the migration from openai to azure openai
  cognitive_account_id = azapi_resource.AIServices.id
  version_upgrade_option = "OnceNewDefaultVersionAvailable"
  model {
    format  = "OpenAI"
    name    = "gpt-4o-mini"
  }

  sku {
    name = "Standard"
    # documented https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_deployment
    # but generate an error as for v4.2
    # tier = "Free"
  }

  rai_policy_name = "Microsoft.DefaultV2"
}

resource "azurerm_cognitive_deployment" "model-embedding" {
  name                 = "text-embedding-ada-002"
  cognitive_account_id = azapi_resource.AIServices.id
  version_upgrade_option = "OnceNewDefaultVersionAvailable"
  model {
    format  = "OpenAI"
    name    = "text-embedding-ada-002"
    # version = "0125-Preview"
  }

  sku {
    name = "Standard"
    # documented https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_deployment
    # but generate an error as for v4.2
    # tier = "Free"
  }

  rai_policy_name = "Microsoft.DefaultV2"
}
