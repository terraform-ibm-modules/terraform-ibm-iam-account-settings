# Account Settings Template example

<!-- BEGIN SCHEMATICS DEPLOY HOOK -->
<a href="https://cloud.ibm.com/schematics/workspaces/create?workspace_name=iam-account-settings-account-settings-template-example&repository=https://github.com/terraform-ibm-modules/terraform-ibm-iam-account-settings/tree/main/examples/account-settings-template"><img src="https://img.shields.io/badge/Deploy%20with IBM%20Cloud%20Schematics-0f62fe?logo=ibm&logoColor=white&labelColor=0f62fe" alt="Deploy with IBM Cloud Schematics" style="height: 16px; vertical-align: text-bottom;"></a>
<!-- END SCHEMATICS DEPLOY HOOK -->


An example that demonstrates how to use the `account-settings-template` submodule. This example will do the following:

- Create an account settings template with default settings
- Assign the template to an account group

:warning: This example will only execute on an enterprise account

**NOTE:** This example will enforce only allowed IP addresses passed in the `allowed_ip_addresses` list variable. To ensure
someone running this example does not lock themselves out of their account, the default value in this example is set to
`"0.0.0.0/0"` to allowlist all IPs.

<!-- BEGIN SCHEMATICS DEPLOY TIP HOOK -->
:information_source: Ctrl/Cmd+Click or right-click on the Schematics deploy button to open in a new tab
<!-- END SCHEMATICS DEPLOY TIP HOOK -->
