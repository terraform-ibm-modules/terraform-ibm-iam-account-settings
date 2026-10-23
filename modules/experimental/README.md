# Experimental submodule

The submodule handles the following account settings:

- Financial Services Validated products (on - off)
- User List Visibility restrictions (on - off)

The submodule supports creating and updating settings that are applied with the `terraform apply` command. With objects
affected by the `destroy` command, the module preserves the most recent setting and doesn't change objects that are
configured outside of Terraform's scope.

### Upgrading from versions that used the restapi provider

The settings are now applied with the `ibm_account_traits` resource from the IBM provider (`>= 2.9.0`), which calls the same Account Management API (`PATCH /v1/accounts/{account_id}/traits`). You no longer need to configure a `restapi` provider or an IAM token data source.

On the first apply after upgrading, the old `restapi_object` entries are dropped from state without calling their destroy (it was a no-op), and the new resource applies the same values. Nothing else changes in the account. A trait changed outside Terraform now shows as drift.

Note: the API used for these settings is experimental and currently unsupported.

### Usage

```hcl
provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key # pragma: allowlist secret
}

module "experimental-iam-account-settings" {
  source               = "terraform-ibm-modules/iam-account-settings/ibm//modules/experimental"
  version              = "X.X.X" # replace "X.X.X" with a release version to lock into a specific release
  api_endpoint         = "accounts.cloud.ibm.com"
  fs_validated         = true
  user_list_visibility = true
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 2.9.0, < 3.0.0 |

### Modules

No modules.

### Resources

| Name | Type |
| ---- | ---- |
| [ibm_account_traits.this](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/account_traits) | resource |

### Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_api_endpoint"></a> [api\_endpoint](#input\_api\_endpoint) | Endpoint to use for API calls for `var.fs_validated` and `var.user_list_visibility` | `string` | `"accounts.cloud.ibm.com"` | no |
| <a name="input_fs_validated"></a> [fs\_validated](#input\_fs\_validated) | Enable use of financial services validated products in the account | `bool` | `true` | no |
| <a name="input_user_list_visibility"></a> [user\_list\_visibility](#input\_user\_list\_visibility) | Enable restriction of user list visibility in the account | `bool` | `true` | no |

### Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_account_fs_validated"></a> [account\_fs\_validated](#output\_account\_fs\_validated) | Current Financial Services validated setting |
| <a name="output_account_user_list_visibility"></a> [account\_user\_list\_visibility](#output\_account\_user\_list\_visibility) | Current User List visibility restriction setting |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
