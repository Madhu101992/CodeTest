# -
# - Outputs of the module :  Azure SQL
# -
output "id" {  
    description = "id of the SQL Server provisioned"  
    value = "${azurerm_mssql_server.azuresql.id}"  
}  
output "name" {  
    description = "name of the SQL Server provisioned"  
    value = "${azurerm_mssql_server.azuresql.name}"  
}  
output "location" {  
    description = "location of the SQL Server provisioned"  
    value = "${azurerm_mssql_server.azuresql.location}"  
} 

output "principal_id" {
  value = azurerm_mssql_server.azuresql.identity[0].principal_id
}
output "tenant_id" {
  value = azurerm_mssql_server.azuresql.identity[0].tenant_id
}
