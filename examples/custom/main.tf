##################################################################
## Apply account settings
##################################################################

module "iam_account_settings" {
  source                       = "../../modules/experimental-extended-account-settings"
  enforce_allowed_ip_addresses = false
  shell_settings_enabled       = true
  mfa                          = "TOTP4ALL"
  public_access_enabled        = true
  serviceid_creation           = "NOT_RESTRICTED"
  active_session_timeout       = "28800"
  inactive_session_timeout     = "3600"
  access_token_expiration      = "3600"
  refresh_token_expiration     = "86400"
  api_creation                 = "NOT_RESTRICTED"
  fs_validated                 = false
  user_list_visibility         = false
}
