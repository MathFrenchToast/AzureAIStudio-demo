resource "azurerm_role_assignment" "identity_access_to_ai_services" {
  principal_id = data.azurerm_client_config.current.object_id
  scope        = azurerm_cognitive_account.AIServicesResource.id

  role_definition_name = "Cognitive Services OpenAI User"
}

resource "azurerm_role_assignment" "identity_access_to_ai_search_index" {
  principal_id = data.azurerm_client_config.current.object_id
  scope        = azurerm_search_service.AISearch.id

  role_definition_name = "Search Index Data Contributor"
}

resource "azurerm_role_assignment" "identity_access_to_ai_search" {
  principal_id = data.azurerm_client_config.current.object_id
  scope        = azurerm_search_service.AISearch.id

  role_definition_name = "Search Service Contributor"
}