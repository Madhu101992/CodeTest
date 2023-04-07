# -
# - Variables created for the module : KeyVault
# -

variable "name" {
    type = string
    description ="Name of the Key Vault"
}
variable "resource_group_name" {
    type = string
    description ="Name of the Resource Group"
}
variable "location" {
    type = string
    description ="Location of the Resource Group"
}
