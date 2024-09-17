# adapted from: https://learn.microsoft.com/en-us/azure/search/search-get-started-terraform
resource "random_string" "azurerm_search_service_name" {
  length  = 25
  upper   = false
  numeric = false
  special = false
}

resource "azurerm_search_service" "AISearch" {
  name                = random_string.azurerm_search_service_name.result
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = var.sku
  replica_count       = var.replica_count
  partition_count     = var.partition_count

  local_authentication_enabled = true # enable both keys and endpoints, for az cli and deployment 
}

resource "azapi_resource" "AISearchConnection" {
  type      = "Microsoft.MachineLearningServices/workspaces/connections@2024-07-01"
  name      = "my-ai-search-services"
  parent_id = azapi_resource.project.id

  body = jsonencode({
    properties = {
      category      = "CognitiveSearch",  # value inherited from older name of 'ai search'
      target        = "https://${azurerm_search_service.AISearch.name}.search.windows.net"
      authType      = "AAD",
      isSharedToAll = true,
      metadata = {
        ApiType    = "Azure",
        ResourceId = azurerm_search_service.AISearch.id
      }
    }
  })
  response_export_values = ["*"]
}