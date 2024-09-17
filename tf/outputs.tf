output "resource_group_name" {
  value = azurerm_resource_group.rg.id
}

output "workspace_name" {
    value = azapi_resource.project.id
}

output "endpoint" {
  value = azurerm_cognitive_account.AIServicesResource.endpoint
}

output "search_endpoint" {
  value = "https://${azurerm_search_service.AISearch.name}.search.windows.net"
}