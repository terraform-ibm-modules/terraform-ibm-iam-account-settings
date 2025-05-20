# Account Settings Template Submodule for IBM Cloud IAM

This Terraform submodule provisions an Account Settings Template in IBM Cloud IAM. The template can be applied across all accounts in an enterprise, simplifying Account setup at scale.

## Usage

```hcl
module "account_settings_template" {
  source  = "terraform-ibm-modules/account-settings/ibm//modules/account-settings-template"
  version = "X.Y.Z" # Replace "X.Y.Z" with a release version to lock into a specific release

  template_name          = "Account Settings Template example"
  template_description   = "IAM account settings template example"

  allowed_ip_addresses = ["17.5.7.8.0/16"]
}
```

### Required IAM access policies

You need the following permissions to run this module.

- Service
  - **Enterprise** service
    - `Viewer` platform access
  - **IAM Identity** service
    - `Template Administrator` platform access
    - `Template Assignment Administrator` platform access

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.76.1, < 2.0.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [ibm_iam_account_settings_template.account_settings_template_instance](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/iam_account_settings_template) | resource |
| [ibm_iam_account_settings_template_assignment.account_settings_template_assignment_instance](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/iam_account_settings_template_assignment) | resource |
| [ibm_enterprise_account_groups.all_groups](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/enterprise_account_groups) | data source |
| [ibm_enterprise_accounts.all_accounts](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/enterprise_accounts) | data source |
| [ibm_iam_account_settings.iam_account_settings](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/iam_account_settings) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_token_expiration"></a> [access\_token\_expiration](#input\_access\_token\_expiration) | Defines the access token expiration in seconds | `string` | `"3600"` | no |
| <a name="input_account_group_ids_to_assign"></a> [account\_group\_ids\_to\_assign](#input\_account\_group\_ids\_to\_assign) | A list of account group IDs to assign the template to. Support passing the string 'all' in the list to assign to all account groups. | `list(string)` | <pre>[<br/>  "all"<br/>]</pre> | no |
| <a name="input_account_ids_to_assign"></a> [account\_ids\_to\_assign](#input\_account\_ids\_to\_assign) | A list of account IDs to assign the template to. Support passing the string 'all' in the list to assign to all accounts. | `list(string)` | `[]` | no |
| <a name="input_active_session_timeout"></a> [active\_session\_timeout](#input\_active\_session\_timeout) | Specify how long (seconds) a user is allowed to work continuously in the account | `number` | `"86400"` | no |
| <a name="input_allowed_ip_addresses"></a> [allowed\_ip\_addresses](#input\_allowed\_ip\_addresses) | List of the IP addresses and subnets from which IAM tokens can be created for the account. | `list(any)` | `[]` | no |
| <a name="input_api_creation"></a> [api\_creation](#input\_api\_creation) | When restriction is enabled, only users, including the account owner, assigned the User API key creator role on the IAM Identity Service can create API keys. Allowed values are 'RESTRICTED', 'NOT\_RESTRICTED', or 'NOT\_SET' (to 'unset' a previous set value). | `string` | `"RESTRICTED"` | no |
| <a name="input_enforce_allowed_ip_addresses"></a> [enforce\_allowed\_ip\_addresses](#input\_enforce\_allowed\_ip\_addresses) | If true IP address restriction will be enforced, If false, traffic originated outside specified allowed IP address set is monitored with audit events sent to SIEM and Activity Tracker. After running in monitored mode to test this variable, it should then explicitly be set to true to enforce IP allow listing. | `bool` | `true` | no |
| <a name="input_inactive_session_timeout"></a> [inactive\_session\_timeout](#input\_inactive\_session\_timeout) | Specify how long (seconds) a user is allowed to stay logged in the account while being inactive/idle | `string` | `"7200"` | no |
| <a name="input_max_sessions_per_identity"></a> [max\_sessions\_per\_identity](#input\_max\_sessions\_per\_identity) | Defines the maximum allowed sessions per identity required by the account. Supports any whole number greater than '0', or 'NOT\_SET' to unset account setting and use service default. | `string` | `"NOT_SET"` | no |
| <a name="input_mfa"></a> [mfa](#input\_mfa) | Specify Multi-Factor Authentication method in the account. Supported valid values are 'NONE' (No MFA trait set), 'TOTP' (For all non-federated IBMId users), 'TOTP4ALL' (For all users), 'LEVEL1' (Email based MFA for all users), 'LEVEL2' (TOTP based MFA for all users), 'LEVEL3' (U2F MFA for all users). | `string` | `"TOTP4ALL"` | no |
| <a name="input_refresh_token_expiration"></a> [refresh\_token\_expiration](#input\_refresh\_token\_expiration) | Defines the refresh token expiration in seconds | `string` | `"259200"` | no |
| <a name="input_serviceid_creation"></a> [serviceid\_creation](#input\_serviceid\_creation) | When restriction is enabled, only users, including the account owner, assigned the Service ID creator role on the IAM Identity Service can create service IDs. Allowed values are 'RESTRICTED', 'NOT\_RESTRICTED', or 'NOT\_SET' (to 'unset' a previous set value). | `string` | `"RESTRICTED"` | no |
| <a name="input_template_description"></a> [template\_description](#input\_template\_description) | Description of the account settings template | `string` | `null` | no |
| <a name="input_template_name"></a> [template\_name](#input\_template\_name) | Name of the account settings template | `string` | n/a | yes |
| <a name="input_user_mfa"></a> [user\_mfa](#input\_user\_mfa) | Specify Multi-Factor Authentication method for specific users the account. Supported valid values are 'NONE' (No MFA trait set), 'TOTP' (For all non-federated IBMId users), 'TOTP4ALL' (For all users), 'LEVEL1' (Email based MFA for all users), 'LEVEL2' (TOTP based MFA for all users), 'LEVEL3' (U2F MFA for all users). Example of format is available here > https://github.com/terraform-ibm-modules/terraform-ibm-iam-account-settings#usage | <pre>set(object({<br/>    iam_id = string<br/>    mfa    = string<br/>  }))</pre> | `[]` | no |
| <a name="input_user_mfa_reset"></a> [user\_mfa\_reset](#input\_user\_mfa\_reset) | Set to true to delete all user MFA settings configured in the targeted account, and ignoring entries declared in var `user_mfa` | `bool` | `false` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_account_settings_template_assignment_ids"></a> [account\_settings\_template\_assignment\_ids](#output\_account\_settings\_template\_assignment\_ids) | List of assignment IDs to child accounts |
| <a name="output_account_settings_template_id"></a> [account\_settings\_template\_id](#output\_account\_settings\_template\_id) | The ID of the account settings template |
| <a name="output_account_settings_template_id_raw"></a> [account\_settings\_template\_id\_raw](#output\_account\_settings\_template\_id\_raw) | Full raw ID (including version) of the account settings template |
| <a name="output_account_settings_template_version"></a> [account\_settings\_template\_version](#output\_account\_settings\_template\_version) | The version of the account settings Template |
| <a name="output_enterprise_account_ids"></a> [enterprise\_account\_ids](#output\_enterprise\_account\_ids) | List of child enterprise account IDs |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
