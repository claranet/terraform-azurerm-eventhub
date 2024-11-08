resource "azurerm_eventhub_namespace_authorization_rule" "listen" {
  count = var.namespace_authorizations.listen ? 1 : 0

  name                = try(format("%s-listen", var.custom_namespace_auth_rule_name), data.azurecaf_name.eventhub_namespace_auth_rule["listen"].result)
  namespace_name      = azurerm_eventhub_namespace.main.name
  resource_group_name = var.resource_group_name

  listen = true
  send   = false
  manage = false
}

moved {
  from = azurerm_eventhub_authorization_rule.listen["enabled"]
  to   = azurerm_eventhub_authorization_rule.listen[0]
}

resource "azurerm_eventhub_namespace_authorization_rule" "send" {
  count = var.namespace_authorizations.send ? 1 : 0

  name                = try(format("%s-send", var.custom_namespace_auth_rule_name), data.azurecaf_name.eventhub_namespace_auth_rule["send"].result)
  namespace_name      = azurerm_eventhub_namespace.main.name
  resource_group_name = var.resource_group_name

  listen = false
  send   = true
  manage = false
}

moved {
  from = azurerm_eventhub_authorization_rule.send["enabled"]
  to   = azurerm_eventhub_authorization_rule.send[0]
}

resource "azurerm_eventhub_namespace_authorization_rule" "manage" {
  count = var.namespace_authorizations.manage ? 1 : 0

  name                = try(format("%s-manage", var.custom_namespace_auth_rule_name), data.azurecaf_name.eventhub_namespace_auth_rule["manage"].result)
  namespace_name      = azurerm_eventhub_namespace.main.name
  resource_group_name = var.resource_group_name

  listen = true
  send   = true
  manage = true
}

moved {
  from = azurerm_eventhub_authorization_rule.manage["enabled"]
  to   = azurerm_eventhub_authorization_rule.manage[0]
}
