variable "location" {
  description = "Azure region"
  type        = string
  default     = ""
}

variable "environment" {
  description = "Project environment"
  type        = string
}

variable "extra_tags" {
  description = "Extra tags"
  type        = map(string)
  default     = {}
}

variable "resource_group_name" {
  description = "Azure Resource Group name"
  type        = string
}

# EVT-HUB-01
variable "namespace_is_public" {
  description = "Specify the current use case (sg_Resource_ControlTower_Profile=Public or Private)."
  type        = bool
  default     = false
}

variable "namespace_sku" {
  description = "Defines which tier to use. Valid options are Basic, Standard, and Premium. Please not that setting this field to Premium will force the creation of a new resource and also requires setting zone_redundant to true."
  type        = string
  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.namespace_sku)
    error_message = "Sku value is invalid. Must be `Basic`, `Standard` or `Premium`."
  }
}

variable "namespace_capacity" {
  description = "Specifies the Capacity / Throughput Units for a Standard SKU namespace. Default capacity has a maximum of 2, but can be increased in blocks of 2 on a committed purchase basis."
  type        = number
  default     = 2
}

variable "namespace_auto_inflate_enabled" {
  description = "Is Auto Inflate enabled for the Event Hub namespace ?"
  type        = bool
  default     = false
}

variable "namespace_dedicated_cluster_id" {
  description = "Specifies the ID of the Event Hub Dedicated Cluster where this namespace should created."
  type        = string
  default     = null
}

variable "namespace_maximum_throughput_units" {
  description = "Specifies the maximum number of throughput units when Auto Inflate is Enabled. Valid values range from 1 - 20."
  type        = number
  default     = null
}

variable "namespace_zone_redundant" {
  description = "Specifies if the Event Hub namespace should be Zone Redundant (created across Availability Zones). Changing this forces a new resource to be created."
  type        = bool
  default     = true
}

variable "partition_count" {
  description = "Specifies the current number of shards on the Event Hub."
  type        = number
}

variable "message_retention" {
  description = "Specifies the number of days to retain the events for this Event Hub."
  type        = number
  default     = 7
}

variable "capture_description" {
  description = "Capture description for this Event Hub"
  type = object({
    enabled             = optional(bool)
    encoding            = string
    interval_in_seconds = optional(number)
    size_limit_in_bytes = optional(number)
    skip_empty_archives = optional(bool)
    destination = object({
      name                = optional(string)
      archive_name_format = string
      blob_container_name = string
      storage_account_id  = string
    })
  })
  default = null
}

variable "consumer_group_user_metadata" {
  description = "User metadata for Event Hub Consumer group"
  type        = string
  default     = null
}
