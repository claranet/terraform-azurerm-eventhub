resource "azurerm_eventhub_namespace" "eventhub_namespace" {
  for_each            = var.eventhub_namespaces_hubs
  location            = var.location
  name                = lookup(each.value, "custom_name", format("%s-%s-eh", local.default_name, each.key))
  resource_group_name = var.resource_group_name
  sku                 = lookup(each.value, "sku", "Basic")
  capacity            = lookup(each.value, "capacity", lookup(each.value, "sku", "Basic") == "Standard" ? 1 : null)

  tags = merge(
    var.extra_tags,
    local.default_tags
  )
}
