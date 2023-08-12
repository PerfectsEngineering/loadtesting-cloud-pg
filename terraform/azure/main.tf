terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.68.0"
    }

    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "loadtest" {
  name     = "loadtest-rg"
  location = var.group_location
}