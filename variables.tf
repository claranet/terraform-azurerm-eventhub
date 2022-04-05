variable "client_name" {
  description = "Client name/account used in naming"
  type        = string

}

variable "environment" {
  description = "Project environment"
  type        = string
}

variable "stack" {
  description = "Project stack name"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure location for Eventhub."
  type        = string
}

variable "location_short" {
  description = "Short string for Azure location."
  type        = string
}

variable "eventhub_namespaces_hubs" {
  type        = any
  description = "Map to handle Eventhub creation. It supports the creation of the hubs, authorization_rule associated with each namespace you create"
}
