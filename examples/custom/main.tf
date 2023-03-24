##################################################################
## Apply account settings
##################################################################

module "iam_account_settings" {
  source                           = "../.."
  enforce_allowed_ip_addresses     = var.enforce_allowed_ip_addresses
  shell_settings_enabled           = var.shell_settings_enabled
  mfa                              = var.mfa
  public_access_enabled            = var.public_access_enabled
  serviceid_creation               = var.serviceid_creation
  active_session_timeout           = var.active_session_timeout
  inactive_session_timeout         = var.inactive_session_timeout
  access_token_expiration          = var.access_token_expiration
  refresh_token_expiration         = var.refresh_token_expiration
  custom_allowed_ip_addresses      = var.custom_allowed_ip_addresses
  ignore_ibm_approved_ip_addresses = var.ignore_ibm_approved_ip_addresses
  api_creation                     = var.api_creation
}
