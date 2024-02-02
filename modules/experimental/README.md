# Experimental submodule

## Account Settings Support

The submodule handles the following account settings:

- Financial Services Validated products (on - off)
- User List Visibility restrictions (on - off)

The submodule supports creating and updating settings that are applied with the `terraform apply` command. With objects
affected by the `destroy` command, the module preserves the most recent setting and doesn't change objects that are
configured outside of Terraform's scope.

### Current Limitations

The submodule currently supports setting the following FSCloud requirements using the RestAPI provider until the IBM provider supports these settings:

- Check whether user list visibility restrictions are configured in IAM settings for the account owner
- Check whether the Financial Services Validated setting is enabled in account settings

Tracking issue with IBM provider -> <https://github.com/IBM-Cloud/terraform-provider-ibm/issues/4204>

Note: the API used for these settings is experimental and currently unsupported.

### Usage

```hcl
##############################################################################
# Configure Experimental IAM Account settings
##############################################################################
provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key # pragma: allowlist secret
}

data "ibm_iam_auth_token" "token_data" {
}

data "ibm_iam_account_settings" "iam_account_settings" {
}

provider "restapi" {
  uri                   = "https:"
  write_returns_object  = false
  create_returns_object = false
  debug                 = false
  headers = {
    Account       = data.ibm_iam_account_settings.iam_account_settings.account_id
    Authorization = data.ibm_iam_auth_token.token_data.iam_access_token
    Content-Type  = "application/json"
  }
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
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0, <1.6.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.49.0 |
| <a name="requirement_restapi"></a> [restapi](#requirement\_restapi) | >= 1.18.2 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [restapi_object.fs_validated](https://registry.terraform.io/providers/Mastercard/restapi/latest/docs/resources/object) | resource |
| [restapi_object.user_list_visibility](https://registry.terraform.io/providers/Mastercard/restapi/latest/docs/resources/object) | resource |
| [ibm_iam_account_settings.iam_account_settings](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/iam_account_settings) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_endpoint"></a> [api\_endpoint](#input\_api\_endpoint) | Endpoint to use for API calls for `var.fs_validated` and `var.user_list_visibility` | `string` | `"accounts.cloud.ibm.com"` | no |
| <a name="input_fs_validated"></a> [fs\_validated](#input\_fs\_validated) | Enable use of financial services validated products in the account | `bool` | `true` | no |
| <a name="input_user_list_visibility"></a> [user\_list\_visibility](#input\_user\_list\_visibility) | Enable restriction of user list visibility in the account | `bool` | `true` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_account_fs_validated"></a> [account\_fs\_validated](#output\_account\_fs\_validated) | Current Financial Services validated setting |
| <a name="output_account_user_list_visibility"></a> [account\_user\_list\_visibility](#output\_account\_user\_list\_visibility) | Current User List visibility restriction setting |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
