variable "resource_group" {
  default = "dtlakeprojectdev"
}

variable "azure_region" {
  default = "East US"
}

variable "environment" {
  default = "staging"
}

variable "app_name" {
  default = "dtlakeprojectdev"
}

variable "storage_account" {
  default = "dtlakeprojectdev"
}

variable "spark_version" {
  description = "Spark Runtime Version for databricks clusters"
  default = "13.3.x-scala2.12"
}

variable "node_type_id" {
  description = "Type of worker nodes for databricks cluster"
  default = "Standard_DS3_v2"
}

variable "notebook_path" {
  description = "path to a notebook"
  default = "/python_notebook"
}

variable "min_workers" {
  description = "Minimum workers in a cluster"
  default = "1"
}

variable "max_workers" {
  description = "Maximum workers in a cluster"
  default = "4"
}

variable "subscription_id" {
    description = "Azure Tenant Subscription ID"
    type = string    
}

variable "tenant_id" {
    description = "Azure Tenant ID"
    type = string    
}

#############################
# Azure Key Vault variables #
#############################

variable "name" {
  type        = string
  description = "The name of the Azure Key Vault"
  default = "dtlakeprojectdevkeyvault"
}

variable "sku_name" {
  type        = string
  description = "Select Standard or Premium SKU"
  default     = "standard"
}

variable "enabled_for_deployment" {
  type        = string
  description = "Allow Azure Virtual Machines to retrieve certificates stored as secrets from the Azure Key Vault"
  default     = "true"
}

variable "enabled_for_disk_encryption" {
  type        = string
  description = "Allow Azure Disk Encryption to retrieve secrets from the Azure Key Vault and unwrap keys" 
  default     = "true"
}

variable "enabled_for_template_deployment" {
  type        = string
  description = "Allow Azure Resource Manager to retrieve secrets from the Azure Key Vault"
  default     = "true"
}

variable "kv-key-permissions-full" {
  type        = list(string)
  description = "List of full key permissions, must be one or more from the following: Backup, create, decrypt, Delete, encrypt, Get, import, List, Purge, Recover, Restore, sign, unwrapKey, Update, verify and wrapKey."
  default     = [ "Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey","Update", "Verify", "WrapKey" ]
}

variable "kv-secret-permissions-full" {
  type        = list(string)
  description = "List of full secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set"
  default     = [ "Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set" ]
} 

variable "kv-certificate-permissions-full" {
  type        = list(string)
  description = "List of full certificate permissions, must be one or more from the following: Backup, create, Delete, DeleteIssuers, Get, GetIssuers, import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update"
  default     = [ "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "SetIssuers", "Update", "Backup", "Restore" ]
}

variable "kv-storage-permissions-full" {
  type        = list(string)
  description = "List of full storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update"
  default     = [ "Backup", "Delete", "DeleteSAS", "Get", "GetSAS", "List", "ListSAS", "Purge", "Recover", "RegenerateKey", "Restore", "Set", "SetSAS", "Update" ]
}

variable "kv-key-permissions-read" {
  type        = list(string)
  description = "List of read key permissions, must be one or more from the following: Backup, create, decrypt, Delete, encrypt, Get, import, List, Purge, Recover, Restore, sign, unwrapKey, Update, verify and wrapKey"
  default     = [ "Get", "List" ]
}

variable "kv-secret-permissions-read" {
  type        = list(string)
  description = "List of full secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set"
  default     = [ "Get", "List" ]
} 

variable "kv-certificate-permissions-read" {
  type        = list(string)
  description = "List of full certificate permissions, must be one or more from the following: Backup, create, Delete, DeleteIssuers, Get, GetIssuers, import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update"
  default     = [ "Get", "GetIssuers", "List", "ListIssuers" ]
}

variable "kv-storage-permissions-read" {
  type        = list(string)
  description = "List of read storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update"
  default     = [ "Get", "GetSAS", "List", "ListSAS" ]
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "policies" {
  type = map(object({
    tenant_id               = string
    object_id               = string
    key_permissions         = list(string)
    secret_permissions      = list(string)
    certificate_permissions = list(string)
    storage_permissions     = list(string)
  }))
  description = "Define a Azure Key Vault access policy"
  default = {}
}

variable "secrets" {
  type = map(object({
    value = string
  }))
  description = "Define Azure Key Vault secrets"
  default = {}
}

variable "databricks_secret_scope" {
  description = "Databricks secrety scope name"
  default     = "dtlakeprojectdev_scope"
}

variable "notebook_1" {
  type        = string
  description = "Notebook 1 name"
  default     = "mount_adls_storage_secrets.py"
}



