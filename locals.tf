locals {
  networks_rules = {
    subnet_ids = var.allowed_subnet_ids
    cidrs      = var.allowed_cidrs
  }

  hubs_auth_rules = flatten([
    for hub_name, hub in try(var.hubs_parameters, {}) : [
      for rule in ["listen", "send", "manage"] : {
        hub_name       = hub_name
        hub            = hub
        rule           = rule
        custom_name    = hub.custom_name
        authorizations = hub.authorizations
      }
    ]
  ])
}
