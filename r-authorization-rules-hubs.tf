resource "azurerm_eventhub_authorization_rule" "listen" {
  for_each = { for a in local.hubs_auth_rules : a.hub_name => a if a.rule == "listen" && a.authorizations.listen }

  name                = try(format("%s-listen", each.value.custom_name), var.use_caf_naming ? azurecaf_name.eventhub_auth_rule[format("%s.listen", each.value.hub_name)].result : "listen-default")
  namespace_name      = azurerm_eventhub_namespace.eventhub.name
  eventhub_name       = azurerm_eventhub.eventhub[each.value.hub_name].name
  resource_group_name = var.resource_group_name

  listen = true
  send   = false
  manage = false
}

resource "azurerm_eventhub_authorization_rule" "send" {
  for_each = { for a in local.hubs_auth_rules : a.hub_name => a if a.rule == "send" && a.authorizations.send }

  name                = try(format("%s-listen", each.value.custom_name), var.use_caf_naming ? azurecaf_name.eventhub_auth_rule[format("%s.send", each.value.hub_name)].result : "send-default")
  namespace_name      = azurerm_eventhub_namespace.eventhub.name
  eventhub_name       = azurerm_eventhub.eventhub[each.value.hub_name].name
  resource_group_name = var.resource_group_name

  listen = false
  send   = true
  manage = false
}

resource "azurerm_eventhub_authorization_rule" "manage" {
  for_each = { for a in local.hubs_auth_rules : a.hub_name => a if a.rule == "manage" && a.authorizations.manage }

  name                = try(format("%s-listen", each.value.custom_name), var.use_caf_naming ? azurecaf_name.eventhub_auth_rule[format("%s.manage", each.value.hub_name)].result : "manage-default")
  namespace_name      = azurerm_eventhub_namespace.eventhub.name
  eventhub_name       = azurerm_eventhub.eventhub[each.value.hub_name].name
  resource_group_name = var.resource_group_name

  listen = true
  send   = true
  manage = true
}
