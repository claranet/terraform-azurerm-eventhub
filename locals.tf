locals {
  networks_rules = {
    subnet_ids = var.allowed_subnet_ids
    cidrs      = var.allowed_cidrs
  }
}
