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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.76.1, < 2.0.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [ibm_iam_account_settings_template.account_Settings_template_instance](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/iam_account_settings_template) | resource |
| [ibm_iam_account_settings_template_assignment.account_settings_template_assignment_instance](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/iam_account_settings_template_assignment) | resource |
| [ibm_enterprise_account_groups.all_groups](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/enterprise_account_groups) | data source |
| [ibm_enterprise_accounts.all_accounts](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/enterprise_accounts) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_group_ids_to_assign"></a> [account\_group\_ids\_to\_assign](#input\_account\_group\_ids\_to\_assign) | A list of account group IDs to assign the template to. Support passing the string 'all' in the list to assign to all account groups. | `list(string)` | <pre>[<br/>  "all"<br/>]</pre> | no |
| <a name="input_template_description"></a> [template\_description](#input\_template\_description) | Description of the account settings template | `string` | `null` | no |
| <a name="input_template_name"></a> [template\_name](#input\_template\_name) | Name of the account settings template | `string` | n/a | yes |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_enterprise_account_ids"></a> [enterprise\_account\_ids](#output\_enterprise\_account\_ids) | List of child enterprise account IDs |
| <a name="output_account_settings_template_assignment_ids"></a> [account\_settings\_template\_assignment\_ids](#output\_account\_settings\_template\_assignment\_ids) | The list of assignment IDs to child accounts |
| <a name="output_account_settings_template_id"></a> [account\_settings\_template\_id](#output\_account\_settings\_template\_id) | The ID of the account settings template |
| <a name="output_account_settings_template_id_raw"></a> [account\_settings\_template\_id\_raw](#output\_account\_settings\_template\_id\_raw) | Full raw ID (including version) of the account settings template |
| <a name="output_account_settings_template_version"></a> [account\_settings\_template\_version](#output\_account\_settings\_template\_version) | The version of the Account Settings Template |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->