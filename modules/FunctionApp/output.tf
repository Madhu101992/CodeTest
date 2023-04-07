
# # OUTPUTS Function App

output "appserviceplan_id" {
  value = "${azurerm_app_service_plan.asp2.id}"
}

output "name" {
  value = "${azurerm_function_app.functionapp.name}"
}

output "location" {
  value = "${azurerm_function_app.functionapp.location}"
}

# output "principal_id" {
#   value = azurerm_function_app.this.identity[0].principal_id
# }
# output "tenant_id" {
#   value = azurerm_function_app.this.identity[0].tenant_id
# }

# output "kv_id" {
#   value = "${data.azurerm_key_vault.this1.id}"
# }
