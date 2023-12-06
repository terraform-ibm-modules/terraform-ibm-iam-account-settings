variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud API token this account authenticates to"
  sensitive   = true
}

variable "enforce_allowed_ip_addresses" {
  type        = bool
  description = "If true allowed_ip_addresses restriction will be enforced, If false, traffic originated outside allowed_ip_addresses is monitored with audit events sent to SIEM and Activity Tracker"
  default     = false
}

variable "shell_settings_enabled" {
  description = "Enable/Disable global shell settings to all users in the account"
  type        = bool
  default     = true
}

variable "mfa" {
  default     = "TOTP4ALL"
  type        = string
  description = "Specify Multi-Factor Authentication method in the account"
}

variable "user_mfa" {
  type = set(object({
    iam_id = string
    mfa    = string
  }))
  default = [{
    iam_id = "IBMid-3x000xx3xH"
    mfa    = "LEVEL3"
    },
    {
    iam_id = "IBMid-50xG4CxSQx"
    mfa    = "NONE"
  }]
  description = "Specify Multi-Factor Authentication method for specific users the account. Supported valid values are 'NONE' (No MFA trait set), 'TOTP' (For all non-federated IBMId users), 'TOTP4ALL' (For all users), 'LEVEL1' (Email based MFA for all users), 'LEVEL2' (TOTP based MFA for all users), 'LEVEL3' (U2F MFA for all users). Example of format is available here > https://github.com/terraform-ibm-modules/terraform-ibm-iam-account-settings#usage"
}

variable "public_access_enabled" {
  default     = true
  type        = bool
  description = "Enable/Disable public access group in which resources are open anyone regardless if they are member of your account or not"
}

variable "serviceid_creation" {
  default     = "NOT_RESTRICTED"
  type        = string
  description = "When restriction is enabled, users in your account require specific access to create API keys, including the account owner"
}

variable "api_creation" {
  default     = "NOT_RESTRICTED"
  type        = string
  description = "When restriction is enabled, users in your account require specific access to create API keys, including the account owner"
}

variable "active_session_timeout" {
  default     = "28800"
  type        = string
  description = "Specify how long (seconds) a user is allowed to work continuously in the account"
}

variable "inactive_session_timeout" {
  default     = "3600"
  type        = string
  description = "Specify how long (seconds) a user is allowed to stay logged in the account while being inactive/idle"
}

variable "refresh_token_expiration" {
  type        = string
  description = "Defines the refresh token expiration in seconds"
  default     = "86400"
}

variable "access_token_expiration" {
  type        = string
  description = "Defines the access token expiration in seconds"
  default     = "3600"
}
