output "resource_eventhubs" {
  description = "Azure Event Hubs resource objects."
  value       = azurerm_eventhub.main
}

output "resource_namespace" {
  description = "Azure Event Hub Namespace resource object."
  value       = azurerm_eventhub_namespace.main
}

output "identity_principal_id" {
  description = "Azure Event Hub Namespace system identity principal ID."
  value       = try(azurerm_eventhub_namespace.main.identity[0].principal_id, null)
}

output "module_diagnostics" {
  description = "Diagnostics settings module outputs."
  value       = module.diagnostics
}

output "namespace_id" {
  description = "Azure Event Hub Namespace ID."
  value       = azurerm_eventhub_namespace.main.id
}

output "namespace_name" {
  description = "Azure Event Hub Namespace name."
  value       = azurerm_eventhub_namespace.main.name
}

output "id" {
  description = "Azure Event Hub Namespace ID."
  value       = azurerm_eventhub_namespace.main.id
}

output "name" {
  description = "Azure Event Hub Namespace name."
  value       = azurerm_eventhub_namespace.main.name
}

output "namespace_default_primary_connection_string" {
  description = "Event Hub Namespace default primary connection string."
  value       = azurerm_eventhub_namespace.main.default_primary_connection_string
  sensitive   = true
}

output "namespace_default_primary_key" {
  description = "Event Hub Namespace default primary key."
  value       = azurerm_eventhub_namespace.main.default_primary_key
  sensitive   = true
}

output "namespace_default_secondary_connection_string" {
  description = "Eventhub Namespace default secondary connection string."
  value       = azurerm_eventhub_namespace.main.default_secondary_connection_string
  sensitive   = true
}

output "namespace_default_secondary_key" {
  description = "Event Hub Namespace default secondary key."
  value       = azurerm_eventhub_namespace.main.default_secondary_key
  sensitive   = true
}

output "resource_namespace_listen_authorization_rule" {
  description = "Event Hub Namespace listen only authorization rule resource."
  value       = one(azurerm_eventhub_namespace_authorization_rule.listen[*])
}

output "resource_namespace_send_authorization_rule" {
  description = "Event Hub Namespace send only authorization rule resource."
  value       = one(azurerm_eventhub_namespace_authorization_rule.send[*])
}

output "resource_namespace_manage_authorization_rule" {
  description = "Event Hub Namespace manage authorization rule resource."
  value       = one(azurerm_eventhub_namespace_authorization_rule.manage[*])
}

output "resource_consumer_groups" {
  description = "Azure Event Hub Consumer Groups resource objects."
  value       = try(azurerm_eventhub_consumer_group.main, null)
}

output "hubs_listen_authorization_rule" {
  description = "Event Hubs listen only authorization rules."
  value       = { for a in local.hubs_auth_rules : a.hub_name => azurerm_eventhub_authorization_rule.listen[a.hub_name] if a.rule == "listen" && a.authorizations.listen }
}

output "hubs_send_authorization_rule" {
  description = "Event Hubs send only authorization rules."
  value       = { for a in local.hubs_auth_rules : a.hub_name => azurerm_eventhub_authorization_rule.send[a.hub_name] if a.rule == "send" && a.authorizations.send }
}

output "hubs_manage_authorization_rule" {
  description = "Event Hubs Namespace manage authorization rules."
  value       = { for a in local.hubs_auth_rules : a.hub_name => azurerm_eventhub_authorization_rule.manage[a.hub_name] if a.rule == "manage" && a.authorizations.manage }
}
