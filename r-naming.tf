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

resource "azurecaf_name" "eventhub_namespace_auth_rule_reader" {
  name          = var.stack
  resource_type = "azurerm_eventhub_namespace_authorization_rule"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, "reader", local.name_suffix])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}

resource "azurecaf_name" "eventhub_namespace_auth_rule_sender" {
  name          = var.stack
  resource_type = "azurerm_eventhub_namespace_authorization_rule"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, "sender", local.name_suffix])
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

# resource "azurecaf_name" "eventhub_auth_rule_reader" {
#   for_each = toset(local.hubs_reader)

#   name          = var.stack
#   resource_type = "azurerm_eventhub_authorization_rule"
#   prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
#   suffixes      = compact([var.client_name, var.location_short, var.environment, split("|", each.key)[1], "reader", local.name_suffix])
#   use_slug      = var.use_caf_naming
#   clean_input   = true
#   separator     = "-"
# }

# resource "azurecaf_name" "eventhub_auth_rule_sender" {
#   for_each = toset(local.hubs_sender)

#   name          = var.stack
#   resource_type = "azurerm_eventhub_authorization_rule"
#   prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
#   suffixes      = compact([var.client_name, var.location_short, var.environment, split("|", each.key)[1], "sender", local.name_suffix])
#   use_slug      = var.use_caf_naming
#   clean_input   = true
#   separator     = "-"
# }

# resource "azurecaf_name" "eventhub_auth_rule_manage" {
#   for_each = toset(local.hubs_manage)

#   name          = var.stack
#   resource_type = "azurerm_eventhub_authorization_rule"
#   prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
#   suffixes      = compact([var.client_name, var.location_short, var.environment, split("|", each.key)[1], "manage", local.name_suffix])
#   use_slug      = var.use_caf_naming
#   clean_input   = true
#   separator     = "-"
# }
