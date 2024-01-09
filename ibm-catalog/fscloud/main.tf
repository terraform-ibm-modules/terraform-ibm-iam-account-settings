module "iam_account_settings" {
  source                       = "../.."
  allowed_ip_addresses         = var.allowed_ip_addresses
  enforce_allowed_ip_addresses = true
  max_sessions_per_identity    = var.max_sessions_per_identity
  public_access_enabled        = false
  mfa                          = var.mfa
  api_creation                 = "RESTRICTED"
  serviceid_creation           = "RESTRICTED"
  active_session_timeout       = var.active_session_timeout
  inactive_session_timeout     = var.inactive_session_timeout
  refresh_token_expiration     = var.refresh_token_expiration
  access_token_expiration      = var.access_token_expiration
  shell_settings_enabled       = false
  fs_validated                 = true
  user_list_visibility         = true
}
