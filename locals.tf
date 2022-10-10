locals {
  default_tags = {
    environment = var.environment
    application = var.application
    business    = var.business
  }

  enforced_tags = {
    sg_Resource_ControlTower_Profile         = var.namespace_is_public ? "Public" : "Private" # EVT-HUB-01
    sg_Resource_ControlTower_Confidentiality = "C2"                                           # EVT-HUB-10
  }

  tags = merge(local.default_tags, var.extra_tags, local.enforced_tags)
}
