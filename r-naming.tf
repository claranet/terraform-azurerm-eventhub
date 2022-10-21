resource "azurecaf_name" "eventhub_namespace" {
  name          = var.stack
  resource_type = "azurerm_eventhub_namespace"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix, var.use_caf_naming ? "" : "eh"])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}

resource "azurecaf_name" "eventhub" {
  for_each = var.hubs_parameters

  name          = var.stack
  resource_type = "azurerm_eventhub"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, each.key, local.name_suffix])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}

resource "azurecaf_name" "consumer_group" {
  for_each = var.hubs_parameters

  name          = var.stack
  resource_type = "azurerm_eventhub_consumer_group"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, each.key, local.name_suffix, var.use_caf_naming ? "" : "ehcg"])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}

resource "azurecaf_name" "eventhub_namespace_auth_rule_listen" {
  name          = var.stack
  resource_type = "azurerm_eventhub_namespace_authorization_rule"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, "listen", local.name_suffix])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}

resource "azurecaf_name" "eventhub_namespace_auth_rule_send" {
  name          = var.stack
  resource_type = "azurerm_eventhub_namespace_authorization_rule"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, "send", local.name_suffix])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}

resource "azurecaf_name" "eventhub_namespace_auth_rule_manage" {
  name          = var.stack
  resource_type = "azurerm_eventhub_namespace_authorization_rule"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, "manage", local.name_suffix])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}
