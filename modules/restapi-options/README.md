# IAM Account Settings with RestAPI provider module

## Account Settings Support

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
- Financial Services Validated products (on - off)
- User List Visibility restrictions (on - off)

The module supports creating and updating settings that are applied with the `terraform apply` command. With objects
affected by the `destroy` command, the module preserves the most recent setting and doesn't change objects that are
configured outside of Terraform's scope.

### Current Limitations

The module currently supports setting the following FSCloud requirements using the RestAPI provider until the IBM provider supports these settings:

- Check whether user list visibility restrictions are configured in IAM settings for the account owner
- Check whether the Financial Services Validated setting is enabled in account settings

Tracking issue with IBM provider -> <https://github.com/IBM-Cloud/terraform-provider-ibm/issues/4204>

For further usage information on the module, please see the [base module readme](../../README.md#usage).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0, <1.6.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.49.0 |
| <a name="requirement_restapi"></a> [restapi](#requirement\_restapi) | >= 1.18.2 |

### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iam_account_settings"></a> [iam\_account\_settings](#module\_iam\_account\_settings) | ../.. | n/a |

### Resources

| Name | Type |
|------|------|
| [restapi_object.fs_validated](https://registry.terraform.io/providers/Mastercard/restapi/latest/docs/resources/object) | resource |
| [restapi_object.user_list_visibility](https://registry.terraform.io/providers/Mastercard/restapi/latest/docs/resources/object) | resource |
| [ibm_iam_account_settings.iam_account_settings](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/iam_account_settings) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_token_expiration"></a> [access\_token\_expiration](#input\_access\_token\_expiration) | Defines the access token expiration in seconds | `string` | `"3600"` | no |
| <a name="input_active_session_timeout"></a> [active\_session\_timeout](#input\_active\_session\_timeout) | Specify how long (seconds) a user is allowed to work continuously in the account | `number` | `"3600"` | no |
| <a name="input_allowed_ip_addresses"></a> [allowed\_ip\_addresses](#input\_allowed\_ip\_addresses) | List of the IP addresses and subnets from which IAM tokens can be created for the account. | `list(any)` | `[]` | no |
| <a name="input_api_creation"></a> [api\_creation](#input\_api\_creation) | When restriction is enabled, only users, including the account owner, assigned the User API key creator role on the IAM Identity Service can create API keys. Allowed values are 'RESTRICTED', 'NOT\_RESTRICTED', or 'NOT\_SET' (to 'unset' a previous set value). | `string` | `"RESTRICTED"` | no |
| <a name="input_api_endpoint"></a> [api\_endpoint](#input\_api\_endpoint) | Endpoint to use for API calls for `var.fs_validated` and `var.user_list_visibility` | `string` | `"accounts.cloud.ibm.com"` | no |
| <a name="input_enforce_allowed_ip_addresses"></a> [enforce\_allowed\_ip\_addresses](#input\_enforce\_allowed\_ip\_addresses) | If true IP address restriction will be enforced, If false, traffic originated outside specified allowed IP address set is monitored with audit events sent to SIEM and Activity Tracker. After running in monitored mode to test this variable, it should then explicitly be set to true to enforce IP allow listing. | `bool` | `true` | no |
| <a name="input_fs_validated"></a> [fs\_validated](#input\_fs\_validated) | Enable use of financial services validated products in the account | `bool` | `true` | no |
| <a name="input_inactive_session_timeout"></a> [inactive\_session\_timeout](#input\_inactive\_session\_timeout) | Specify how long (seconds) a user is allowed to stay logged in the account while being inactive/idle | `string` | `"900"` | no |
| <a name="input_max_sessions_per_identity"></a> [max\_sessions\_per\_identity](#input\_max\_sessions\_per\_identity) | Defines the maximum allowed sessions per identity required by the account. Supports any whole number greater than '0', or 'NOT\_SET' to unset account setting and use service default. | `string` | `"NOT_SET"` | no |
| <a name="input_mfa"></a> [mfa](#input\_mfa) | Specify Multi-Factor Authentication method in the account. Supported valid values are 'NONE' (No MFA trait set), 'TOTP' (For all non-federated IBMId users), 'TOTP4ALL' (For all users), 'LEVEL1' (Email based MFA for all users), 'LEVEL2' (TOTP based MFA for all users), 'LEVEL3' (U2F MFA for all users). | `string` | `"TOTP4ALL"` | no |
| <a name="input_public_access_enabled"></a> [public\_access\_enabled](#input\_public\_access\_enabled) | Enable/Disable public access group in which resources are open anyone regardless if they are member of your account or not | `bool` | `false` | no |
| <a name="input_refresh_token_expiration"></a> [refresh\_token\_expiration](#input\_refresh\_token\_expiration) | Defines the refresh token expiration in seconds | `string` | `"259200"` | no |
| <a name="input_serviceid_creation"></a> [serviceid\_creation](#input\_serviceid\_creation) | When restriction is enabled, only users, including the account owner, assigned the Service ID creator role on the IAM Identity Service can create service IDs. Allowed values are 'RESTRICTED', 'NOT\_RESTRICTED', or 'NOT\_SET' (to 'unset' a previous set value). | `string` | `"RESTRICTED"` | no |
| <a name="input_shell_settings_enabled"></a> [shell\_settings\_enabled](#input\_shell\_settings\_enabled) | Enable global shell settings to all users in the account | `bool` | `false` | no |
| <a name="input_user_list_visibility"></a> [user\_list\_visibility](#input\_user\_list\_visibility) | Enable restriction of user list visibility in the account | `bool` | `true` | no |
| <a name="input_user_mfa"></a> [user\_mfa](#input\_user\_mfa) | Specify Multi-Factor Authentication method for specific users the account. Supported valid values are 'NONE' (No MFA trait set), 'TOTP' (For all non-federated IBMId users), 'TOTP4ALL' (For all users), 'LEVEL1' (Email based MFA for all users), 'LEVEL2' (TOTP based MFA for all users), 'LEVEL3' (U2F MFA for all users). Example of format is available here > https://github.com/terraform-ibm-modules/terraform-ibm-iam-account-settings#usage | <pre>set(object({<br>    iam_id = string<br>    mfa    = string<br>  }))</pre> | `[]` | no |
| <a name="input_user_mfa_reset"></a> [user\_mfa\_reset](#input\_user\_mfa\_reset) | Set to true to delete all user MFA settings configured in the targeted account, and ignoring entries declared in var `user_mfa` | `bool` | `false` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_account_allowed_ip_addresses"></a> [account\_allowed\_ip\_addresses](#output\_account\_allowed\_ip\_addresses) | Current allowed IP addresses |
| <a name="output_account_allowed_ip_addresses_control_mode"></a> [account\_allowed\_ip\_addresses\_control\_mode](#output\_account\_allowed\_ip\_addresses\_control\_mode) | Current allowed IP addresses enforcement control mode, will indicate RESTRICT if account\_allowed\_ip\_addresses\_enforced is TRUE |
| <a name="output_account_allowed_ip_addresses_enforced"></a> [account\_allowed\_ip\_addresses\_enforced](#output\_account\_allowed\_ip\_addresses\_enforced) | Current allowed IP addresses enforcement state |
| <a name="output_account_fs_validated"></a> [account\_fs\_validated](#output\_account\_fs\_validated) | Current Financial Services validated setting |
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
| <a name="output_account_user_list_visibility"></a> [account\_user\_list\_visibility](#output\_account\_user\_list\_visibility) | Current User List visibility restriction setting |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
