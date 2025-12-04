terraform {
  required_version = ">= 1.3.0, < 1.13.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.117, < 5.0"
    }
  }
}