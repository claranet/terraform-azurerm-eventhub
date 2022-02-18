resource "azurerm_eventhub_namespace" "eventhub_namespace" {
  for_each = var.eventhub_namespaces_hubs

  name                = lookup(each.value, "custom_name", azurecaf_name.eventhub_namespace[each.key].result)
  resource_group_name = var.resource_group_name
  location            = var.location

  sku                      = lookup(each.value, "sku", "Basic")
  capacity                 = lookup(each.value, "capacity", lookup(each.value, "sku", "Basic") == "Standard" ? 1 : null)
  auto_inflate_enabled     = lookup(each.value, "auto_inflate_enabled", false)
  maximum_throughput_units = lookup(each.value, "maximum_throughput_units", lookup(each.value, "auto_inflate_enabled", false) == true ? 1 : null)
  network_rulesets         = lookup(each.value, "network_rulesets", null)

  tags = merge(
    var.extra_tags,
    local.default_tags
  )
}
