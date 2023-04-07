# -
# - Variables created for the Stoarge Account 
# -

variable "resource_group_name" {
    description = "resource group name"
    type = string
}

variable "location" {
    description = "resource group location"
    type = string
}

variable "name" {
    description = "storage account name"
    type = string
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


