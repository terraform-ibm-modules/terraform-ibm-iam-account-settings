##################################################################
## Apply account settings
##################################################################

module "iam_account_settings" {
  source                       = "../../"
  enforce_allowed_ip_addresses = false
  shell_settings_enabled       = true
  skip_cloud_shell_calls       = true # temporary workaround https://github.ibm.com/GoldenEye/issues/issues/9146
  mfa                          = "TOTP4ALL"
  public_access_enabled        = true
  serviceid_creation           = "NOT_RESTRICTED"
  active_session_timeout       = "28800"
  inactive_session_timeout     = "3600"
  access_token_expiration      = "3600"
  refresh_token_expiration     = "86400"
  api_creation                 = "NOT_RESTRICTED"
  cbr_zones = [{
    name             = "${var.prefix}-zone-1"
    zone_description = "test zone in iam-account-settings module"
    addresses = [{
      type = "serviceRef"
      ref = {
        account_id   = data.ibm_iam_account_settings.iam_account_settings.account_id
        service_name = "secrets-manager"
      }
    }]
  }]
}

module "experimental_settings" {
  source               = "../../modules/experimental"
  fs_validated         = false
  user_list_visibility = false
}
