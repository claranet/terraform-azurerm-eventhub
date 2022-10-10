module "region" {
  source  = "claranet/regions/azurerm"
  version = "5.1.0"

  azure_region = var.location
}
