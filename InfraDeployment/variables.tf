

  variable "tags" {
    type = map(string)
    description = "Environment tag for the resource group (i.e. 'Production')"
  }

  variable "location" {
    description = "Resource Group Location"
  }

  variable "locationshortprefix" {
    
  }

  variable "project_code" {
    
  }

  variable "order" {
    
  }

  variable "Environment" {
    
  }

  variable "account_tier" {
    description = "storage account tier"
    type = string
  }
  variable "account_kind" {
   description = "kind of storage account -blob, etc"
   type = string
  }
  variable "account_replication_type" {
    description = "storage account replication type"
    type = string
  }

  variable "sqldatabase_name" {
    
  }
  variable "administrator_login" {
    
  }
  variable "address_space" {
    
  }
  variable "websubnetcidr" {
    
  }
  variable "appsubnetcidr" {
    
  }