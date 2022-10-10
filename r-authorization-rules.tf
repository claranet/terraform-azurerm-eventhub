resource "azurerm_eventhub_namespace_authorization_rule" "listen" {
  name                = "listen-default"
  namespace_name      = azurerm_eventhub_namespace.eventhub.name
  resource_group_name = var.resource_group_name

  listen = true
  send   = false
  manage = false
}

resource "azurerm_eventhub_namespace_authorization_rule" "send" {
  name                = "send-default"
  namespace_name      = azurerm_eventhub_namespace.eventhub.name
  resource_group_name = var.resource_group_name

  listen = false
  send   = true
  manage = false
}

resource "azurerm_eventhub_namespace_authorization_rule" "manage" {
  name                = "manage-default"
  namespace_name      = azurerm_eventhub_namespace.eventhub.name
  resource_group_name = var.resource_group_name

  listen = true
  send   = true
  manage = true
}
