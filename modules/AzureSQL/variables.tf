# -
# - Variables created for the SQL Server and SQLDB 
# -

variable "location" {
  description = "Resource Group Location"
}

variable "name" {
  description = "SQL Server name"
}

variable "sqldatabase_name" {
  description = "SQL DB name"
}

variable "resource_group_name" {
  description = "RG name"
}

variable "administrator_login" {
  description = "SQL Admin Name"
}

variable "key_vault_name" {
   type = string
}

variable "vnet_name" {
}


