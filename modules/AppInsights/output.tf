
# # OUTPUTS Application Insights

output "instrumentation_key" {
  value = "${azurerm_application_insights.appinsights.instrumentation_key}"
}

output "name" {
  value = "${azurerm_application_insights.appinsights.name}"
}

output "location" {
  value = "${azurerm_application_insights.appinsights.location}"
}

output "connection_string" {
  value = "${azurerm_application_insights.appinsights.connection_string}"
}
