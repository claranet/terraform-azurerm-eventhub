module "eventhub" {
  source  = "claranet/eventhub/azurerm"
  version = "x.x.x"

  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  client_name    = var.client_name
  environment    = var.environment
  stack          = var.stack

  resource_group_name = module.rg.name

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
    # module.logs.logs_storage_account_id,
    # module.logs.log_analytics_workspace_id
  ]
}
