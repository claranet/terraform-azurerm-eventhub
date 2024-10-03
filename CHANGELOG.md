## 7.4.0 (2024-10-03)

### Features

* use Claranet "azurecaf" provider cf1966d

### Documentation

* update README badge to use OpenTofu registry 66a42b7
* update README with `terraform-docs` v0.19.0 a3ae954

### Continuous Integration

* **AZ-1391:** enable semantic-release [skip ci] d185a2d
* **AZ-1391:** update semantic-release config [skip ci] 12bc7ba

### Miscellaneous Chores

* **deps:** add renovate.json 2c12546
* **deps:** enable automerge on renovate fa036e5
* **deps:** update dependency opentofu to v1.7.0 67a66ee
* **deps:** update dependency opentofu to v1.7.1 a0c48b7
* **deps:** update dependency opentofu to v1.7.2 a4435dc
* **deps:** update dependency opentofu to v1.7.3 15f9beb
* **deps:** update dependency opentofu to v1.8.0 bdb39e6
* **deps:** update dependency opentofu to v1.8.1 0e4adc6
* **deps:** update dependency pre-commit to v3.7.1 6763fe6
* **deps:** update dependency pre-commit to v3.8.0 e37d6f5
* **deps:** update dependency terraform-docs to v0.18.0 eaae6ed
* **deps:** update dependency terraform-docs to v0.19.0 0644e2b
* **deps:** update dependency tflint to v0.51.0 b33d060
* **deps:** update dependency tflint to v0.51.1 275cdf4
* **deps:** update dependency tflint to v0.51.2 ec6c709
* **deps:** update dependency tflint to v0.52.0 8dd0aca
* **deps:** update dependency tflint to v0.53.0 b7aabd9
* **deps:** update dependency trivy to v0.50.2 7aa7b17
* **deps:** update dependency trivy to v0.50.4 10caa66
* **deps:** update dependency trivy to v0.51.0 c537c2a
* **deps:** update dependency trivy to v0.51.1 9391c20
* **deps:** update dependency trivy to v0.51.2 cd47360
* **deps:** update dependency trivy to v0.51.4 5016d14
* **deps:** update dependency trivy to v0.52.0 1d279f9
* **deps:** update dependency trivy to v0.52.1 807bb59
* **deps:** update dependency trivy to v0.52.2 d4b4cf6
* **deps:** update dependency trivy to v0.53.0 12a5b43
* **deps:** update dependency trivy to v0.54.1 88b55b4
* **deps:** update dependency trivy to v0.55.0 940a3fc
* **deps:** update dependency trivy to v0.55.1 3a86163
* **deps:** update dependency trivy to v0.55.2 e67e941
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.17.0 32408c1
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.18.0 aa60131
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.0 f73e7be
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.1 ed35ec0
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.2 32e546e
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.3 a8674c6
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.93.0 0e83aff
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.0 1237585
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.1 c7465a3
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.3 2083821
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.95.0 fe3247c
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.96.0 b5fbcaf
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.96.1 de12046
* **deps:** update renovate.json 8f7f448
* **deps:** update tools 092cc55
* **pre-commit:** update commitlint hook 7a07a4f
* **release:** remove legacy `VERSION` file 3b72b7e

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
