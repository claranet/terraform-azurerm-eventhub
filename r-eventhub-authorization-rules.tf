resource "azurerm_eventhub_authorization_rule" "reader" {
  for_each            = toset(local.hubs_reader)
  name                = var.use_caf_naming ? azurecaf_name.eventhub_auth_rule_reader[each.key].result : "${split("|", each.key)[1]}-reader"
  namespace_name      = azurerm_eventhub_namespace.eventhub_namespace[split("|", each.key)[0]].name
  eventhub_name       = azurerm_eventhub.eventhub[each.key].name
  resource_group_name = var.resource_group_name

  listen = true
  send   = false
  manage = false
}

resource "azurerm_eventhub_authorization_rule" "sender" {
  for_each            = toset(local.hubs_sender)
  name                = var.use_caf_naming ? azurecaf_name.eventhub_auth_rule_sender[each.key].result : "${split("|", each.key)[1]}-sender"
  namespace_name      = azurerm_eventhub_namespace.eventhub_namespace[split("|", each.key)[0]].name
  eventhub_name       = azurerm_eventhub.eventhub[each.key].name
  resource_group_name = var.resource_group_name

  listen = false
  send   = true
  manage = false
}

resource "azurerm_eventhub_authorization_rule" "manage" {
  for_each            = toset(local.hubs_manage)
  name                = var.use_caf_naming ? azurecaf_name.eventhub_auth_rule_manage[each.key].result : "${split("|", each.key)[1]}-manage"
  namespace_name      = azurerm_eventhub_namespace.eventhub_namespace[split("|", each.key)[0]].name
  eventhub_name       = azurerm_eventhub.eventhub[each.key].name
  resource_group_name = var.resource_group_name

  listen = true
  send   = true
  manage = true
}
