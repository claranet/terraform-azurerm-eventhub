locals {
  networks_rules = {
    subnet_ids = var.network_rules_enabled ? var.allowed_subnet_ids : []
    cidrs      = var.network_rules_enabled ? var.allowed_cidrs : []
  }
}
