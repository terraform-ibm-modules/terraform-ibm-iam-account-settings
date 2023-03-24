##############################################################################
# Input Variables
# See reference for other accepted input values >
# https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/iam_account_settings
##############################################################################

locals {
  concatenated_allowed_ip_addresses_list = concat(var.allowed_ip_addresses_taas_jenkins_tekton, var.allowed_ip_addresses_travis, var.allowed_ip_addresses_continuous_delivery, var.allowed_ip_addresses_cloudshell, var.allowed_ip_addresses_iks_control_plane_fw, var.allowed_ip_addresses_iks_sysdig_monitoring, var.allowed_ip_addresses_iks_accesshub, var.allowed_ip_addresses_iks_activity_tracker_ldna, var.allowed_ip_addresses_iks_container_registry, concat(var.allowed_ip_schematics_eu_central, var.allowed_ip_schematics_uk_south, var.allowed_ip_schematics_us))
  concatenated_allowed_ip_addresses      = join(",", local.concatenated_allowed_ip_addresses_list)
}

variable "allowed_ip_addresses_taas_jenkins_tekton" {
  description = "Jenkins/Tekton IP addresses/ranges in list"
  type        = list(any)
  default     = []
}

variable "allowed_ip_addresses_travis" {
  description = "Travis IP addresses/ranges in list"
  type        = list(any)
  default     = []
}

variable "allowed_ip_addresses_continuous_delivery" {
  description = "Continuous Delivery IP addresses/ranges in list"
  type        = list(any)
  default     = []
}

variable "allowed_ip_addresses_cloudshell" {
  description = "CloudShell IP addresses/ranges in list"
  type        = list(any)
  default     = []
}

variable "allowed_ip_addresses_iks_control_plane_fw" {
  description = "IKS' Control Plane IP addresses/ranges in list"
  type        = list(any)
  default     = []
}

variable "allowed_ip_addresses_iks_sysdig_monitoring" {
  description = "Cloud Monitoring (Sysdig) IP addresses/ranges in list"
  type        = list(any)
  default     = []
}

variable "allowed_ip_addresses_iks_accesshub" {
  description = "AccessHub IP addresses/ranges in list"
  type        = list(any)
  default     = []
}

variable "allowed_ip_addresses_iks_activity_tracker_ldna" {
  description = "Activity Tracker (LogDNA) IP addresses/ranges in list"
  type        = list(any)
  default     = []
}

variable "allowed_ip_addresses_iks_container_registry" {
  description = "Container Registry IP addresses/ranges in list"
  type        = list(any)
  default     = []
}

variable "allowed_ip_schematics_eu_central" {
  description = "Schematics EU IP addresses/ranges in list"
  type        = list(any)
  default     = []
}

variable "allowed_ip_schematics_uk_south" {
  description = "Schematics UK South IP addresses/ranges in list"
  type        = list(any)
  default     = []
}

variable "allowed_ip_schematics_us" {
  description = "Schematics US IP addresses/ranges in list"
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
