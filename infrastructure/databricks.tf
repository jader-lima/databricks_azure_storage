#data "azurerm_client_config" "current" {}
#data "databricks_current_user" "me" {
# depends_on = [azurerm_databricks_workspace.dbx]
#}
provider "databricks" {
    azure_workspace_resource_id = azurerm_databricks_workspace.myworkspace.id
}

resource "azurerm_databricks_workspace" "myworkspace" {
  location = azurerm_resource_group.resource_group.location
  name = "workspace"
  resource_group_name = azurerm_resource_group.resource_group.name
  sku = "trial"
}

resource "databricks_cluster" "shared_autoscaling" {
  cluster_name = "Autoscaling-Cluster"
  spark_version = var.spark_version
  node_type_id = var.node_type_id
  autotermination_minutes = 10
  autoscale {
    min_workers = var.min_workers
    max_workers = var.max_workers
  }
}

resource "databricks_secret_scope" "kv" {
 name = var.databricks_secret_scope

 keyvault_metadata {
   resource_id = azurerm_key_vault.key-vault.id
   dns_name    = azurerm_key_vault.key-vault.vault_uri
 }
}


resource "databricks_directory" "custom_directory" {
  path = "/dtlakeproject"
}

resource "databricks_notebook" "notebook_1" {
  source = format("../${path.module}/databricks_notebooks/%s", var.notebook_1)
  path = format("${databricks_directory.custom_directory.path}/%s", var.notebook_1)
}

