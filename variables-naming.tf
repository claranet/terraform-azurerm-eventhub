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

variable "use_caf_naming" {
  description = "Use the Azure CAF naming provider to generate default resource name. `custom_namespace_name` override this if set. Legacy default name is used if this is set to `false`."
  type        = bool
  default     = true
}

# Custom resource names
variable "custom_namespace_name" {
  description = "Custom resource name for EventHub namespace."
  type        = string
  default     = ""
}

variable "custom_namespace_listen_auth_rule_name" {
  description = "Custom listen authorization rule name for EventHub namespace."
  type        = string
  default     = ""
}

variable "custom_namespace_manage_auth_rule_name" {
  description = "Custom manage authorization rule name for EventHub namespace."
  type        = string
  default     = ""
}

variable "custom_namespace_send_auth_rule_name" {
  description = "Custom send authorization rule name for EventHub namespace."
  type        = string
  default     = ""
}