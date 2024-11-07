resource "azurerm_role_assignment" "identity_access_to_ai_services" {
  principal_id = data.azurerm_client_config.current.object_id
  scope        = azapi_resource.AIServices.id

  role_definition_name = "Cognitive Services OpenAI User"
}

# see error report here https://learn.microsoft.com/en-us/answers/questions/1862999/authenticationerror-401-principal-does-not-have-ac
resource "azurerm_role_assignment" "identity_access_to_ai_services_as_cognitive_contributor" {
  principal_id = data.azurerm_client_config.current.object_id
  scope        = azapi_resource.AIServices.id

  role_definition_name = "Cognitive Services Contributor"
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

# issue see: https://learn.microsoft.com/en-us/answers/questions/2073352/issue-with-api-endpoints-error-when-managing-deplo
# should no longer be needed, but leaving here for reference
/*
# Assign the role to the workspace MSI
resource "azurerm_role_assignment" "role_assignment" {
  scope                = azapi_resource.project.id
  role_definition_name = "Contributor"
  principal_id         = azapi_resource.project.identity.0.principal_id
}

# Assign the role to the workspace MSI
resource "azurerm_role_assignment" "role_assignment" {
  scope                = azapi_resource.project.id
  role_definition_name = "Azure AI Administrator"
  principal_id         = azapi_resource.project.identity.0.principal_id
}*/