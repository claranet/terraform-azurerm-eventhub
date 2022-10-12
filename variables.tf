# Generic variables

variable "client_name" {
  description = "Client name/account used in naming."
  type        = string
}

variable "environment" {
  description = "Project environment."
  type        = string
}

variable "stack" {
  description = "Project stack name."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group."
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

# EventHub Namespace & Cluster
variable "cluster_enabled" {
  description = "If `true`, an EventHub Cluster is created and associated to the Namespace."
  type        = bool
  default     = false
}

variable "namespace_parameters" {
  description = <<EOD
EventHub Namespace parameters:
```
- sku:                  Defines which tier to use. Valid options are `Basic`, `Standard`, and `Premium`. Please not that setting this field to Premium will force the creation of a new resource and also requires setting zone_redundant to true.
- capacity:             Specifies the Capacity / Throughput Units for a Standard SKU namespace. Default capacity has a maximum of 2, but can be increased in blocks of 2 on a committed purchase basis.
- auto_inflate_enabled: Is Auto Inflate enabled for the Event Hub namespace?
- dedicated_cluster_id: Specifies the ID of the Event Hub Dedicated Cluster where this namespace should created.
- maximum_throughput_units: Specifies the maximum number of throughput units when Auto Inflate is Enabled. Valid values range from `1 - 20`.
- zone_redundant:       Specifies if the Event Hub namespace should be Zone Redundant (created across Availability Zones). Changing this forces a new resource to be created.
- local_authentication_enabled: Is SAS authentication enabled for the EventHub Namespace?
- public_network_access_enabled: Is public network access enabled for the EventHub Namespace? Defaults to `true`.
- minimum_tls_version:  The minimum supported TLS version for this EventHub Namespace. Valid values are: `1.0`, `1.1` and `1.2`. The current default minimum TLS version is `1.2`.
```
EOD
  type = object({
    sku                           = string
    capacity                      = optional(number, 2)
    auto_inflate_enabled          = optional(bool, false)
    dedicated_cluster_id          = optional(string)
    maximum_throughput_units      = optional(number)
    zone_redundant                = optional(bool, true)
    local_authentication_enabled  = optional(bool)
    public_network_access_enabled = optional(bool, true)
    minimum_tls_version           = optional(string, "1.2")
  })
  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.namespace_parameters.sku)
    error_message = "SKU value is invalid. Must be `Basic`, `Standard` or `Premium`."
  }
}

variable "namespace_network_rules" {
  description = "`network_rulesets` block as defined below."
  default     = null
  type = object({
    default_action                 = optional(string, "Deny")
    trusted_service_access_enabled = optional(bool, true)
    virtual_network_rules = optional(list(object({
      subnet_id                                       = string
      ignore_missing_virtual_network_service_endpoint = optional(bool, false)
    })), [])
    ip_rules = optional(list(string), [])
  })
}

variable "namespace_authorizations" {
  description = "Object to specify which Namespace authorizations need to be created."
  type = object({
    listen = optional(bool, true)
    send   = optional(bool, true)
    manage = optional(bool, true)
  })
  default = {}
}

# EventHubs

variable "hubs_parameters" {
  description = "Map of Event Hub parameters objects (key is hub shortname)."
  type = map(object({
    custom_name       = optional(string)
    partition_count   = number
    message_retention = optional(number, 7)
    capture_description = optional(object({
      enabled             = optional(bool, true)
      encoding            = string
      interval_in_seconds = optional(number)
      size_limit_in_bytes = optional(number)
      skip_empty_archives = optional(bool)
      destination = object({
        name                = optional(string)
        archive_name_format = optional(string, "EventHubArchive.AzureBlockBlob")
        blob_container_name = string
        storage_account_id  = string
      })
    }))

    consumer_group = optional(object({
      enabled       = optional(bool, false)
      custom_name   = optional(string)
      user_metadata = optional(string)
    }), {})
  }))
  default = {}
}
