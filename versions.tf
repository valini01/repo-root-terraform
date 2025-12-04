terraform {
  required_version = ">= 1.9, < 1.13.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.117, < 5.0"
    }
  }
}