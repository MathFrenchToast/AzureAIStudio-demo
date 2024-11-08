// Azure AI Hub
resource "azapi_resource" "hub" {
  type = "Microsoft.MachineLearningServices/workspaces@2024-07-01-preview"
  name = "my-ai-hub${random_string.suffix.result}"
  location = azurerm_resource_group.rg.location
  parent_id = azurerm_resource_group.rg.id

  identity {
    type = "SystemAssigned"
  }

  body = {
    properties = {
      description = "This is my Azure AI hub"
      friendlyName = "My Hub"
      storageAccount = azurerm_storage_account.default.id
      keyVault = azurerm_key_vault.default.id

      /* Optional: To enable these field, the corresponding dependent resources need to be uncommented.
      applicationInsight = azurerm_application_insights.default.id
      containerRegistry = azurerm_container_registry.default.id
      */

      /*Optional: To enable Customer Managed Keys, the corresponding 
      encryption = {
        status = var.encryption_status
        keyVaultProperties = {
            keyVaultArmId = azurerm_key_vault.default.id
            keyIdentifier = var.cmk_keyvault_key_uri
        }
      }
      */
      
    }
    kind = "hub"
  }
}

// Azure AI Project
resource "azapi_resource" "project" {
  type = "Microsoft.MachineLearningServices/workspaces@2024-07-01-preview"
  name = "my-ai-project${random_string.suffix.result}"
  location = azurerm_resource_group.rg.location
  parent_id = azurerm_resource_group.rg.id

  identity {
    type = "SystemAssigned"
  }

  body = {
    properties = {
      description = "This is my Azure AI PROJECT"
      friendlyName = "My_Project" # no space allowed
      hubResourceId = azapi_resource.hub.id
    }
    kind = "project"
  }
}