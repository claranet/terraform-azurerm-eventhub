resource "azurerm_eventhub" "eventhub" {
  for_each            = toset(local.hubs_list)
  name                = split("|", each.key)[1]
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_eventhub_namespace.eventhub_namespace[split("|", each.key)[0]].name

  message_retention = lookup(var.eventhub_namespaces_hubs[split("|", each.key)[0]]["hubs"][split("|", each.key)[1]], "message_retention", 1)
  partition_count   = lookup(var.eventhub_namespaces_hubs[split("|", each.key)[0]]["hubs"][split("|", each.key)[1]], "partition_count", 1)
}
