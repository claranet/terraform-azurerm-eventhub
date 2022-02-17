module "azure_region" {
  source  = "claranet/regions/azurerm"
  version = "x.x.x"

  azure_region = var.azure_region
}

module "rg" {
  source  = "claranet/rg/azurerm"
  version = "x.x.x"

  location    = module.azure_region.location
  client_name = var.client_name
  environment = var.environment
  stack       = var.stack
}

module "logs" {
  source  = "claranet/run-common/azurerm//modules/logs"
  version = "x.x.x"

  client_name         = var.client_name
  environment         = var.environment
  stack               = var.stack
  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.resource_group_name
}

module "eventhub" {
  source  = "claranet/eventhub/azurerm"
  version = "x.x.x"

  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  client_name    = var.client_name
  environment    = var.environment
  stack          = var.stack

  resource_group_name = module.rg.resource_group_name

  eventhub_namespaces_hubs = {
    # You can just create a eventhub_namespace
    eventhub0 = {}

    # Or create a eventhub_namespace with some hubs with default values
    eventhub1 = {
      hubs = {
        hub1 = {}
        hub2 = {}
      }
    }

    eventhub2 = {
      custom_name          = "testeventhub"
      sku                  = "Standard"
      capacity             = 1
      auto_inflate_enabled = true
      reader               = true
      hubs = {
        hubcentdeux = {
          message_retention = 7
          partition_count   = 2
          sender            = true
          manage            = true
        }
      }
    }
  }

  logs_destinations_ids = [
    module.logs.logs_storage_account_id,
    module.logs.log_analytics_workspace_id
  ]
}
