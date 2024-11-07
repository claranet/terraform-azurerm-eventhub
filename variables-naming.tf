# Generic naming variables
variable "name_prefix" {
  description = "Optional prefix for the generated name"
  type        = string
  default     = ""
}

variable "name_suffix" {
  description = "Optional suffix for the generated name"
  type        = string
  default     = ""
}

# Custom resource names
variable "custom_name" {
  description = "Custom resource name for EventHub namespace."
  type        = string
  default     = ""
}

variable "custom_namespace_auth_rule_name" {
  description = "Custom authorization rule name for EventHub namespace."
  type        = string
  default     = null
}
