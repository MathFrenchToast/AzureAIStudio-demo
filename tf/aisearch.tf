resource "azurerm_search_service" "AISearch" {
  name                = "aisearch${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = var.aisearch_sku
  replica_count       = var.aisearch_replica_count
  partition_count     = var.aisearch_partition_count

  # enable both keys and endpoints, for az cli and deployment 
  local_authentication_enabled = true   
  authentication_failure_mode = "http403"
}

resource "azapi_resource" "AISearchConnection" {
  type      = "Microsoft.MachineLearningServices/workspaces/connections@2024-07-01-preview"
  name      = "my-ai-search-services"
  parent_id = azapi_resource.project.id

  body = {
    properties = {
      category      = "CognitiveSearch",  # value inherited from older name of 'ai search'
      target        = "https://${azurerm_search_service.AISearch.name}.search.windows.net"
      # authType      = "AAD",
      authType = "ApiKey",
      credentials = {
           key= azurerm_search_service.AISearch.primary_key
        },
      isSharedToAll = true,
      metadata = {
        ApiType    = "Azure",
        ResourceId = azurerm_search_service.AISearch.id
      }
    }
  }
  response_export_values = ["*"]
}