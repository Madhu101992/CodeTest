# -- Variables for Function App
variable "resource_group_name" {
  description = "resource group name"
  type = string
}
variable "location" {
  description = "resource group location"
  type = string
}
variable "name" {
  type = string
  description = "Function App Name"
}
variable "appinsights_name" {
  type = string
  description = "App Insights Name"
}
# variable "appserviceplan_name" {
#   type = string
#   description = "App Service plan Name"
# }
variable "storage_account_name" {
  type = string
  description = "Storage Account Name"
}
# Variable Declaration for Virtual Network Name
variable "vnet_name" {
}
