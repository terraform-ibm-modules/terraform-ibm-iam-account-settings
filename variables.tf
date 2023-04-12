##############################################################################
# Input Variables
# See reference for other accepted input values >
# https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/iam_account_settings
##############################################################################

locals {
  concatenated_ibm_approved_ip_addresses = join(",", var.allowed_ip_addresses)
}

variable "allowed_ip_addresses" {
  description = "Defines the IP addresses and subnets from which IAM tokens can be created for the account."
  type        = list(any)
  default     = []
}

variable "public_access_enabled" {
  type        = bool
  description = "Enable/Disable public access group in which resources are open anyone regardless if they are member of your account or not"
  default     = false
}

variable "mfa" {
  type        = string
  description = "Specify Multi-Factor Authentication method in the account"
  default     = "TOTP4ALL"
}

variable "api_creation" {
  type        = string
  description = "When restriction is enabled, users in your account require specific access to create API keys, including the account owner"
  default     = "RESTRICTED"
}

variable "serviceid_creation" {
  type        = string
  description = "When restriction is enabled, users in your account require specific access to create service IDs, including the account owner"
  default     = "RESTRICTED"
}

variable "enforce_allowed_ip_addresses" {
  type        = bool
  default     = true
  description = "If true IP address restriction will be enforced, If false, traffic originated outside specified allowed IP address set is monitored with audit events sent to SIEM and Activity Tracker.   After running in monitored mode to test this variable should explicity be set to true to enfoce IP allow listing"
}

variable "ignore_ibm_approved_ip_addresses" {
  type        = bool
  default     = false
  description = "If true IP address control will only be evaluate custom_allowed_ip_addresses, If false, restricion will be consider both IBM approved IP sets and custom_allowed_ip_addresses (if configured)"
}

variable "custom_allowed_ip_addresses" {
  type        = string
  description = "Specify a custom list of IPv4/IPv6 addresses/subnets that have access to the account, separate multiple values with a comma"
  default     = ""
}

variable "active_session_timeout" {
  type        = string
  description = "Specify how long (seconds) a user is allowed to work continuosly in the account"
  default     = "3600"
}

variable "inactive_session_timeout" {
  type        = string
  description = "Specify how long (seconds) a user is allowed to stay logged in the account while being inactive/idle"
  default     = "900"
}

variable "refresh_token_expiration" {
  type        = string
  description = "Defines the refresh token expiration in seconds"
  default     = "259200"
}
variable "access_token_expiration" {
  type        = string
  description = "Defines the access token expiration in seconds"
  default     = "3600"
}

variable "shell_settings_enabled" {
  description = "Enable global shell settings to all users in the account"
  type        = bool
  default     = false
}

##############################################################################
