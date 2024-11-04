
// AzAPI AIServices

resource "azapi_resource" "AIServices"{
  type = "Microsoft.CognitiveServices/accounts@2023-10-01-preview"
  name = "aiservices${random_string.suffix.result}"
  location = azurerm_resource_group.rg.location
  parent_id = azurerm_resource_group.rg.id

  identity {
    type = "SystemAssigned"
  }

  body = {
    name = "aiservices${random_string.suffix.result}"
    properties = {
      //restore = true
      customSubDomainName = "${random_string.suffix.result}domain"
        apiProperties = {
            statisticsEnabled = false
        }
    }
    kind = "AIServices"
    sku = {
        name = var.aisrv_sku
    }
    }

  response_export_values = ["*"]
}


/*
yet to come see: https://github.com/hashicorp/terraform-provider-azurerm/issues/25858
resource "azurerm_cognitive_account" "AIServices" {
  name = "AIServices${random_string.suffix.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = var.aisrv_sku
  kind                = "AIServices"
  identity {
    type = "SystemAssigned"
  }
}
*/


// AzAPI AI Services Connection
resource "azapi_resource" "AIServicesConnection" {
  type = "Microsoft.MachineLearningServices/workspaces/connections@2024-07-01-preview"
  name = "Default_AIServices${random_string.suffix.result}"
  parent_id = azapi_resource.hub.id

  body = {
      properties = {
        category = "AIServices",
        target = azapi_resource.AIServices.output.properties.endpoint,
        authType = "AAD",
        isSharedToAll = true,
        metadata = {
          ApiType = "Azure",
          ResourceId = azapi_resource.AIServices.id
        }
      }
    }
  response_export_values = ["*"]
}

