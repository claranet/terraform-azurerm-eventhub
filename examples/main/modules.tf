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
  source  = "claranet/run/azurerm//modules/logs"
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

  create_dedicated_cluster = true

  namespace_parameters = {
    sku      = "Standard"
    capacity = 2
  }

  namespace_authorizations = {
    listen = true
    send   = false
  }

  network_rules_enabled = true
  allowed_cidrs         = ["1.1.1.1/32"]
  allowed_subnet_ids = [
    var.subnet_id
  ]

  hubs_parameters = {
    main = {
      custom_name     = "main-queue-hub"
      partition_count = 2

      authorizations = {
        listen = true
        send   = true
        manage = false
      }
    }
  }

  logs_destinations_ids = [
    module.logs.logs_storage_account_id,
    module.logs.log_analytics_workspace_id
  ]
}
