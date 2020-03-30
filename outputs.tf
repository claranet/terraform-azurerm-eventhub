output "namespaces" {
  description = "Map of the namespaces"
  value = {
    for namespace, config in var.eventhub_namespaces_hubs :
    namespace => azurerm_eventhub_namespace.eventhub_namespace[namespace].id
  }
}

output "hubs" {
  description = "Map of the hubs"
  value = {
    for namespace, config in var.eventhub_namespaces_hubs :
    namespace => { for hub in local.hubs_list :
    azurerm_eventhub.eventhub[hub].name => azurerm_eventhub.eventhub[hub].id if split("|", hub)[0] == namespace }
  }
}

output "namespaces_senders" {
  description = "Map of the namespaces senders access policies"
  value = {
    for namespace, config in var.eventhub_namespaces_hubs :
    namespace => { for eventhub in local.namespaces_sender :
    azurerm_eventhub_namespace_authorization_rule.sender[eventhub].name => azurerm_eventhub_namespace_authorization_rule.sender[eventhub].primary_connection_string if eventhub == namespace }
  }
}

output "namespaces_readers" {
  description = "Map of the namespaces readers access policies"
  value = {
    for namespace, config in var.eventhub_namespaces_hubs :
    namespace => { for eventhub in local.namespaces_reader :
    azurerm_eventhub_namespace_authorization_rule.reader[eventhub].name => azurerm_eventhub_namespace_authorization_rule.reader[eventhub].primary_connection_string if eventhub == namespace }
  }
}

output "namespaces_manages" {
  description = "Map of the namespaces manages access policies"
  value = {
    for namespace, config in var.eventhub_namespaces_hubs :
    namespace => { for eventhub in local.namespaces_manage :
    azurerm_eventhub_namespace_authorization_rule.manage[eventhub].name => azurerm_eventhub_namespace_authorization_rule.manage[eventhub].primary_connection_string if eventhub == namespace }
  }
}

output "hubs_senders" {
  description = "Map of the Hubs senders access policies"
  value = {
    for namespace, config in var.eventhub_namespaces_hubs :
    namespace => { for hub in local.hubs_sender :
    azurerm_eventhub_authorization_rule.sender[hub].name => azurerm_eventhub_authorization_rule.sender[hub].primary_connection_string if split("|", hub)[0] == namespace }
  }
}

output "hubs_readers" {
  description = "Map of the Hubs readers access policies"
  value = {
    for namespace, config in var.eventhub_namespaces_hubs :
    namespace => { for hub in local.hubs_reader :
    azurerm_eventhub_authorization_rule.reader[hub].name => azurerm_eventhub_authorization_rule.reader[hub].primary_connection_string if split("|", hub)[0] == namespace }
  }
}

output "hubs_manages" {
  description = "Map of the Hubs manages access policies"
  value = {
    for namespace, config in var.eventhub_namespaces_hubs :
    namespace => { for hub in local.hubs_manage :
    azurerm_eventhub_authorization_rule.manage[hub].name => azurerm_eventhub_authorization_rule.manage[hub].primary_connection_string if split("|", hub)[0] == namespace }
  }
}
