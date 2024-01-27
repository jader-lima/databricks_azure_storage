variable "app_password" {  
  description = "Used for application secret"  
  type        = string  
  sensitive   = true
}

# Create an application
resource "azuread_application" "application" {
  display_name = var.app_name
}

resource "azuread_application_password" "application" {
  application_object_id = azuread_application.application.object_id
  display_name = var.app_name
}

resource "azuread_service_principal" "application" {
  app_role_assignment_required = false
  application_id = azuread_application.application.application_id
  feature_tags {
    enterprise = true
    gallery    = true
  }
}

#data contributor role assignment to service principal
resource "azurerm_role_assignment" "blob_data_contributor_role_assignment" {
  scope                = data.azurerm_subscription.subscription.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azuread_service_principal.application.id
}

resource "azuread_service_principal_password" "application" {
  service_principal_id = azuread_service_principal.application.object_id
}

