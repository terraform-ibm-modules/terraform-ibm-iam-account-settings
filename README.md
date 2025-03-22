# IAM account settings module

[![Graduated (Supported)](https://img.shields.io/badge/Status-Graduated%20(Supported)-brightgreen)](https://terraform-ibm-modules.github.io/documentation/#/badge-status)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![latest release](https://img.shields.io/github/v/release/terraform-ibm-modules/terraform-ibm-iam-account-settings?logo=GitHub&sort=semver)](https://github.com/terraform-ibm-modules/terraform-ibm-iam-account-settings/releases/latest)
[![Renovate enabled](https://img.shields.io/badge/renovate-enabled-brightgreen.svg)](https://renovatebot.com/)

This module configures standard IAM account settings with the recommended values, in which the default values are
aligned with FSCloud requirements, and exports the values as outputs.

The module handles the following account settings:

- Multifactor authentication (None - Federated Users - All - Email/TOPT/U2F based)
- User specific Multifactor authentication (None - Federated Users - All - Email/TOPT/U2F based)
- Restrict API key creation (on - off)
- Restrict service ID creation (on - off)
- Session activity timeout (seconds)
- Session inactivity timeout (seconds)
- Access token expiration (seconds)
- Refresh token expiration (seconds)
- Restrict IP address access (off/Any Allowed - on/Allow only specified IP subnets or IP addresses). Two control modes
  are supported:
    - Monitor: traffic that originates outside the specified allowed IP addresses is allowed but logged by audit events
      that are sent to SIEM and Activity Tracker
    - Restrict: traffic that originates outside the specified allowed IP addresses is blocked
- Global shell settings (on - off)
- Public access group (on - off)

The module supports creating and updating settings that are applied with the `terraform apply` command. With objects
affected by the `destroy` command, the module preserves the most recent setting and doesn't change objects that are
configured outside of Terraform's scope.

## Current limitations:
The module currently does not support setting the following FSCloud requirements using the IBM provider:

- Check whether user list visibility restrictions are configured in IAM settings for the account owner
- Check whether the Financial Services Validated setting is enabled in account settings

Tracking issue with IBM provider -> <https://github.com/IBM-Cloud/terraform-provider-ibm/issues/4204>

If you need to manage these FSCloud requirements via Terraform, please see the [experimental submodule](https://github.com/terraform-ibm-modules/terraform-ibm-iam-account-settings/tree/main/modules/experimental) which uses the RestAPI provider to manage these settings.

<!-- Below content is automatically populated via pre-commit hook -->
<!-- BEGIN OVERVIEW HOOK -->
## Overview
* [terraform-ibm-iam-account-settings](#terraform-ibm-iam-account-settings)
* [Submodules](./modules)
    * [experimental](./modules/experimental)
* [Examples](./examples)
    * [Account Custom Settings example](./examples/custom)
    * [Default Example](./examples/default)
* [Contributing](#contributing)
<!-- END OVERVIEW HOOK -->

## terraform-ibm-iam-account-settings
### Usage

```hcl
module "iam_account_settings" {
  source               = "terraform-ibm-modules/iam-account-settings/ibm"
  version              = "X.X.X"  # Replace "X.X.X" with a release version to lock into a specific release
  allowed_ip_addresses = ["17.5.7.8.0/16"]

  # example usage of creating CBR zones within the module
  # see https://github.com/terraform-ibm-modules/terraform-ibm-cbr/tree/main/modules/cbr-zone-module for more details
  cbr_zones = [{
    name             = "default-zone-1"
    zone_description = "test zone in iam-account-settings module"
    addresses = [{
      type = "serviceRef"
      ref = {
        account_id   = data.ibm_iam_account_settings.iam_account_settings.account_id
        service_name = "secrets-manager"
      }
    }]
  }]
}
```
### User MFA

When specifying User MFA ([`user_mfa`](#input_user_mfa)), use the following format:

```
variable "user_mfa" {
  type = set(object({
    iam_id = string
    mfa = string
  }))
  default = [{

    iam_id = "IBMid-3x000xx3xH"
    mfa    = "LEVEL3"
  },
  {
    iam_id = "IBMid-50xG4CxSQx"
    mfa = "NONE"
  }]
  }

```
When/if it is necessary to delete/reset the MFA configuration for all users, use the [`user_mfa_reset`](#input_user_mfa_reset) input var.

### Required IAM access policies

You need the following permissions to run this module.

- Account Management
    - **IAM Access Groups** service
        - `Administrator` platform access
    - **IAM Access Management** service
        - `Editor` platform access
    - **IAM Identity** service
        - `Operator` platform access
    - **IBM Cloud Shell** service
        - `Administrator` platform access

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.65.0, < 2.0.0 |

### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cbr_zones"></a> [cbr\_zones](#module\_cbr\_zones) | terraform-ibm-modules/cbr/ibm//modules/cbr-zone-module | v1.29.0 |

### Resources

| Name | Type |
|------|------|
| [ibm_cloud_shell_account_settings.cloud_shell_account_settings](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cloud_shell_account_settings) | resource |
| [ibm_iam_access_group_account_settings.iam_access_group_account_settings](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/iam_access_group_account_settings) | resource |
| [ibm_iam_account_settings.iam_account_settings](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/iam_account_settings) | resource |
| [ibm_cloud_shell_account_settings.cloud_shell_account_settings](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/cloud_shell_account_settings) | data source |
| [ibm_iam_account_settings.iam_account_settings](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/iam_account_settings) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_token_expiration"></a> [access\_token\_expiration](#input\_access\_token\_expiration) | Defines the access token expiration in seconds | `string` | `"3600"` | no |
| <a name="input_active_session_timeout"></a> [active\_session\_timeout](#input\_active\_session\_timeout) | Specify how long (seconds) a user is allowed to work continuously in the account | `number` | `"86400"` | no |
| <a name="input_allowed_ip_addresses"></a> [allowed\_ip\_addresses](#input\_allowed\_ip\_addresses) | List of the IP addresses and subnets from which IAM tokens can be created for the account. | `list(any)` | `[]` | no |
| <a name="input_api_creation"></a> [api\_creation](#input\_api\_creation) | When restriction is enabled, only users, including the account owner, assigned the User API key creator role on the IAM Identity Service can create API keys. Allowed values are 'RESTRICTED', 'NOT\_RESTRICTED', or 'NOT\_SET' (to 'unset' a previous set value). | `string` | `"RESTRICTED"` | no |
| <a name="input_cbr_zones"></a> [cbr\_zones](#input\_cbr\_zones) | A list of CBR zones created by the module | <pre>list(object({<br/>    account_id = optional(string)<br/>    addresses = optional(list(object({<br/>      type  = optional(string)<br/>      value = optional(string)<br/>      ref = optional(object({<br/>        account_id       = string<br/>        location         = optional(string)<br/>        service_instance = optional(string)<br/>        service_name     = optional(string)<br/>        service_type     = optional(string)<br/>      }))<br/>    })), [])<br/>    excluded_addresses = optional(list(object({<br/>      type  = optional(string)<br/>      value = optional(string)<br/>    })), [])<br/>    name             = string<br/>    zone_description = optional(string, null)<br/>  }))</pre> | `[]` | no |
| <a name="input_enforce_allowed_ip_addresses"></a> [enforce\_allowed\_ip\_addresses](#input\_enforce\_allowed\_ip\_addresses) | If true IP address restriction will be enforced, If false, traffic originated outside specified allowed IP address set is monitored with audit events sent to SIEM and Activity Tracker. After running in monitored mode to test this variable, it should then explicitly be set to true to enforce IP allow listing. | `bool` | `true` | no |
| <a name="input_inactive_session_timeout"></a> [inactive\_session\_timeout](#input\_inactive\_session\_timeout) | Specify how long (seconds) a user is allowed to stay logged in the account while being inactive/idle | `string` | `"7200"` | no |
| <a name="input_max_sessions_per_identity"></a> [max\_sessions\_per\_identity](#input\_max\_sessions\_per\_identity) | Defines the maximum allowed sessions per identity required by the account. Supports any whole number greater than '0', or 'NOT\_SET' to unset account setting and use service default. | `string` | `"NOT_SET"` | no |
| <a name="input_mfa"></a> [mfa](#input\_mfa) | Specify Multi-Factor Authentication method in the account. Supported valid values are 'NONE' (No MFA trait set), 'TOTP' (For all non-federated IBMId users), 'TOTP4ALL' (For all users), 'LEVEL1' (Email based MFA for all users), 'LEVEL2' (TOTP based MFA for all users), 'LEVEL3' (U2F MFA for all users). | `string` | `"TOTP4ALL"` | no |
| <a name="input_public_access_enabled"></a> [public\_access\_enabled](#input\_public\_access\_enabled) | Enable/Disable public access group in which resources are open anyone regardless if they are member of your account or not | `bool` | `false` | no |
| <a name="input_refresh_token_expiration"></a> [refresh\_token\_expiration](#input\_refresh\_token\_expiration) | Defines the refresh token expiration in seconds | `string` | `"259200"` | no |
| <a name="input_serviceid_creation"></a> [serviceid\_creation](#input\_serviceid\_creation) | When restriction is enabled, only users, including the account owner, assigned the Service ID creator role on the IAM Identity Service can create service IDs. Allowed values are 'RESTRICTED', 'NOT\_RESTRICTED', or 'NOT\_SET' (to 'unset' a previous set value). | `string` | `"RESTRICTED"` | no |
| <a name="input_shell_settings_enabled"></a> [shell\_settings\_enabled](#input\_shell\_settings\_enabled) | Enable global shell settings to all users in the account. If `skip_cloud_shell_calls` is set to true, then this setting is ignored. | `bool` | `false` | no |
| <a name="input_skip_cloud_shell_calls"></a> [skip\_cloud\_shell\_calls](#input\_skip\_cloud\_shell\_calls) | Skip Cloud Shell calls in the account. | `bool` | `false` | no |
| <a name="input_user_mfa"></a> [user\_mfa](#input\_user\_mfa) | Specify Multi-Factor Authentication method for specific users the account. Supported valid values are 'NONE' (No MFA trait set), 'TOTP' (For all non-federated IBMId users), 'TOTP4ALL' (For all users), 'LEVEL1' (Email based MFA for all users), 'LEVEL2' (TOTP based MFA for all users), 'LEVEL3' (U2F MFA for all users). Example of format is available here > https://github.com/terraform-ibm-modules/terraform-ibm-iam-account-settings#usage | <pre>set(object({<br/>    iam_id = string<br/>    mfa    = string<br/>  }))</pre> | `[]` | no |
| <a name="input_user_mfa_reset"></a> [user\_mfa\_reset](#input\_user\_mfa\_reset) | Set to true to delete all user MFA settings configured in the targeted account, and ignoring entries declared in var `user_mfa` | `bool` | `false` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_account_allowed_ip_addresses"></a> [account\_allowed\_ip\_addresses](#output\_account\_allowed\_ip\_addresses) | Current allowed IP addresses |
| <a name="output_account_allowed_ip_addresses_control_mode"></a> [account\_allowed\_ip\_addresses\_control\_mode](#output\_account\_allowed\_ip\_addresses\_control\_mode) | Current allowed IP addresses enforcement control mode, will indicate RESTRICT if account\_allowed\_ip\_addresses\_enforced is TRUE |
| <a name="output_account_allowed_ip_addresses_enforced"></a> [account\_allowed\_ip\_addresses\_enforced](#output\_account\_allowed\_ip\_addresses\_enforced) | Current allowed IP addresses enforcement state |
| <a name="output_account_iam_access_token_expiration"></a> [account\_iam\_access\_token\_expiration](#output\_account\_iam\_access\_token\_expiration) | Current access token expiration |
| <a name="output_account_iam_active_session_timeout"></a> [account\_iam\_active\_session\_timeout](#output\_account\_iam\_active\_session\_timeout) | Current active session timeout |
| <a name="output_account_iam_apikey_creation"></a> [account\_iam\_apikey\_creation](#output\_account\_iam\_apikey\_creation) | Current state of API key creation restriction |
| <a name="output_account_iam_inactive_session_timeout"></a> [account\_iam\_inactive\_session\_timeout](#output\_account\_iam\_inactive\_session\_timeout) | Current inactive session timeout |
| <a name="output_account_iam_mfa"></a> [account\_iam\_mfa](#output\_account\_iam\_mfa) | Current MFA setting |
| <a name="output_account_iam_refresh_token_expiration"></a> [account\_iam\_refresh\_token\_expiration](#output\_account\_iam\_refresh\_token\_expiration) | Current refresh token expiration |
| <a name="output_account_iam_serviceid_creation"></a> [account\_iam\_serviceid\_creation](#output\_account\_iam\_serviceid\_creation) | Current state of ServiceID creation restriction |
| <a name="output_account_iam_user_mfa_list"></a> [account\_iam\_user\_mfa\_list](#output\_account\_iam\_user\_mfa\_list) | Current list of users with specific MFA settings |
| <a name="output_account_public_access"></a> [account\_public\_access](#output\_account\_public\_access) | Current state of public access group setting |
| <a name="output_account_shell_settings_status"></a> [account\_shell\_settings\_status](#output\_account\_shell\_settings\_status) | Current state of global shell setting |
| <a name="output_account_zones"></a> [account\_zones](#output\_account\_zones) | Current CBR zones managed by the module |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- Leave this section as is so that your module has a link to local development environment set up steps for contributors to follow -->
## Contributing

You can report issues and request features for this module in GitHub issues in the module repo. See [Report an issue or request a feature](https://github.com/terraform-ibm-modules/.github/blob/main/.github/SUPPORT.md).

To set up your local development environment, see [Local development setup](https://terraform-ibm-modules.github.io/documentation/#/local-dev-setup) in the project documentation.
