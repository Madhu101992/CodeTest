# - 
# - Creates Azure Function App and required resources
# - 

# Create an Serverless azure app service plan
resource "azurerm_app_service_plan" "asp2" {
  name                                = "asp-codetest-eus-test-be-01"
  location                            = var.location
  resource_group_name                 = var.resource_group_name
  kind                                = "FunctionApp" //"FunctionApp"
  sku {
    tier =  "Dynamic"   //"Dynamic","Standard"
    size =  "Y1"       //"Y1","S1"
  }
}

# - Get the App Insight Name to assign to Function App

data "azurerm_application_insights" "appinsights" {
  name                                 = var.appinsights_name
  resource_group_name                  = var.resource_group_name
}

# - Get the Storage account details to assign to Function App 
data "azurerm_storage_account" "sa" {
  name                                 = var.storage_account_name
  resource_group_name                  = var.resource_group_name
}

data "azurerm_subnet" "frontend-subnet" {
  name                 = "frontend-subnet"
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
}

# - Function App for App Service Plan

resource "azurerm_function_app" "functionapp" {
  name                                 = var.name
  location                             = var.location
  resource_group_name                  = var.resource_group_name
  app_service_plan_id                  = azurerm_app_service_plan.asp2.id
  storage_account_name                 = data.azurerm_storage_account.sa.name
  storage_account_access_key           = data.azurerm_storage_account.sa.primary_access_key
  version                              = "~3"
  identity {
    type = "SystemAssigned"   
  }
  app_settings = {
        WEBSITE_NODE_DEFAULT_VERSION   = "~3" 
        AppInsights_InstrumentationKey = data.azurerm_application_insights.appinsights.instrumentation_key   
    }
  site_config {
    ip_restriction {
        virtual_network_subnet_id = data.azurerm_subnet.frontend-subnet.id
        priority = 100
        name = "Frontend WebApp access Only"
    }
  }
  depends_on = [
    azurerm_app_service_plan.asp2, azurerm_storage_account.sa
  ]
}

data "azurerm_subnet" "backend-subnet" {
  name                 = "backend-subnet"
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
}

resource "azurerm_app_service_virtual_network_swift_connection" "be-vnet-integration" {
  app_service_id = azurerm_function_app.functionapp.id
  subnet_id      = data.azurerm_subnet.backend-subnet.id
  depends_on = [
    azurerm_function_app.functionapp
  ]
}

# # - Get the Key Vault name to assign Function App to the access policy
# data "azurerm_key_vault" "kv" {
#   name                                 = var.key_vault_name
#   resource_group_name                  = var.resource_group_name
# }
# # - Access policy Creation for Function App
# resource "azurerm_key_vault_access_policy" "kvaccesspolicy" {
#   key_vault_id                         = data.azurerm_key_vault.kv.id
#   tenant_id                            = azurerm_function_app.functionapp.identity[0].tenant_id
#   object_id                            = azurerm_function_app.functionapp.identity[0].principal_id

#   key_permissions = [
#     "Get","List"
#   ]

#   secret_permissions = [
#     "Get", "List"
#   ]
# }
# # - Get the Key Vault name to assign Function App to the access policy
# data "azurerm_key_vault" "this1" {
#   provider                             = azurerm.kv
#   name                                 = var.kv_name
#   resource_group_name                  = var.rg_name
# }
# resource "azurerm_key_vault_access_policy" "this1" {
#   provider                             = azurerm.kv
#   key_vault_id                         = data.azurerm_key_vault.this1.id
#   tenant_id                            = azurerm_function_app.this.identity[0].tenant_id
#   object_id                            = azurerm_function_app.this.identity[0].principal_id

#   key_permissions = [
#     "Get","List"
#   ]

#   secret_permissions = [
#     "Get", "List"
#   ]
#   depends_on = [
#     azurerm_function_app.this, azurerm_key_vault_access_policy.this
#   ]
# }
# # - Add Key Vault Secrets

#  resource "azurerm_key_vault_secret" "this" {
#    count                     = var.kvsecret_enable ? 1 : 0
#    name                      = var.secret_name 
#    value                     = "https://${azurerm_function_app.this.name}.azurewebsites.net"
#    key_vault_id              = data.azurerm_key_vault.this.id
#    tags                      = var.tags
#  }

