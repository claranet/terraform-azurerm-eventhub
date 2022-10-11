resource "azurerm_eventhub_namespace" "eventhub" {
  name                = local.namespace_name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku                  = var.namespace_parameters.sku
  capacity             = var.namespace_parameters.capacity
  auto_inflate_enabled = var.namespace_parameters.auto_inflate_enabled
  dedicated_cluster_id = var.namespace_parameters.dedicated_cluster_id

  identity {
    type = "SystemAssigned"
  }

  maximum_throughput_units = var.namespace_parameters.maximum_throughput_units
  zone_redundant           = var.namespace_parameters.zone_redundant

  dynamic "network_rulesets" {
    for_each = var.namespace_network_rules != null ? var.namespace_network_rules : {}
    iterator = ntw
    content {
      default_action                 = ntw.default_action
      public_network_access_enabled  = var.namespace_parameters.public_network_access_enabled
      trusted_service_access_enabled = ntw.trusted_service_access_enabled

      dynamic "virtual_network_rule" {
        for_each = ntw.virtual_network_rules
        iterator = vnr
        content {
          subnet_id                                       = vnr.subnet_id
          ignore_missing_virtual_network_service_endpoint = vnr.ignore_missing_virtual_network_service_endpoint
        }
      }

      dynamic "ip_rule" {
        for_each = ntw.ip_rules
        iterator = ir
        content {
          ip_mask = ir.ip_mask
          action  = ir.action
        }
      }
    }
  }

  local_authentication_enabled  = var.namespace_parameters.local_authentication_enabled
  public_network_access_enabled = var.namespace_parameters.public_network_access_enabled
  minimum_tls_version           = var.namespace_parameters.minimum_tls_version

  tags = local.tags
}
