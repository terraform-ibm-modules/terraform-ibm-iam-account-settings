# Account Settings Template example

An example that demonstrates how to use the `account-settings-template` submodule. This example will do the following:

- Create an account settings template with default settings
- Assign the template to an account group

:warning: This example will only execute on an enterprise account

**NOTE:** This example will enforce only allowed IP addresses passed in the `allowed_ip_addresses` list variable. To ensure
someone running this example does not lock themselves out of their account, the default value in this example is set to
`"0.0.0.0/0"` to allowlist all IPs.
