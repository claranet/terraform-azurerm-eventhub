# Azure Eventhub feature

This Terraform module creates an [Azure Eventhub](https://docs.microsoft.com/en-us/azure/event-hubs/).

## Requirements

* [AzureRM Terraform provider](https://www.terraform.io/docs/providers/azurerm/) >= 1.32

## Terraform version compatibility

| Module version | Terraform version |
|----------------|-------------------|
| x.x.x          | 0.12.20           |

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

You can use this module by including it this way:

```hcl
module "azure-region" {
  source  = "claranet/regions/azurerm"
  version = "x.x.x"

  azure_region = var.azure_region
}

module "rg" {
  source  = "claranet/rg/azurerm"
  version = "x.x.x"

  location    = module.azure-region.location
  client_name = var.client_name
  environment = var.environment
  stack       = var.stack
}

module "eventhub" {
  source  = "claranet/service_bus/azurerm"
  version = "x.x.x"

  location       = module.azure-region.location
  location_short = module.azure-region.location_short
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

    # Or customize everything
    eventhub2 = {
      custom_name = format("%s-%s-%s-custom", var.stack, var.client_name, module.azure-region.location_short)
      sku         = "Premium"
      capacity    = 2

      hubs = {
        hub100 = {
          reader = true
          sender = true
          manage = true
        }
        hub200 = {
          dead_lettering_on_message_expiration = true
          default_message_ttl                  = "PT10M"
          reader                               = true
        }
        hub300 = {
          duplicate_detection_history_time_window = "PT30M"
          sender                                  = true
        }
        hub400 = {  
          requires_duplicate_detection = true
          manage                       = true
        }
      }
    }
  }
}
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| client\_name | Client name/account used in naming | `string` | n/a | yes | 
| environment | Project environment | `string` | n/a | yes |
| extra\_tags | Extra tags to add | `map(string)` | `{}` | no |
| location | Azure location for eventhub. | `string` | n/a | yes |
| location\_short | Short string for Azure location. | `string` | n/a | yes |
| resource\_group\_name | Name of the resource group | `string` | n/a | yes |
| eventhub\_namespaces\_hubs | Map to handle eventhub creation. It supports the creation of the hubs, authorization\_rule associated with each namespace you create | `any` | n/a | yes |
| stack | Project stack name | `string` | n/a | yes |

## Outputs 

| Name | Description |
|------|-------------|
| manages | Map of the manages access policies |
| namespaces | Map of the namespaces |
| hubs | Map of the hubs |
| readers | Map of the readers access policies |
| senders | Map of the senders access policies |

## Related documentation

Terraform resource documentation on Eventhub namespace: [https://www.terraform.io/docs/providers/azurerm/r/eventhub_namespace.html](https://www.https://www.terraform.io/docs/providers/azurerm/r/eventhub_namespace.html)
Terraform resource documentation on Eventhub hub: [https://www.terraform.io/docs/providers/azurerm/r/eventhub.html](https://www.https://www.terraform.io/docs/providers/azurerm/r/eventhub.html)

Microsoft Azure documentation: [https://docs.microsoft.com/en-us/azure/event-hubs/](https://docs.microsoft.com/en-us/azure/event-hubs/)
