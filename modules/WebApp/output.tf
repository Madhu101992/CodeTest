
# # OUTPUTS App Service

output "appserviceplan_id" {
  value = "${azurerm_app_service_plan.asp1.id}"
}

output "name" {
  value = "${azurerm_app_service.webapp.name}"
}

output "location" {
  value = "${azurerm_app_service.webapp.location}"
}
