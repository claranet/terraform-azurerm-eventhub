output "resource_group_name" {
  description = "Azure Resource Group name"
  value       = var.resource_group_name
}

output "location" {
  description = "Azure region"
  value       = var.location
}

output "environment" {
  description = "Application environment"
  value       = var.environment
}

output "tags" {
  description = "Tags set on resources"
  value       = local.tags
}

output "id" {
  description = "Azure Event Hub ID"
  value       = azurerm_eventhub.eventhub.id
}

output "name" {
  description = "Azure Event Hub name"
  value       = azurerm_eventhub.eventhub.name
}

output "partition_ids" {
  description = "The identifiers for partitions created for Event Hubs."
  value       = azurerm_eventhub.eventhub.partition_ids
}

output "namespace_id" {
  description = "Azure Event Hub namespace id"
  value       = azurerm_eventhub_namespace.eventhub.id
}

output "namespace_name" {
  description = "Azure Event Hub namespace name"
  value       = azurerm_eventhub_namespace.eventhub.name
}

output "namespace_default_authorization_rule_name" {
  description = "Event Hub namespace default authorization rule name"
  value       = "RootManageSharedAccessKey"
}

output "namespace_default_primary_connection_string" {
  description = "Event Hub namespace default primary connection string"
  value       = azurerm_eventhub_namespace.eventhub.default_primary_connection_string
}

output "namespace_default_primary_key" {
  description = "Event Hub namespace default primary key"
  value       = azurerm_eventhub_namespace.eventhub.default_primary_key
}

output "namespace_default_secondary_connection_string" {
  description = "Eventhub namespace default secondary connection string"
  value       = azurerm_eventhub_namespace.eventhub.default_secondary_connection_string
}

output "namespace_default_secondary_key" {
  description = "Event Hub namespace default secondary key"
  value       = azurerm_eventhub_namespace.eventhub.default_secondary_key
}

output "namespace_listen_authorization_rule_name" {
  description = "Event Hub namespace listen only authorization rule name"
  value       = azurerm_eventhub_namespace_authorization_rule.listen.name
}

output "namespace_listen_primary_connection_string" {
  description = "Event Hub namespace listen only primary connection string"
  value       = azurerm_eventhub_namespace_authorization_rule.listen.primary_connection_string
}

output "namespace_listen_primary_key" {
  description = "Event Hub namespace listen only primary key"
  value       = azurerm_eventhub_namespace_authorization_rule.listen.primary_key
}

output "namespace_listen_secondary_connection_string" {
  description = "Event Hub namespace listen only secondary connection string"
  value       = azurerm_eventhub_namespace_authorization_rule.listen.secondary_connection_string
}

output "namespace_listen_secondary_key" {
  description = "Event Hub namespace listen only secondary key"
  value       = azurerm_eventhub_namespace_authorization_rule.listen.secondary_key
}

output "namespace_send_authorization_rule_name" {
  description = "Event Hub namespace send only authorization rule name"
  value       = azurerm_eventhub_namespace_authorization_rule.listen.name
}

output "namespace_send_primary_connection_string" {
  description = "Event Hub namespace send only primary connection string"
  value       = azurerm_eventhub_namespace_authorization_rule.send.primary_connection_string
}

output "namespace_send_primary_key" {
  description = "Eventhub namespace send only primary key"
  value       = azurerm_eventhub_namespace_authorization_rule.send.primary_key
}

output "namespace_send_secondary_connection_string" {
  description = "Event Hub namespace send only secondary connection string"
  value       = azurerm_eventhub_namespace_authorization_rule.send.secondary_connection_string
}

output "namespace_send_secondary_key" {
  description = "Event Hub namespace send only secondary key"
  value       = azurerm_eventhub_namespace_authorization_rule.send.secondary_key
}

output "namespace_manage_authorization_rule_name" {
  description = "Event Hub namespace manage only authorization rule name"
  value       = azurerm_eventhub_namespace_authorization_rule.manage.name
}

output "namespace_manage_primary_connection_string" {
  description = "Event Hub namespace manage only primary connection string"
  value       = azurerm_eventhub_namespace_authorization_rule.manage.primary_connection_string
}

output "namespace_manage_primary_key" {
  description = "Event Hub namespace manage only primary key"
  value       = azurerm_eventhub_namespace_authorization_rule.manage.primary_key
}

output "namespace_manage_secondary_connection_string" {
  description = "Event Hub namespace manage only secondary connection string"
  value       = azurerm_eventhub_namespace_authorization_rule.manage.secondary_connection_string
}

output "namespace_manage_secondary_key" {
  description = "Event Hub namespace manage only secondary key"
  value       = azurerm_eventhub_namespace_authorization_rule.manage.secondary_key
}

output "consumer_group_id" {
  description = "Azure Event Hub Consumer Group ID"
  value       = azurerm_eventhub_consumer_group.eventhub.id
}

output "consumer_group_name" {
  description = "Azure Event Hub Consumer Group name"
  value       = azurerm_eventhub_consumer_group.eventhub.name
}
