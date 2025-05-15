##################################################################
## Apply account settings Template
##################################################################

module "account_settings_template" {
  source               = "../../modules/account-settings-template"
  allowed_ip_addresses = var.allowed_ip_addresses
  template_name        = "${var.prefix}-template"
  template_description = "Minimal example for account settings template"

  account_group_ids_to_assign = var.account_group_ids_to_assign
}
