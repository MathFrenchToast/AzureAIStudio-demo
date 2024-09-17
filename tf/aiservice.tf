
// AzAPI AIServices
/*
resource "azapi_resource" "AIServicesResource"{
  type = "Microsoft.CognitiveServices/accounts@2023-10-01-preview"
  name = "AIServicesResource${random_string.suffix.result}"
  location = azurerm_resource_group.rg.location
  parent_id = azurerm_resource_group.rg.id

  identity {
    type = "SystemAssigned"
  }

  body = jsonencode({
    name = "AIServicesResource${random_string.suffix.result}"
    properties = {
      //restore = true
      customSubDomainName = "${random_string.suffix.result}domain"
        apiProperties = {
            statisticsEnabled = false
        }
    }
    kind = "AIServices"
    sku = {
        name = var.sku
    }
    })

  response_export_values = ["*"]
}
*/

resource "azurerm_cognitive_account" "AIServicesResource" {
  name = "AIServicesResource${random_string.suffix.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = var.aisrv_sku
  kind                = "CognitiveServices"
  identity {
    type = "SystemAssigned"
  }
}


// AzAPI AI Services Connection
resource "azapi_resource" "AIServicesConnection" {
  type = "Microsoft.MachineLearningServices/workspaces/connections@2024-07-01"
  name = "Default_AIServices${random_string.suffix.result}"
  parent_id = azapi_resource.hub.id

  body = jsonencode({
      properties = {
        category = "AIServices",
        target = azurerm_cognitive_account.AIServicesResource.endpoint,
        authType = "AAD",
        isSharedToAll = true,
        metadata = {
          ApiType = "Azure",
          ResourceId = azurerm_cognitive_account.AIServicesResource.id
        }
      }
    })
  response_export_values = ["*"]
}