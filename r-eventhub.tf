resource "azurerm_eventhub" "main" {
  for_each = try(var.hubs_parameters, {})

  name                = coalesce(each.value.custom_name, data.azurecaf_name.eventhub[each.key].result)
  namespace_name      = azurerm_eventhub_namespace.main.name
  resource_group_name = var.resource_group_name

  message_retention = each.value.message_retention
  partition_count   = each.value.partition_count

  dynamic "capture_description" {
    for_each = each.value.capture_description == null ? [] : ["enabled"]
    content {
      enabled             = each.value.capture_description.enabled
      encoding            = each.value.capture_description.encoding
      interval_in_seconds = each.value.capture_description.interval_in_seconds
      size_limit_in_bytes = each.value.capture_description.size_limit_in_bytes
      skip_empty_archives = each.value.capture_description.skip_empty_archives

      destination {
        archive_name_format = each.value.capture_description.destination.archive_name_format
        blob_container_name = each.value.capture_description.destination.blob_container_name
        name                = each.value.capture_description.destination.name
        storage_account_id  = each.value.capture_description.destination.storage_account_id
      }
    }
  }

  lifecycle {
    precondition {
      condition     = var.namespace_parameters.sku != "Basic" || (var.namespace_parameters.sku == "Basic" && each.value.capture_description == null)
      error_message = "`capture_description` block cannot be set with `Basic` Namespace SKU."
    }
  }
}

moved {
  from = azurerm_eventhub.eventhub
  to   = azurerm_eventhub.main
}

resource "azurerm_eventhub_consumer_group" "main" {
  for_each = { for h, cp in var.hubs_parameters : h => cp if cp.consumer_group.enabled }

  eventhub_name       = azurerm_eventhub.main[each.key].name
  name                = coalesce(each.value.consumer_group.custom_name, data.azurecaf_name.consumer_group[each.key].result)
  namespace_name      = azurerm_eventhub_namespace.main.name
  resource_group_name = var.resource_group_name

  user_metadata = each.value.consumer_group.user_metadata
}

moved {
  from = azurerm_eventhub_consumer_group.eventhub_consumer_group
  to   = azurerm_eventhub_consumer_group.main
}
