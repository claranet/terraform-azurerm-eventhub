output "resource_group_name" {
  description = "Azure Resource Group name."
  value       = var.resource_group_name
}

output "location" {
  description = "Azure region."
  value       = var.location
}

output "environment" {
  description = "Application environment."
  value       = var.environment
}

output "eventhubs" {
  description = "Azure Event Hubs outputs."
  value       = azurerm_eventhub.eventhub
}

output "namespace_id" {
  description = "Azure Event Hub Namespace ID."
  value       = azurerm_eventhub_namespace.eventhub.id
}

output "namespace_name" {
  description = "Azure Event Hub Namespace name."
  value       = azurerm_eventhub_namespace.eventhub.name
}

output "namespace_default_authorization_rule_name" {
  description = "Event Hub Namespace default authorization rule name."
  value       = "RootManageSharedAccessKey"
}

output "namespace_default_primary_connection_string" {
  description = "Event Hub Namespace default primary connection string."
  value       = azurerm_eventhub_namespace.eventhub.default_primary_connection_string
  sensitive   = true
}

output "namespace_default_primary_key" {
  description = "Event Hub Namespace default primary key."
  value       = azurerm_eventhub_namespace.eventhub.default_primary_key
  sensitive   = true
}

output "namespace_default_secondary_connection_string" {
  description = "Eventhub Namespace default secondary connection string."
  value       = azurerm_eventhub_namespace.eventhub.default_secondary_connection_string
  sensitive   = true
}

output "namespace_default_secondary_key" {
  description = "Event Hub Namespace default secondary key."
  value       = azurerm_eventhub_namespace.eventhub.default_secondary_key
  sensitive   = true
}

output "namespace_listen_authorization_rule" {
  description = "Event Hub Namespace listen only authorization rule."
  value       = try(azurerm_eventhub_namespace_authorization_rule.listen["enabled"], null)
}

output "namespace_send_authorization_rule" {
  description = "Event Hub Namespace send only authorization rule."
  value       = try(azurerm_eventhub_namespace_authorization_rule.send["enabled"], null)
}

output "namespace_manage_authorization_rule" {
  description = "Event Hub Namespace manage authorization rule."
  value       = try(azurerm_eventhub_namespace_authorization_rule.manage["enabled"], null)
}

output "consumer_groups" {
  description = "Azure Event Hub Consumer Groups."
  value       = try(azurerm_eventhub_consumer_group.eventhub_consumer_group, null)
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
