resource "azurerm_eventhub" "eventhub" {
  for_each = var.hubs_parameters

  name                = coalesce(each.value.custom_name, azurecaf_name.eventhub[each.key].result)
  namespace_name      = azurerm_eventhub_namespace.eventhub.name
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
}


resource "azurerm_eventhub_consumer_group" "eventhub" {
  eventhub_name       = azurerm_eventhub.eventhub.name
  name                = local.name_consumer_group
  namespace_name      = azurerm_eventhub_namespace.eventhub.name
  resource_group_name = var.resource_group_name

  user_metadata = var.consumer_group_user_metadata
}
