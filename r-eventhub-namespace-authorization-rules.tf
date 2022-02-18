resource "azurerm_eventhub_namespace_authorization_rule" "reader" {
  for_each            = toset(local.namespaces_reader)
  name                = var.use_caf_naming ? azurecaf_name.eventhub_namespace_auth_rule_reader[each.key].result : "${each.key}-reader"
  namespace_name      = azurerm_eventhub_namespace.eventhub_namespace[each.key].name
  resource_group_name = var.resource_group_name

  listen = true
  send   = false
  manage = false
}

resource "azurerm_eventhub_namespace_authorization_rule" "sender" {
  for_each            = toset(local.namespaces_sender)
  name                = var.use_caf_naming ? azurecaf_name.eventhub_namespace_auth_rule_sender[each.key].result : "${each.key}-sender"
  namespace_name      = azurerm_eventhub_namespace.eventhub_namespace[each.key].name
  resource_group_name = var.resource_group_name

  listen = false
  send   = true
  manage = false
}

resource "azurerm_eventhub_namespace_authorization_rule" "manage" {
  for_each            = toset(local.namespaces_manage)
  name                = var.use_caf_naming ? azurecaf_name.eventhub_namespace_auth_rule_manage[each.key].result : "${each.key}-manage"
  namespace_name      = azurerm_eventhub_namespace.eventhub_namespace[each.key].name
  resource_group_name = var.resource_group_name

  listen = true
  send   = true
  manage = true
}
