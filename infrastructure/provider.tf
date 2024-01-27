terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }

    databricks = {
      source = "databricks/databricks"
      version = "0.5.5"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.15.0"
    }

  }

  required_version = ">= 1.1.0"
}


provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }

  environment     = "public"
  subscription_id = var.subscription_id
}

data "azurerm_subscription" "subscription" {
  subscription_id = var.subscription_id
}

# Configure the Azure Active Directory Provider
provider "azuread" {
  tenant_id = var.tenant_id
}