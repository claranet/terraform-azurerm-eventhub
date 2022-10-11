resource "azurerm_eventhub" "eventhub" {
  name                = local.name
  namespace_name      = azurerm_eventhub_namespace.eventhub.name
  resource_group_name = var.resource_group_name

  message_retention = var.message_retention
  partition_count   = var.partition_count

  dynamic "capture_description" {
    for_each = var.capture_description == null ? [] : [var.capture_description]
    content {
      enabled             = lookup(capture_description.value, "enabled", true)
      encoding            = lookup(capture_description.value, "encoding")
      interval_in_seconds = lookup(capture_description.value, "interval_in_seconds", null)
      size_limit_in_bytes = lookup(capture_description.value, "size_limit_in_bytes", null)
      skip_empty_archives = lookup(capture_description.value, "skip_empty_archives", null)

      destination {
        archive_name_format = lookup(capture_description.value.destination, "archive_name_format", "EventHubArchive.AzureBlockBlob")
        blob_container_name = lookup(capture_description.value.destination, "blob_container_name")
        name                = lookup(capture_description.value.destination, "name")
        storage_account_id  = lookup(capture_description.value.destination, "storage_account_id")
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
