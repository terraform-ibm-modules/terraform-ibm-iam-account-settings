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

variable "custom_allowed_ip_addresses" {
  type        = string
  description = "Specify additional IPv4/IPv6 addresses/subnets that have access to the account, separate multiple values with a comma"
  default     = ""
}

variable "shell_settings_enabled" {
  description = "Enable/Disable global shell settings to all users in the account"
  type        = bool
  default     = true
}

variable "mfa" {
  default     = "NONE"
  type        = string
  description = "Specify Multi-Factor Authentication method in the account"
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
  default     = "7200"
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
variable "ignore_ibm_approved_ip_addresses" {
  default     = true
  type        = bool
  description = "If true IP address control will only be evaluate custom_allowed_ip_addresses, If false, restricion will be consider both IBM approved IP sets and custom_allowed_ip_addresses (if configured)"
}
