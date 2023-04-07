# -
# - Creates storage account and assign mandatory tags
# -
resource "azurerm_storage_account" "sa" {
  name                      = var.name
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_tier              = var.account_tier
  account_replication_type  = var.account_replication_type    //"LRS""ZGRS"
  account_kind              = var.account_kind
}
