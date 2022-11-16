locals {
  # Naming locals/constants
  name_prefix = lower(var.name_prefix)
  name_suffix = lower(var.name_suffix)

  namespace_name             = coalesce(var.custom_namespace_name, azurecaf_name.eventhub_namespace.result)
  namespace_listen_rule_name = coalesce(var.custom_namespace_listen_auth_rule_name, azurecaf_name.eventhub_namespace_auth_rule["listen"].result)
  namespace_send_rule_name   = coalesce(var.custom_namespace_send_auth_rule_name, azurecaf_name.eventhub_namespace_auth_rule["send"].result)
  namespace_manage_rule_name = coalesce(var.custom_namespace_manage_auth_rule_name, azurecaf_name.eventhub_namespace_auth_rule["manage"].result)
}
