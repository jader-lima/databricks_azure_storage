# Databricks notebook source
dbutils.secrets.help()


# COMMAND ----------

dbutils.secrets.listScopes()

# COMMAND ----------

dbutils.secrets.list("dtlakeprojectdev_scope")

# COMMAND ----------

dbutils.secrets.get(scope="dtlakeprojectdev_scope",key="databrick-app-client-id")

# COMMAND ----------

storage_account_name = "dtlakeprojectdev"
client_id = dbutils.secrets.get(scope="dtlakeprojectdev_scope",key="databrick-app-client-id")
tenant_id = dbutils.secrets.get(scope="dtlakeprojectdev_scope",key="databricks-app-tenant-id")
client_secret = dbutils.secrets.get(scope="dtlakeprojectdev_scope",key="databrick-app-client-secret")

# COMMAND ----------

config = {"fs.azure.account.auth.type":"OAuth",
          "fs.azure.account.oauth.provider.type":"org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider",
          "fs.azure.account.oauth2.client.id":f"{client_id}",
          "fs.azure.account.oauth2.client.secret":f"{client_secret}",
          "fs.azure.account.oauth2.client.endpoint": f"https://login.microsoftonline.com/{tenant_id}/oauth2/token"
}

# COMMAND ----------

def mount_adls(storage_account_name, container_name,config):
  dbutils.fs.mount(
    source = "abfss://" + container_name  + "@" + storage_account_name  + ".dfs.core.windows.net/" ,
    mount_point = "/mnt/{}".format( container_name),
    extra_configs = config)

# COMMAND ----------

mount_adls("dtlakeprojectdev","transient",config)

# COMMAND ----------

mount_adls("dtlakeprojectdev","bronze")

# COMMAND ----------

mount_adls("dtlakeprojectdev","silver")

# COMMAND ----------

mount_adls("dtlakeprojectdev","gold")

# COMMAND ----------

dbutils.fs.ls("/mnt/transient/")

# COMMAND ----------

dbutils.fs.ls("/mnt/bronze/")


# COMMAND ----------

dbutils.fs.ls("/mnt/silver/")


# COMMAND ----------

dbutils.fs.ls("/mnt/gold/")

# COMMAND ----------

dbutils.fs.mounts()

# COMMAND ----------

dbutils.fs.unmount("/mnt/transient")
dbutils.fs.unmount("/mnt/bronze")
dbutils.fs.unmount("/mnt/silver")
dbutils.fs.unmount("/mnt/gold")