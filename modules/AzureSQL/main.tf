# Create KeyVault SQL password
resource "random_password" "sqlpassword" {
  length  = 16
  special = true
}

data "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  resource_group_name = var.resource_group_name
}
# #Create Key Vault Secret
resource "azurerm_key_vault_secret" "sqladminpassword" {
  name         = "kv-sqlpassword"
  value        = random_password.sqlpassword.result
  key_vault_id = data.azurerm_key_vault.kv.id
  content_type = "text/plain"
  depends_on   = [data.azurerm_key_vault.kv] 
}

resource "azurerm_mssql_server" "azuresql" {
  name                         = var.name
  location                     = var.location
  resource_group_name          = var.resource_group_name
  version                      = "12.0"
  administrator_login          = var.administrator_login
  administrator_login_password = random_password.sqlpassword.result
  minimum_tls_version          = "1.2"
    identity {
    type = "SystemAssigned"   
  }
}

resource "azurerm_mssql_database" "azuredb" {
  name                         = var.sqldatabase_name
  server_id                    = azurerm_mssql_server.azuresql.id
  collation                    = "SQL_Latin1_General_CP1_CI_AS"
  depends_on = [
    azurerm_mssql_server.azuresql
  ]
}

data "azurerm_subnet" "backend-subnet" {
  name                 = "backend-subnet"
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
}

resource "azurerm_mssql_virtual_network_rule" "allow-backend" {
  name      = "sql-vnet-rule"
  server_id = azurerm_mssql_server.azuresql.id
  subnet_id = data.azurerm_subnet.backend-subnet.id
  depends_on = [
    azurerm_mssql_server.azuresql
  ]
}

# - Add Key Vault Secrets
 resource "azurerm_key_vault_secret" "sqldb-connection-string" {
  name                      = "sqldb-connection-string"
  value                     = "Server=tcp:${var.name}.database.windows.net,1433;Initial Catalog=${var.sqldatabase_name};Persist Security Info=False;User ID=${var.administrator_login};Password=${random_password.sqlpassword.result};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  #value                     = var.value
  key_vault_id              = data.azurerm_key_vault.kv.id     //azurerm_key_vault.this.id
  depends_on                = [
    azurerm_mssql_server.azuresql, azurerm_mssql_database.azuredb
  ]
 }

resource "azurerm_key_vault_access_policy" "kvaccesspolicy" {
  key_vault_id = data.azurerm_key_vault.kv.id
  tenant_id    = azurerm_mssql_server.azuresql.identity[0].tenant_id
  object_id    = azurerm_mssql_server.azuresql.identity[0].principal_id

  key_permissions = [
    "Get","List", "delete"
  ]

  secret_permissions = [
    "Get", "List", "set", "delete", "Purge"
  ]
  depends_on   = [data.azurerm_key_vault.kv] 
}