terraform {
  backend "azurerm" {
    # Configuration will be provided during terraform init via -backend-config flags
    # This allows different state files per environment
    use_azuread_auth = true
  }
}