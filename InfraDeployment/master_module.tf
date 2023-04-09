
# - Master file : all the modules for core infrastructure are called here

# - Calling ResourceGroup module to create resource group
  module "resource_group" {
    source   = "../modules/ResourceGroup"
    location = var.location
    name     = "rg-${var.project_code}-${var.locationshortprefix}-${var.Environment}-${var.order}"  //rg-codetest-eus-test-01
    tags     = var.tags
  }

# - Calling StorageAccount module to create sa

  module "storage_account" {
    source = "../modules/StorageAccount"
    #for_each                 = var.storage_accounts
    name                     = "sa${var.project_code}${var.locationshortprefix}${var.Environment}${var.order}"  //sacodetesteustest01 
    resource_group_name      = module.resource_group.name
    location                 = module.resource_group.location
    #account_tier             = each.value["storage_account_tier"]
    account_tier             = var.account_tier
    account_replication_type = var.account_replication_type
    account_kind             = var.account_kind
  }

# - Calling KeyVault module to create an azure key vault

  module "key_vault" {
    source = "../modules/KeyVault"
    name                            = "kv-${var.project_code}-${var.locationshortprefix}-${var.Environment}-${var.order}"  //kv-codetest-eus-test-01
    resource_group_name             = module.resource_group.name
    location                        = module.resource_group.location
    tenant_id                       = data.azurerm_client_config.current.tenant_id
    object_id                       = data.azurerm_client_config.current.object_id
  }

# - Calling FunctionApp module to create an Azure Function App
  module "function_app" {
    source = "../modules/FunctionApp"
    name                         = "func-${var.project_code}-${var.locationshortprefix}-${var.Environment}-${var.order}" //func-codetest-eus-test-01
    resource_group_name          = module.resource_group.name
    location                     = module.resource_group.location
    storage_account_name         = module.storage_account.name 
    appinsights_name             = module.appinsights.name
    vnet_name                    = module.virtual_network.name
    depends_on                   = [module.appinsights, module.storage_account, module.virtual_network]      
  }

# - Calling Appinsights module to create an Azure App Insights
  module "appinsights" {
    source = "../modules/AppInsights"
    name                         = "appi-${var.project_code}-${var.locationshortprefix}-${var.Environment}-${var.order}" //appi-codetest-eus-test
    resource_group_name          = module.resource_group.name
    location                     = module.resource_group.location
  }

# - Calling SQL Server Module to create an SQL server and SQLDB

  module "sqlserver" {
    source = "../modules/AzureSQL"
    name                         = "sql-${var.project_code}-${var.locationshortprefix}-${var.Environment}-${var.order}"  //sql-codetest-eus-test-01
    sqldatabase_name             = var.sqldatabase_name
    administrator_login          = var.administrator_login
    resource_group_name          = module.resource_group.name
    location                     = module.resource_group.location
    key_vault_name               = module.key_vault.name
    vnet_name                    = module.virtual_network.name
    depends_on                   = [module.key_vault, module.virtual_network]
  }

# - Calling App Service module to create an Azure App Service

  module "app_service" {
    source = "../modules/WebApp"
    name                         = "${var.project_code}portal" //codetestportal
    resource_group_name          = module.resource_group.name
    location                     = module.resource_group.location
    appinsights_name             = module.appinsights.name
    vnet_name                    = module.virtual_network.name
    depends_on                   = [module.appinsights, module.virtual_network]      
  }

# - Calling Networking Module to create Network components

  module "virtual_network" {
    source = "../modules/Networking"
    name                         = "vnet-${var.project_code}-${var.locationshortprefix}-${var.Environment}-${var.order}" //vnet-codetest-eus-test-01
    resource_group_name          = module.resource_group.name
    location                     = module.resource_group.location
    address_space                = var.address_space
    websubnetcidr                = var.websubnetcidr
    appsubnetcidr                = var.appsubnetcidr
  }
