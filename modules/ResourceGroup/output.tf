# -
# - Outputs of the module :  Resource Group
# -
output "id" {  
    description = "id of the resource group provisioned"  
    value = "${azurerm_resource_group.rg.id}"  
}  
output "name" {  
    description = "name of the resource group provisioned"  
    value = "${azurerm_resource_group.rg.name}"  
}  
output "location" {  
    description = "location of the resource group provisioned"  
    value = "${azurerm_resource_group.rg.location}"  
} 