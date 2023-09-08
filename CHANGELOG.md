# v7.3.0 - 2023-09-08

Breaking
  * AZ-1153: Remove `retention_days` parameters, it must be handled at destination level now. (for reference: [Provider issue](https://github.com/hashicorp/terraform-provider-azurerm/issues/23051))

# v7.2.2 - 2023-02-17

Fixed
  * AZ-1006: Fix `capture_description` preconditon

# v7.2.1 - 2023-01-13

Fixed
  * AZ-974: Fix EventHub authorization rules custom names

# v7.2.0 - 2022-11-23

Changed
  * AZ-908: Use the new data source for CAF naming (instead of resource)

# v7.1.0 - 2022-11-18

Fixed
  * AZ-909: Fix default values of `archive_name_format`and `name` in `hub_parameters` block

Added
  * AZ-909: Add custom name for EventHub namespace authorization rules
  * AZ-875: Add authorization rules for Hubs

# v7.0.1 - 2022-11-10

Fixed
  * AZ-875: Fix typo, code cleanup

# v7.0.0 - 2022-10-21

Breaking
  * AZ-840: Require Terraform 1.3+
  * AZ-875: Rework module code, minimum AzureRM version to `v3.28` (with latest EventHub resources fixes)

Changed
  * AZ-596: Code lint and refactor

# v5.1.0 - 2022-04-08

Added
  * AZ-615: Add an option to enable or disable default tags

# v5.0.0 - 2022-02-18

Breaking
  * AZ-515: Option to use Azure CAF naming provider to name resources
  * AZ-515: Require Terraform 0.13+

Added
  * AZ-589: Add and enable `diagnostics` for each Event Hub namespace

Changed
  * AZ-572: Revamp examples and improve CI

# v3.1.1/v4.0.1 - 2021-08-27

Changed
  * AZ-532: Revamp README with latest `terraform-docs` tool

# v3.1.0/v4.0.0 - 2021-01-21

Updated
  * AZ-273: Module now compatible terraform `v0.13+` and `v0.14+`

# v2.0.0/v3.0.0 - 2020-03-30

Added
  * AZ-196: Azure Event Hub - First Release
