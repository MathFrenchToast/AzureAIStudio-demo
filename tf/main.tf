resource "random_pet" "rg_name" { 
  prefix = var.resource_group_name_prefix
}

// RESOURCE GROUP
resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = random_pet.rg_name.id
}

data "azurerm_client_config" "current" {
}

// STORAGE ACCOUNT
resource "azurerm_storage_account" "default" {
  name                            = "${var.prefix}storage${random_string.suffix.result}"
  location                        = azurerm_resource_group.rg.location
  resource_group_name             = azurerm_resource_group.rg.name
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false
}

// KEY VAULT
resource "azurerm_key_vault" "default" {
  name                     = "${var.prefix}keyvault${random_string.suffix.result}"
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  tenant_id                = data.azurerm_client_config.current.tenant_id
  sku_name                 = "standard"
  purge_protection_enabled = false
}


/* The following resources are OPTIONAL.
// APPLICATION INSIGHTS
resource "azurerm_application_insights" "default" {
  name                = "${var.prefix}appinsights${random_string.suffix.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = "web"
}

// CONTAINER REGISTRY
resource "azurerm_container_registry" "default" {
  name                     = "${var.prefix}contreg${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  sku                      = "premium"
  admin_enabled            = true
}
*/