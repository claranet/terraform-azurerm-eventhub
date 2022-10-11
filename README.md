# Azure Eventhub feature
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/claranet/eventhub/azurerm/)

This Terraform module creates an [Azure Eventhub](https://docs.microsoft.com/en-us/azure/event-hubs/).

<!-- BEGIN_TF_DOCS -->
## Global versioning rule for Claranet Azure modules

| Module version | Terraform version | AzureRM version |
| -------------- | ----------------- | --------------- |
| >= 7.x.x       | 1.3.x             | >= 3.0          |
| >= 6.x.x       | 1.x               | >= 3.0          |
| >= 5.x.x       | 0.15.x            | >= 2.0          |
| >= 4.x.x       | 0.13.x / 0.14.x   | >= 2.0          |
| >= 3.x.x       | 0.12.x            | >= 2.0          |
| >= 2.x.x       | 0.12.x            | < 2.0           |
| <  2.x.x       | 0.11.x            | < 2.0           |

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

```hcl
module "azure_region" {
  source  = "claranet/regions/azurerm"
  version = "x.x.x"

  azure_region = var.azure_region
}

module "rg" {
  source  = "claranet/rg/azurerm"
  version = "x.x.x"

  location    = module.azure_region.location
  client_name = var.client_name
  environment = var.environment
  stack       = var.stack
}

module "logs" {
  source  = "claranet/run-common/azurerm//modules/logs"
  version = "x.x.x"

  client_name         = var.client_name
  environment         = var.environment
  stack               = var.stack
  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.resource_group_name
}

module "eventhub" {
  source  = "claranet/eventhub/azurerm"
  version = "x.x.x"

  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  client_name    = var.client_name
  environment    = var.environment
  stack          = var.stack

  resource_group_name = module.rg.resource_group_name

  eventhub_namespaces_hubs = {
    # You can just create a eventhub_namespace
    eventhub0 = {}

    # Or create a eventhub_namespace with some hubs with default values
    eventhub1 = {
      hubs = {
        hub1 = {}
        hub2 = {}
      }
    }

    eventhub2 = {
      custom_name          = "testeventhub"
      sku                  = "Standard"
      capacity             = 1
      auto_inflate_enabled = true
      reader               = true
      hubs = {
        hubcentdeux = {
          message_retention = 7
          partition_count   = 2
          sender            = true
          manage            = true
        }
      }
    }
  }

  logs_destinations_ids = [
    module.logs.logs_storage_account_id,
    module.logs.log_analytics_workspace_id
  ]
}
```

## Providers

| Name | Version |
|------|---------|
| azurecaf | ~> 1.1 |
| azurerm | ~> 3.23 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| diagnostics | claranet/diagnostic-settings/azurerm | 6.0.0 |

## Resources

| Name | Type |
|------|------|
| [azurecaf_name.consumer_group](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/name) | resource |
| [azurecaf_name.eventhub](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/name) | resource |
| [azurecaf_name.eventhub_namespace](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/name) | resource |
| [azurecaf_name.eventhub_namespace_auth_rule_listen](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/name) | resource |
| [azurecaf_name.eventhub_namespace_auth_rule_manage](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/name) | resource |
| [azurecaf_name.eventhub_namespace_auth_rule_send](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/name) | resource |
| [azurerm_eventhub.eventhub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub) | resource |
| [azurerm_eventhub_cluster.cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_cluster) | resource |
| [azurerm_eventhub_consumer_group.eventhub_consumer_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_consumer_group) | resource |
| [azurerm_eventhub_namespace.eventhub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace) | resource |
| [azurerm_eventhub_namespace_authorization_rule.listen](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace_authorization_rule) | resource |
| [azurerm_eventhub_namespace_authorization_rule.manage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace_authorization_rule) | resource |
| [azurerm_eventhub_namespace_authorization_rule.send](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace_authorization_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| client\_name | Client name/account used in naming. | `string` | n/a | yes |
| cluster\_enabled | If `true`, an EventHub Cluster is created and associated to the Namespace. | `bool` | `false` | no |
| custom\_diagnostic\_settings\_name | Custom name of the diagnostics settings, name will be 'default' if not set. | `string` | `"default"` | no |
| custom\_namespace\_name | Custom resource name for EventHub namespace. | `string` | `""` | no |
| default\_tags\_enabled | Option to enable or disable default tags | `bool` | `true` | no |
| environment | Project environment. | `string` | n/a | yes |
| extra\_tags | Extra tags to add | `map(string)` | `{}` | no |
| hubs\_parameters | Map of Event Hub parameters objects (key is hub shortname). | <pre>map(object({<br>    custom_name       = optional(string)<br>    partition_count   = number<br>    message_retention = optional(number, 7)<br>    capture_description = optional(object({<br>      enabled             = optional(bool, true)<br>      encoding            = string<br>      interval_in_seconds = optional(number)<br>      size_limit_in_bytes = optional(number)<br>      skip_empty_archives = optional(bool)<br>      destination = object({<br>        name                = optional(string)<br>        archive_name_format = optional(string, "EventHubArchive.AzureBlockBlob")<br>        blob_container_name = string<br>        storage_account_id  = string<br>      })<br>    }))<br><br>    consumer_group = optional(object({<br>      enabled       = optional(bool, false)<br>      custom_name   = optional(string)<br>      user_metadata = optional(string)<br>    }), {})<br>  }))</pre> | `{}` | no |
| location | Azure location for Eventhub. | `string` | n/a | yes |
| location\_short | Short string for Azure location. | `string` | n/a | yes |
| logs\_categories | Log categories to send to destinations. | `list(string)` | `null` | no |
| logs\_destinations\_ids | List of destination resources Ids for logs diagnostics destination. Can be Storage Account, Log Analytics Workspace and Event Hub. No more than one of each can be set. Empty list to disable logging. | `list(string)` | n/a | yes |
| logs\_metrics\_categories | Metrics categories to send to destinations. | `list(string)` | `null` | no |
| logs\_retention\_days | Number of days to keep logs on storage account | `number` | `30` | no |
| name\_prefix | Optional prefix for the generated name | `string` | `""` | no |
| name\_suffix | Optional suffix for the generated name | `string` | `""` | no |
| namespace\_authorizations | Object to specify which Namespace authorizations need to be created. | <pre>object({<br>    listen = optional(bool, true)<br>    send   = optional(bool, true)<br>    manage = optional(bool, true)<br>  })</pre> | `{}` | no |
| namespace\_network\_rules | `network_rulesets` block as defined below. | <pre>object({<br>    default_action                 = optional(string, "Deny")<br>    trusted_service_access_enabled = optional(bool, true)<br>    virtual_network_rules = optional(list(object({<br>      subnet_id                                       = string<br>      ignore_missing_virtual_network_service_endpoint = optional(bool, false)<br>    })), [])<br>    ip_rules = optional(list(object({<br>      ip_mask = string<br>      action  = optional(string, "Allow")<br>    })), [])<br>  })</pre> | `null` | no |
| namespace\_parameters | EventHub Namespace parameters.<br> * sku:                  Defines which tier to use. Valid options are `Basic`, `Standard`, and `Premium`. Please not that setting this field to Premium will force the creation of a new resource and also requires setting zone\_redundant to true.<br> * capacity:             Specifies the Capacity / Throughput Units for a Standard SKU namespace. Default capacity has a maximum of 2, but can be increased in blocks of 2 on a committed purchase basis.<br> * auto\_inflate\_enabled: Is Auto Inflate enabled for the Event Hub namespace?<br> * dedicated\_cluster\_id: Specifies the ID of the Event Hub Dedicated Cluster where this namespace should created.<br> * maximum\_throughput\_units: Specifies the maximum number of throughput units when Auto Inflate is Enabled. Valid values range from `1 - 20`.<br> * zone\_redundant:       Specifies if the Event Hub namespace should be Zone Redundant (created across Availability Zones). Changing this forces a new resource to be created.<br> * local\_authentication\_enabled: Is SAS authentication enabled for the EventHub Namespace?<br> * public\_network\_access\_enabled: Is public network access enabled for the EventHub Namespace? Defaults to `true`.<br> * minimum\_tls\_version:  The minimum supported TLS version for this EventHub Namespace. Valid values are: `1.0`, `1.1` and `1.2`. The current default minimum TLS version is `1.2`. | <pre>object({<br>    sku                           = string<br>    capacity                      = optional(number, 2)<br>    auto_inflate_enabled          = optional(bool, false)<br>    dedicated_cluster_id          = optional(string)<br>    maximum_throughput_units      = optional(number)<br>    zone_redundant                = optional(bool, true)<br>    local_authentication_enabled  = optional(bool)<br>    public_network_access_enabled = optional(bool, true)<br>    minimum_tls_version           = optional(string, "1.2")<br>  })</pre> | n/a | yes |
| resource\_group\_name | Name of the resource group. | `string` | n/a | yes |
| stack | Project stack name. | `string` | n/a | yes |
| use\_caf\_naming | Use the Azure CAF naming provider to generate default resource name. `custom_namespace_name` override this if set. Legacy default name is used if this is set to `false`. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| consumer\_groups | Azure Event Hub Consumer Groups |
| environment | Application environment |
| eventhubs | Azure Event Hubs outputs |
| location | Azure region |
| namespace\_default\_authorization\_rule\_name | Event Hub namespace default authorization rule name |
| namespace\_default\_primary\_connection\_string | Event Hub namespace default primary connection string |
| namespace\_default\_primary\_key | Event Hub namespace default primary key |
| namespace\_default\_secondary\_connection\_string | Eventhub namespace default secondary connection string |
| namespace\_default\_secondary\_key | Event Hub namespace default secondary key |
| namespace\_id | Azure Event Hub namespace id |
| namespace\_listen\_authorization\_rule | Event Hub namespace listen only authorization rule |
| namespace\_name | Azure Event Hub namespace name |
| namespace\_send\_authorization\_manage | Event Hub namespace manage only authorization rule |
| namespace\_send\_authorization\_rule | Event Hub namespace send only authorization rule |
| resource\_group\_name | Azure Resource Group name |
<!-- END_TF_DOCS -->
## Related documentation

Microsoft Azure documentation: [docs.microsoft.com/en-us/azure/event-hubs/](https://docs.microsoft.com/en-us/azure/event-hubs/)
