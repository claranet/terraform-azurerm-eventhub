# Azure Eventhub feature
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/claranet/eventhub/azurerm/)

This Terraform module creates an [Azure Eventhub](https://docs.microsoft.com/en-us/azure/event-hubs/).

## Requirements

* [AzureRM Terraform provider](https://www.terraform.io/docs/providers/azurerm/) >= 1.32

## Version compatibility

| Module version | Terraform version | AzureRM version |
| -------------- | ----------------- | --------------- |
| >= 5.x.x       | 0.15.x & 1.0.x    | >= 2.0          |
| >= 4.x.x       | 0.13.x            | >= 2.0          |
| >= 3.x.x       | 0.12.x            | >= 2.0          |
| >= 2.x.x       | 0.12.x            | < 2.0           |
| <  2.x.x       | 0.11.x            | < 2.0           |

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
  source  = "claranet/eventhub/azurerm"
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
}
```

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| azurerm | >= 1.36 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_eventhub.eventhub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub) | resource |
| [azurerm_eventhub_authorization_rule.manage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_authorization_rule) | resource |
| [azurerm_eventhub_authorization_rule.reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_authorization_rule) | resource |
| [azurerm_eventhub_authorization_rule.sender](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_authorization_rule) | resource |
| [azurerm_eventhub_namespace.eventhub_namespace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace) | resource |
| [azurerm_eventhub_namespace_authorization_rule.manage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace_authorization_rule) | resource |
| [azurerm_eventhub_namespace_authorization_rule.reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace_authorization_rule) | resource |
| [azurerm_eventhub_namespace_authorization_rule.sender](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace_authorization_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| client\_name | Client name/account used in naming | `string` | n/a | yes |
| environment | Project environment | `string` | n/a | yes |
| eventhub\_namespaces\_hubs | Map to handle Eventhub creation. It supports the creation of the hubs, authorization\_rule associated with each namespace you create | `any` | n/a | yes |
| extra\_tags | Extra tags to add | `map(string)` | `{}` | no |
| location | Azure location for Eventhub. | `string` | n/a | yes |
| location\_short | Short string for Azure location. | `string` | n/a | yes |
| resource\_group\_name | Name of the resource group | `string` | n/a | yes |
| stack | Project stack name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| hubs | Map of the hubs |
| hubs\_manages | Map of the Hubs manages access policies |
| hubs\_readers | Map of the Hubs readers access policies |
| hubs\_senders | Map of the Hubs senders access policies |
| namespaces | Map of the namespaces |
| namespaces\_manages | Map of the namespaces manages access policies |
| namespaces\_readers | Map of the namespaces readers access policies |
| namespaces\_senders | Map of the namespaces senders access policies |
<!-- END_TF_DOCS -->
## Related documentation

Microsoft Azure documentation: [docs.microsoft.com/en-us/azure/event-hubs/](https://docs.microsoft.com/en-us/azure/event-hubs/)
