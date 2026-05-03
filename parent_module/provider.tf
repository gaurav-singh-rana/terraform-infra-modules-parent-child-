terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.70.0"
    }
  }
}

provider "azurerm" {

  features {

  }
  subscription_id = "acc21808-1dcb-4f89-8b3a-ab9a832e188d"
}