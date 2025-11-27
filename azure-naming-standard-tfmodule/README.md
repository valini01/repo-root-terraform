<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_id"></a> [application\_id](#input\_application\_id) | (Optional) Application ID of the deployment | `string` | `""` | no |
| <a name="input_context"></a> [context](#input\_context) | (Optional) Context identifier of which resources are being deployed | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Required) Environment for the deployment | `string` | `""` | no |
| <a name="input_er_provider"></a> [er\_provider](#input\_er\_provider) | (Optional) Provider for Express Route | `string` | `""` | no |
| <a name="input_hub"></a> [hub](#input\_hub) | Resource being deployed in hub | `string` | `""` | no |
| <a name="input_inc"></a> [inc](#input\_inc) | n/a | `string` | `""` | no |
| <a name="input_local_market_shortcut"></a> [local\_market\_shortcut](#input\_local\_market\_shortcut) | (Required) Abbreviated form of the local market, used for naming convention. | `string` | `""` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Location for the deployment | `string` | n/a | yes |
| <a name="input_location-map"></a> [location-map](#input\_location-map) | Azure location map used for naming abbreviations | `map(any)` | <pre>{<br>  "Australia Central": "cau",<br>  "Australia Central 2": "cau2",<br>  "Australia East": "eau",<br>  "Australia Southeast": "seau",<br>  "Brazil South": "sbr",<br>  "Canada Central": "cac",<br>  "Canada East": "eca",<br>  "Central India": "cin",<br>  "Central US": "cus",<br>  "East Asia": "eaa",<br>  "East US": "eus",<br>  "East US 2": "eus2",<br>  "France Central": "cfr",<br>  "France South": "sfr",<br>  "Germany North": "nge",<br>  "Germany West Central": "gwc",<br>  "Italy North": "itn",<br>  "italynorth": "itn",<br>  "Japan East": "eja",<br>  "Japan West": "wja",<br>  "Korea Central": "cko",<br>  "Korea South": "sko",<br>  "North Central US": "ncus",<br>  "North Europe": "neu",<br>  "South Africa North": "nsa",<br>  "South Africa West": "wsa",<br>  "South Central US": "scus",<br>  "South India": "sin",<br>  "Southeast Asia": "sea",<br>  "UAE Central": "cua",<br>  "UAE North": "nua",<br>  "UK South": "uks",<br>  "UK West": "ukw",<br>  "West Central US": "wcus",<br>  "West Europe": "euw",<br>  "West India": "win",<br>  "West US": "wus",<br>  "West US 2": "wus2",<br>  "australiacentral": "cau",<br>  "australiacentral2": "cau2",<br>  "australiaeast": "eau",<br>  "australiasoutheast": "seau",<br>  "brazilsouth": "sbr",<br>  "canadacentral": "cac",<br>  "canadaeast": "eca",<br>  "centralindia": "cin",<br>  "centralus": "cus",<br>  "eastasia": "eaa",<br>  "eastus": "eus",<br>  "eastus2": "eus2",<br>  "francecentral": "cfr",<br>  "francesouth": "sfr",<br>  "germanynorth": "nge",<br>  "germanywestcentral": "gwc",<br>  "japaneast": "eja",<br>  "japanwest": "wja",<br>  "koreacentral": "cko",<br>  "koreasouth": "sko",<br>  "northcentralus": "ncus",<br>  "northeurope": "neu",<br>  "southafricanorth": "nsa",<br>  "southafricawest": "wsa",<br>  "southcentralus": "scus",<br>  "southeastasia": "sea",<br>  "southindia": "si",<br>  "uaecentral": "cua",<br>  "uaenorth": "nua",<br>  "uksouth": "uks",<br>  "ukwest": "ukw",<br>  "westcentralus": "wcus",<br>  "westeurope": "euw",<br>  "westindia": "win",<br>  "westus": "wus",<br>  "westus2": "wus2"<br>}</pre> | no |
| <a name="input_md5_identifier"></a> [md5\_identifier](#input\_md5\_identifier) | (Optional) md5\_identifier to generate unique md5 hash value for a subscription. | `string` | `""` | no |
| <a name="input_pip_suffix"></a> [pip\_suffix](#input\_pip\_suffix) | (Optional) Provider for Public Ip Address | `string` | `""` | no |
| <a name="input_resource"></a> [resource](#input\_resource) | (Optional) Resource identifier for networking resources | `string` | `""` | no |
| <a name="input_routing_domain"></a> [routing\_domain](#input\_routing\_domain) | Identifier for a logical grouping of network routes, used to define routing policies within the Hub | `string` | n/a | yes |
| <a name="input_security_zone"></a> [security\_zone](#input\_security\_zone) | (Optional) security zone ID for NSG | `string` | `""` | no |
| <a name="input_sub"></a> [sub](#input\_sub) | (Optional) Subscription identifier where the resources are being deployed | `string` | `""` | no |
| <a name="input_subnet_cidr"></a> [subnet\_cidr](#input\_subnet\_cidr) | (Optional) Subscription identifier where the resources are being deployed | `string` | `""` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | (Optional) Subscription id where the resources are being deployed | `string` | `""` | no |
| <a name="input_vnet_name_suffix"></a> [vnet\_name\_suffix](#input\_vnet\_name\_suffix) | (Optional) Suffix to construct Vnet name other then hub vnet | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_standard"></a> [standard](#output\_standard) | Return list of calculated standard names for deployment of Azure resources |
<!-- END_TF_DOCS -->