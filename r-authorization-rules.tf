resource "azurerm_eventhub_namespace_authorization_rule" "listen" {
  for_each = toset(var.namespace_authorizations.listen ? ["enabled"] : [])

  name                = try(format("%s-listen", var.custom_namespace_auth_rule_name), var.use_caf_naming ? azurecaf_name.eventhub_namespace_auth_rule["listen"].result : "listen-default")
  namespace_name      = azurerm_eventhub_namespace.eventhub.name
  resource_group_name = var.resource_group_name

  listen = true
  send   = false
  manage = false
}

resource "azurerm_eventhub_namespace_authorization_rule" "send" {
  for_each = toset(var.namespace_authorizations.send ? ["enabled"] : [])

  name                = try(format("%s-send", var.custom_namespace_auth_rule_name), var.use_caf_naming ? azurecaf_name.eventhub_namespace_auth_rule["send"].result : "send-default")
  namespace_name      = azurerm_eventhub_namespace.eventhub.name
  resource_group_name = var.resource_group_name

  listen = false
  send   = true
  manage = false
}

resource "azurerm_eventhub_namespace_authorization_rule" "manage" {
  for_each = toset(var.namespace_authorizations.manage ? ["enabled"] : [])

  name                = try(format("%s-manage", var.custom_namespace_auth_rule_name), var.use_caf_naming ? azurecaf_name.eventhub_namespace_auth_rule["manage"].result : "manage-default")
  namespace_name      = azurerm_eventhub_namespace.eventhub.name
  resource_group_name = var.resource_group_name

  listen = true
  send   = true
  manage = true
}
