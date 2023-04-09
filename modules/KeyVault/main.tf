# - 
# - Creates Azure Key Vault and assign mandatory tags
# - 
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                            = var.name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  sku_name                        = "Standard"
  purge_protection_enabled        = false
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  enabled_for_disk_encryption     = true      //"true"
}
resource "azurerm_key_vault_access_policy" "kvaccesspolicy1" {
  key_vault_id                    = azurerm_key_vault.kv.id
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  object_id                       = data.azurerm_client_config.current.object_id

  key_permissions = [
      "get", "list" , "create", "delete", "update"
    ]
  secret_permissions = [
      "get", "list" , "set", "delete", "recover", "backup", "restore", "purge"
    ]
  depends_on = [
    azurerm_key_vault.kv
  ]  
}
