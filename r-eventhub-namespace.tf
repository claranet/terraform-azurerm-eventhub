resource "azurerm_eventhub_cluster" "cluster" {
  for_each = toset(var.create_dedicated_cluster ? ["enabled"] : [])

  name                = format("%s-cluster", local.namespace_name)
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = "Dedicated_1"

  tags = local.tags
}

resource "azurerm_eventhub_namespace" "eventhub" {
  name                = local.namespace_name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku                  = var.namespace_parameters.sku
  capacity             = var.namespace_parameters.capacity
  auto_inflate_enabled = var.namespace_parameters.auto_inflate_enabled
  dedicated_cluster_id = var.create_dedicated_cluster ? azurerm_eventhub_cluster.cluster["enabled"].id : var.namespace_parameters.dedicated_cluster_id

  identity {
    type = "SystemAssigned"
  }

  maximum_throughput_units = var.namespace_parameters.maximum_throughput_units
  zone_redundant           = var.namespace_parameters.zone_redundant

  dynamic "network_rulesets" {
    for_each = var.network_rules_enabled ? ["enabled"] : []

    content {
      default_action                 = var.network_rules_default_action
      public_network_access_enabled  = var.namespace_parameters.public_network_access_enabled
      trusted_service_access_enabled = var.network_trusted_service_access_enabled

      dynamic "virtual_network_rule" {
        for_each = var.allowed_subnet_ids
        iterator = vnr
        content {
          subnet_id                                       = vnr.value
          ignore_missing_virtual_network_service_endpoint = false
        }
      }

      dynamic "ip_rule" {
        for_each = var.allowed_cidrs
        iterator = ir
        content {
          ip_mask = ir.value
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
