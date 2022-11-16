resource "azurerm_eventhub_namespace_authorization_rule" "listen" {
  for_each = toset(var.namespace_authorizations.listen ? ["enabled"] : [])

  name                = local.namespace_listen_rule_name
  namespace_name      = azurerm_eventhub_namespace.eventhub.name
  resource_group_name = var.resource_group_name

  listen = true
  send   = false
  manage = false
}

resource "azurerm_eventhub_namespace_authorization_rule" "send" {
  for_each = toset(var.namespace_authorizations.send ? ["enabled"] : [])

  name                = local.namespace_send_rule_name
  namespace_name      = azurerm_eventhub_namespace.eventhub.name
  resource_group_name = var.resource_group_name

  listen = false
  send   = true
  manage = false
}

resource "azurerm_eventhub_namespace_authorization_rule" "manage" {
  for_each = toset(var.namespace_authorizations.manage ? ["enabled"] : [])

  name                = local.namespace_manage_rule_name
  namespace_name      = azurerm_eventhub_namespace.eventhub.name
  resource_group_name = var.resource_group_name

  listen = true
  send   = true
  manage = true
}
