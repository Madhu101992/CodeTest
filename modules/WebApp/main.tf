# Create an azure app service plan

resource "azurerm_app_service_plan" "asp1" {
  name                                       = "asp-codetest-eus-test-fe-01"
  location                                   = var.location
  resource_group_name                        = var.resource_group_name
  sku {
    tier =  "Standard"        //"Dynamic","Standard"
    size =  "S1"              //"Y1","S1"
  }
}

data "azurerm_application_insights" "appinsights" {
  name                                        = var.appinsights_name
  resource_group_name                         = var.resource_group_name
}

# - Web App for App Service Plan

resource "azurerm_app_service" "webapp" {
  name                                        = var.name
  location                                    = var.location
  resource_group_name                         = var.resource_group_name
  app_service_plan_id                         = azurerm_app_service_plan.asp1.id
  https_only                                  = "true"
  identity {
    type = "SystemAssigned"   
  }
  app_settings = {
        APPINSIGHTS_INSTRUMENTATIONKEY        = data.azurerm_application_insights.appinsights.instrumentation_key 
        APPLICATIONINSIGHTS_CONNECTION_STRING = data.azurerm_application_insights.appinsights.connection_string
    }
  site_config {
    minimum_tls_version = "1.2"
  }
  depends_on = [
    azurerm_app_service_plan.asp1
  ]
}

data "azurerm_subnet" "frontend-subnet" {
  name                 = "frontend-subnet"
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
}

resource "azurerm_app_service_virtual_network_swift_connection" "fe-vnet-integration" {
  app_service_id = azurerm_app_service.webapp.id
  subnet_id      = data.azurerm_subnet.frontend-subnet.id
  depends_on = [
    azurerm_app_service.webapp
  ]
}