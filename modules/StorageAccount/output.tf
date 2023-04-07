# -
# - Outputs of the module :  Storage Account
# -

output "id" {  
    description = "id of the storage account provisioned"  
    value = "${azurerm_storage_account.sa.id}"  
}  
output "name" {  
    description = "name of the storage account provisioned"  
    value = "${azurerm_storage_account.sa.name}"  
}  

output "location" {  
    description = "location of the storage account provisioned"  
    value = "${azurerm_storage_account.sa.location}"  
}
output "sas_token" {
  description = "primary access key of the storage account provisioned"
  value = azurerm_storage_account.sa.primary_access_key 
  sensitive   = true
}
output "connection_string_primary" {
  value = "${azurerm_storage_account.sa.primary_connection_string}"
}
