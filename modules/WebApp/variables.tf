# -- Variables for App Service
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
  description = "Name of the App Service"
}
variable "appinsights_name" {
  type = string
  description = "App Insight Name"
}
# variable "appserviceplan_name" {
#   type = string
#   description = "App Service Plan Name"
# }
# Variable Declaration for Virtual Network Name
variable "vnet_name" {
}
