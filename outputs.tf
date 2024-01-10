##############################################################################
# Outputs
##############################################################################

output "account_public_access" {
  value       = local.account_public_access
  description = "Current state of public access group setting"
}

output "account_shell_settings_status" {
  value       = local.account_shell_settings_status
  description = "Current state of global shell setting"
}

output "account_iam_serviceid_creation" {
  value       = local.account_iam_serviceid_creation
  description = "Current state of ServiceID creation restriction"
}

output "account_iam_apikey_creation" {
  value       = local.account_iam_apikey_creation
  description = "Current state of API key creation restriction"
}

output "account_iam_mfa" {
  value       = local.account_iam_mfa
  description = "Current MFA setting"
}

output "account_iam_active_session_timeout" {
  value       = local.account_iam_active_session_timeout
  description = "Current active session timeout"
}

output "account_iam_inactive_session_timeout" {
  value       = local.account_iam_inactive_session_timeout
  description = "Current inactive session timeout"
}

output "account_iam_access_token_expiration" {
  value       = local.account_iam_access_token_expiration
  description = "Current access token expiration"
}

output "account_iam_refresh_token_expiration" {
  value       = local.account_iam_refresh_token_expiration
  description = "Current refresh token expiration"
}

output "account_allowed_ip_addresses" {
  value       = local.account_iam_allowed_ip_addresses
  description = "Current allowed IP addresses"
}

output "account_allowed_ip_addresses_enforced" {
  value       = var.enforce_allowed_ip_addresses
  description = "Current allowed IP addresses enforcement state"
}

output "account_allowed_ip_addresses_control_mode" {
  value       = local.iam_allowed_ip_addresses_control_mode
  description = "Current allowed IP addresses enforcement control mode, will indicate RESTRICT if account_allowed_ip_addresses_enforced is TRUE"
}

output "account_iam_user_mfa_list" {
  value       = local.user_mfa_list
  description = "Current list of users with specific MFA settings"
}

output "account_fs_validated" {
  value       = var.fs_validated
  description = "Current Financial Services validated setting"
}

output "account_user_list_visibility" {
  value       = var.user_list_visibility
  description = "Current User List visibility restriction setting"
}

##############################################################################
