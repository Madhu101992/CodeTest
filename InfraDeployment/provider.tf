#Set the terraform required version
terraform {
  required_version = "~> 1.0.0"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 2.79.1"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-terraformstate-01"
    storage_account_name = "saterraformstate01"
    container_name       = "tfstate"
    key                  = "test.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

# Data

# Make client_id, tenant_id, subscription_id and object_id variables
data "azurerm_client_config" "current" {}