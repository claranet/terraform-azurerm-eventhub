resource "azurerm_eventhub_cluster" "main" {
  count = var.create_dedicated_cluster ? 1 : 0

  name                = format("%s-cluster", local.name)
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = "Dedicated_1"

  tags = local.tags
}

moved {
  from = azurerm_eventhub_cluster.cluster["enabled"]
  to   = azurerm_eventhub_cluster.main[0]
}

resource "azurerm_eventhub_namespace" "main" {
  name                = local.name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku                  = var.namespace_parameters.sku
  capacity             = var.namespace_parameters.capacity
  auto_inflate_enabled = var.namespace_parameters.auto_inflate_enabled
  dedicated_cluster_id = var.create_dedicated_cluster ? one(azurerm_eventhub_cluster.main[*].id) : var.namespace_parameters.dedicated_cluster_id

  identity {
    type = "SystemAssigned"
  }

  maximum_throughput_units = var.namespace_parameters.maximum_throughput_units

  dynamic "network_rulesets" {
    for_each = var.network_rules_enabled ? [local.networks_rules] : []
    iterator = rules

    content {
      default_action                 = var.network_rules_default_action
      public_network_access_enabled  = var.namespace_parameters.public_network_access_enabled
      trusted_service_access_enabled = var.network_trusted_service_access_enabled

      dynamic "virtual_network_rule" {
        for_each = rules.value.subnet_ids
        content {
          subnet_id                                       = virtual_network_rule.value
          ignore_missing_virtual_network_service_endpoint = false
        }
      }

      dynamic "ip_rule" {
        for_each = rules.value.cidrs
        content {
          ip_mask = ip_rule.value
          action  = "Allow"
        }
      }
    }
  }

  local_authentication_enabled  = var.namespace_parameters.local_authentication_enabled
  public_network_access_enabled = var.namespace_parameters.public_network_access_enabled
  minimum_tls_version           = var.namespace_parameters.minimum_tls_version

  tags = local.tags
}

moved {
  from = azurerm_eventhub_namespace.eventhub
  to   = azurerm_eventhub_namespace.main
}
