# IAM account settings module

<!-- BADGE UPDATES:
1. Update first badge below to the current status of the module. See options at
    https://github.com/terraform-ibm-modules/documentation/blob/main/docs/badge-status.md
2. Update the build status badge to point to the travis pipeline for the module
    TIP: Simply replace the string "module-template" in the 2 places in the Build Status section below
-->
[![Stable (With quality checks)](https://img.shields.io/badge/Status-Stable%20(With%20quality%20checks)-green?style=plastic)](https://terraform-ibm-modules.github.io/documentation/#/badge-status)
[![Build Status](https://github.com/terraform-ibm-modules/terraform-ibm-cos/actions/workflows/ci.yml/badge.svg)](https://github.com/terraform-ibm-modules/terraform-ibm-cos/actions/workflows/ci.yml)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![latest release](https://img.shields.io/github/v/release/terraform-ibm-modules/terraform-ibm-cos?logo=GitHub&sort=semver)](https://github.com/terraform-ibm-modules/terraform-ibm-iam-account-settings/releases/latest)
[![Renovate enabled](https://img.shields.io/badge/renovate-enabled-brightgreen.svg)](https://renovatebot.com/)

This module configures standard IAM account settings with the recommended values, in which the default values are 
aligned with FSCloud requirements, and exports the values as outputs.

The module handles the following account settings:

- Multifactor authentication (None - Federated Users - All - Email/TOPT/U2F based)
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

Because the IBM provider does not handle the account settings, this module uses the
generic [REST API provider](https://github.com/Mastercard/terraform-provider-restapi). A feature request is tracked in
the
issue [Support to disable/enable public access account setting](https://github.com/IBM-Cloud/terraform-provider-ibm/issues/3285).

## Usage

:exclamation: **Important:** Make sure that you set the `API_DATA_IS_SENSITIVE` environment variable to `true` to hide
sensitive information before you run Terraform operations. For more information, see the generic REST API
provider [documentation](https://github.com/Mastercard/terraform-provider-restapi#usage):

```sh
export API_DATA_IS_SENSITIVE=true`
```

```hcl
##############################################################################
# Config providers
##############################################################################

data "ibm_iam_auth_token" "tokendata" {}

provider "restapi" {
  uri                  = "https:"
  write_returns_object = true
  debug                = false # set to true to show detailed logs, but use carefully as it might print API key values.
  headers              = {
    Authorization = data.ibm_iam_auth_token.tokendata.iam_access_token
    Content-Type  = "application/json"
    if-Match      = "*"
  }
}

provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key # pragma: allowlist secret
}

##############################################################################
# Configure IAM Account settings
##############################################################################

# Replace "master" with a GIT release version to lock into a specific release
module "iam-account-settings" {
  source                       = "git::https://github.com/terraform-ibm-modules/terraform-ibm-iam-account-settings?ref=main"
  allowed_ip_addresses         = var.allowed_ip_addresses
  enforce_allowed_ip_addresses = true
}
```

## Compliance and security

This module contributes to the implementation of the following NIST controls for the network layer on an IBM Cloud
account.

| Account Setting                                        | NIST Family | NIST Control | Description                                                                                                                                                                                                                                   |
|--------------------------------------------------------|-------------|--------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Force sign out due to inactivity                       | AC          | AC-2(5)      | Require that users log out when an organization-defined time period of expected inactivity is reached.                                                                                                                                        |
| Restrict API key/Service ID creation                   | AC          | AC-6(1)      | Authorize access for organization-defined individuals or roles to access security functions and security-relevant information. These include user lists, API keys, service IDs, and resources.                                                |
| Set active session time and sign out due to inactivity | AC          | AC-12        | Implemented automatic termination of a users session after organization-defined session expiration and session invalidation times.                                                                                                            |
| Restrict IP address access                             | AU          | AU-12(3)     | Provide and implement the capability for organization-defined individuals or roles to change the logging to be performed on traffic that originates outside specified allowed IP addresses based on Restrict IP address access control modes. |
| Set MFA for users with an IBMid                        | IA          | IA-2(1)      | Implemented multi-factor authentication for access to privileged accounts.                                                                                                                                                                    |
| Set MFA for all users                                  | IA          | IA-2(2)      | Implemented multi-factor authentication for access to nonprivileged accounts.                                                                                                                                                                 |
| Restrict IP address access                             | SC          | SC-7(3)      | Limit the number of external network connections to the system. This includes the Restrict IP address access control modes.                                                                                                                   |
| Force sign out due to inactivity                       | SC          | SC-10        | Terminate the network connection that is associated with a communications session at the end of the session or after organization-defined period of inactivity.                                                                               |
| Restrict IP address access/Set MFA                     | SI          | SI-4         | Monitor the system to detect unauthorized local, network, and remote connections.                                                                                                                                                             |

## Required IAM access policies

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

<!-- BEGIN EXAMPLES HOOK -->
## Examples

- [ Account Custom Settings example](examples/custom)
- [ Default Example](examples/default)
<!-- END EXAMPLES HOOK -->

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.49.0 |
| <a name="requirement_restapi"></a> [restapi](#requirement\_restapi) | >= 1.18.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [ibm_cloud_shell_account_settings.cloud_shell_account_settings](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cloud_shell_account_settings) | resource |
| [ibm_iam_account_settings.iam_account_settings](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/iam_account_settings) | resource |
| [restapi_object.account_public_access](https://registry.terraform.io/providers/Mastercard/restapi/latest/docs/resources/object) | resource |
| [ibm_cloud_shell_account_settings.cloud_shell_account_settings](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/cloud_shell_account_settings) | data source |
| [ibm_iam_account_settings.iam_account_settings](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/iam_account_settings) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_token_expiration"></a> [access\_token\_expiration](#input\_access\_token\_expiration) | Defines the access token expiration in seconds | `string` | `"3600"` | no |
| <a name="input_active_session_timeout"></a> [active\_session\_timeout](#input\_active\_session\_timeout) | Specify how long (seconds) a user is allowed to work continuosly in the account | `string` | `"3600"` | no |
| <a name="input_allowed_ip_addresses_cloudshell"></a> [allowed\_ip\_addresses\_cloudshell](#input\_allowed\_ip\_addresses\_cloudshell) | CloudShell IP addresses/ranges in list | `list(any)` | `[]` | no |
| <a name="input_allowed_ip_addresses_continuous_delivery"></a> [allowed\_ip\_addresses\_continuous\_delivery](#input\_allowed\_ip\_addresses\_continuous\_delivery) | Continuous Delivery IP addresses/ranges in list | `list(any)` | `[]` | no |
| <a name="input_allowed_ip_addresses_iks_accesshub"></a> [allowed\_ip\_addresses\_iks\_accesshub](#input\_allowed\_ip\_addresses\_iks\_accesshub) | AccessHub IP addresses/ranges in list | `list(any)` | `[]` | no |
| <a name="input_allowed_ip_addresses_iks_activity_tracker_ldna"></a> [allowed\_ip\_addresses\_iks\_activity\_tracker\_ldna](#input\_allowed\_ip\_addresses\_iks\_activity\_tracker\_ldna) | Activity Tracker (LogDNA) IP addresses/ranges in list | `list(any)` | `[]` | no |
| <a name="input_allowed_ip_addresses_iks_container_registry"></a> [allowed\_ip\_addresses\_iks\_container\_registry](#input\_allowed\_ip\_addresses\_iks\_container\_registry) | Container Registry IP addresses/ranges in list | `list(any)` | `[]` | no |
| <a name="input_allowed_ip_addresses_iks_control_plane_fw"></a> [allowed\_ip\_addresses\_iks\_control\_plane\_fw](#input\_allowed\_ip\_addresses\_iks\_control\_plane\_fw) | IKS' Control Plane IP addresses/ranges in list | `list(any)` | `[]` | no |
| <a name="input_allowed_ip_addresses_iks_sysdig_monitoring"></a> [allowed\_ip\_addresses\_iks\_sysdig\_monitoring](#input\_allowed\_ip\_addresses\_iks\_sysdig\_monitoring) | Cloud Monitoring (Sysdig) IP addresses/ranges in list | `list(any)` | `[]` | no |
| <a name="input_allowed_ip_addresses_taas_jenkins_tekton"></a> [allowed\_ip\_addresses\_taas\_jenkins\_tekton](#input\_allowed\_ip\_addresses\_taas\_jenkins\_tekton) | Jenkins/Tekton IP addresses/ranges in list | `list(any)` | `[]` | no |
| <a name="input_allowed_ip_addresses_travis"></a> [allowed\_ip\_addresses\_travis](#input\_allowed\_ip\_addresses\_travis) | Travis IP addresses/ranges in list | `list(any)` | `[]` | no |
| <a name="input_allowed_ip_schematics_eu_central"></a> [allowed\_ip\_schematics\_eu\_central](#input\_allowed\_ip\_schematics\_eu\_central) | Schematics EU IP addresses/ranges in list | `list(any)` | `[]` | no |
| <a name="input_allowed_ip_schematics_uk_south"></a> [allowed\_ip\_schematics\_uk\_south](#input\_allowed\_ip\_schematics\_uk\_south) | Schematics UK South IP addresses/ranges in list | `list(any)` | `[]` | no |
| <a name="input_allowed_ip_schematics_us"></a> [allowed\_ip\_schematics\_us](#input\_allowed\_ip\_schematics\_us) | Schematics US IP addresses/ranges in list | `list(any)` | `[]` | no |
| <a name="input_api_creation"></a> [api\_creation](#input\_api\_creation) | When restriction is enabled, users in your account require specific access to create API keys, including the account owner | `string` | `"RESTRICTED"` | no |
| <a name="input_custom_allowed_ip_addresses"></a> [custom\_allowed\_ip\_addresses](#input\_custom\_allowed\_ip\_addresses) | Specify a custom list of IPv4/IPv6 addresses/subnets that have access to the account, separate multiple values with a comma | `string` | `""` | no |
| <a name="input_enforce_allowed_ip_addresses"></a> [enforce\_allowed\_ip\_addresses](#input\_enforce\_allowed\_ip\_addresses) | If true IP address restriction will be enforced, If false, traffic originated outside specified allowed IP address set is monitored with audit events sent to SIEM and Activity Tracker.   After running in monitored mode to test this variable should explicity be set to true to enfoce IP allow listing | `bool` | `true` | no |
| <a name="input_ignore_ibm_approved_ip_addresses"></a> [ignore\_ibm\_approved\_ip\_addresses](#input\_ignore\_ibm\_approved\_ip\_addresses) | If true IP address control will only be evaluate custom\_allowed\_ip\_addresses, If false, restricion will be consider both IBM approved IP sets and custom\_allowed\_ip\_addresses (if configured) | `bool` | `false` | no |
| <a name="input_inactive_session_timeout"></a> [inactive\_session\_timeout](#input\_inactive\_session\_timeout) | Specify how long (seconds) a user is allowed to stay logged in the account while being inactive/idle | `string` | `"900"` | no |
| <a name="input_mfa"></a> [mfa](#input\_mfa) | Specify Multi-Factor Authentication method in the account | `string` | `"TOTP4ALL"` | no |
| <a name="input_public_access_enabled"></a> [public\_access\_enabled](#input\_public\_access\_enabled) | Enable/Disable public access group in which resources are open anyone regardless if they are member of your account or not | `bool` | `false` | no |
| <a name="input_refresh_token_expiration"></a> [refresh\_token\_expiration](#input\_refresh\_token\_expiration) | Defines the refresh token expiration in seconds | `string` | `"259200"` | no |
| <a name="input_serviceid_creation"></a> [serviceid\_creation](#input\_serviceid\_creation) | When restriction is enabled, users in your account require specific access to create service IDs, including the account owner | `string` | `"RESTRICTED"` | no |
| <a name="input_shell_settings_enabled"></a> [shell\_settings\_enabled](#input\_shell\_settings\_enabled) | Enable global shell settings to all users in the account | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_account_allowed_ip_addresses"></a> [account\_allowed\_ip\_addresses](#output\_account\_allowed\_ip\_addresses) | Current allowed IP addresses |
| <a name="output_account_allowed_ip_addresses_control_mode"></a> [account\_allowed\_ip\_addresses\_control\_mode](#output\_account\_allowed\_ip\_addresses\_control\_mode) | Current allowed IP addresses enforcement control mode, will indicate RESTRICT if account\_allowed\_ip\_addresses\_enforced is TRUE |
| <a name="output_account_allowed_ip_addresses_enforced"></a> [account\_allowed\_ip\_addresses\_enforced](#output\_account\_allowed\_ip\_addresses\_enforced) | Current allowed IP addresses enforcement state |
| <a name="output_account_approved_ibm_ip_addresses_ignored"></a> [account\_approved\_ibm\_ip\_addresses\_ignored](#output\_account\_approved\_ibm\_ip\_addresses\_ignored) | Ignore state of IBM approved IP addresses |
| <a name="output_account_iam_access_token_expiration"></a> [account\_iam\_access\_token\_expiration](#output\_account\_iam\_access\_token\_expiration) | Current access token expiration |
| <a name="output_account_iam_active_session_timeout"></a> [account\_iam\_active\_session\_timeout](#output\_account\_iam\_active\_session\_timeout) | Current active session timeout |
| <a name="output_account_iam_apikey_creation"></a> [account\_iam\_apikey\_creation](#output\_account\_iam\_apikey\_creation) | Current state of API key creation restriction |
| <a name="output_account_iam_inactive_session_timeout"></a> [account\_iam\_inactive\_session\_timeout](#output\_account\_iam\_inactive\_session\_timeout) | Current inactive session timeout |
| <a name="output_account_iam_mfa"></a> [account\_iam\_mfa](#output\_account\_iam\_mfa) | Current MFA setting |
| <a name="output_account_iam_refresh_token_expiration"></a> [account\_iam\_refresh\_token\_expiration](#output\_account\_iam\_refresh\_token\_expiration) | Current refresh token expiration |
| <a name="output_account_iam_serviceid_creation"></a> [account\_iam\_serviceid\_creation](#output\_account\_iam\_serviceid\_creation) | Current state of ServiceID creation restriction |
| <a name="output_account_public_access"></a> [account\_public\_access](#output\_account\_public\_access) | Current state of public access group setting |
| <a name="output_account_shell_settings_status"></a> [account\_shell\_settings\_status](#output\_account\_shell\_settings\_status) | Current state of global shell setting |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- BEGIN CONTRIBUTING HOOK -->

## Contributing

You can report issues and request features for this module in the
GoldenEye [issues](https://github.com/terraform-ibm-modules/terraform-ibm-issue-tracker/issues)
repo.See [Report a Bug or Create Enhancement Request](https://github.com/terraform-ibm-modules/documentation/blob/main/docs/issues.md).

To set up your local development environment,
see [Local development setup](https://github.com/terraform-ibm-modules/documentation/blob/main/docs/local-dev-setup.md)
in the project documentation.
<!-- Source for this readme file: https://github.com/terraform-ibm-modules/common-dev-assets/tree/main/module-assets/ci/module-template-automation -->
<!-- END CONTRIBUTING HOOK -->
