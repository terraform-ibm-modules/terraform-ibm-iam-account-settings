##############################################################################
# Input Variables
##############################################################################

variable "allowed_ip_addresses" {
  description = "List of the IP addresses and subnets from which IAM tokens can be created for the account."
  type        = list(any)
  default     = []
}

variable "enforce_allowed_ip_addresses" {
  type        = bool
  default     = true
  description = "If true IP address restriction will be enforced, If false, traffic originated outside specified allowed IP address set is monitored with audit events sent to SIEM and Activity Tracker. After running in monitored mode to test this variable, it should then explicitly be set to true to enforce IP allow listing."
}

variable "max_sessions_per_identity" {
  description = "Defines the maximum allowed sessions per identity required by the account. Supports any whole number greater than '0', or 'NOT_SET' to unset account setting and use service default."
  type        = string
  default     = "NOT_SET"
}

variable "public_access_enabled" {
  type        = bool
  description = "Enable/Disable public access group in which resources are open anyone regardless if they are member of your account or not"
  default     = false
}

variable "mfa" {
  type        = string
  description = "Specify Multi-Factor Authentication method in the account. Supported valid values are 'NONE' (No MFA trait set), 'TOTP' (For all non-federated IBMId users), 'TOTP4ALL' (For all users), 'LEVEL1' (Email based MFA for all users), 'LEVEL2' (TOTP based MFA for all users), 'LEVEL3' (U2F MFA for all users)."
  default     = "TOTP4ALL"
  validation {
    condition = anytrue([
      var.mfa == "NONE",
      var.mfa == "TOTP",
      var.mfa == "TOTP4ALL",
      var.mfa == "LEVEL1",
      var.mfa == "LEVEL2",
      var.mfa == "LEVEL3"
    ])
    error_message = "mfa value must be one of NONE, TOTP, TOTP4ALL, LEVEL1, LEVEL2, LEVEL3"
  }
}
variable "user_mfa" {
  type = set(object({
    iam_id = string
    mfa    = string
  }))
  description = "Specify Multi-Factor Authentication method for specific users the account. Supported valid values are 'NONE' (No MFA trait set), 'TOTP' (For all non-federated IBMId users), 'TOTP4ALL' (For all users), 'LEVEL1' (Email based MFA for all users), 'LEVEL2' (TOTP based MFA for all users), 'LEVEL3' (U2F MFA for all users). Example of format is available here > https://github.com/terraform-ibm-modules/terraform-ibm-iam-account-settings#usage"
  default     = []
  validation {
    condition = alltrue([
      for o in var.user_mfa : contains(["NONE", "TOTP", "TOTP4ALL", "LEVEL1", "LEVEL2", "LEVEL3"], o.mfa)
    ])
    error_message = "User mfa value must be one of NONE, TOTP, TOTP4ALL, LEVEL1, LEVEL2, LEVEL3"
  }

}
variable "user_mfa_reset" {
  type        = bool
  description = "Set to true to delete all user MFA settings configured in the targeted account, and ignoring entries declared in var `user_mfa`"
  default     = false
}

variable "api_creation" {
  type        = string
  description = "When restriction is enabled, only users, including the account owner, assigned the User API key creator role on the IAM Identity Service can create API keys. Allowed values are 'RESTRICTED', 'NOT_RESTRICTED', or 'NOT_SET' (to 'unset' a previous set value)."
  default     = "RESTRICTED"
  validation {
    condition = anytrue([
      var.api_creation == "RESTRICTED",
      var.api_creation == "NOT_RESTRICTED",
      var.api_creation == "NOT_SET"
    ])
    error_message = "api_creation value must be one of RESTRICTED, NOT_RESTRICTED, or NOT_SET"
  }
}

variable "serviceid_creation" {
  type        = string
  description = "When restriction is enabled, only users, including the account owner, assigned the Service ID creator role on the IAM Identity Service can create service IDs. Allowed values are 'RESTRICTED', 'NOT_RESTRICTED', or 'NOT_SET' (to 'unset' a previous set value)."
  default     = "RESTRICTED"
  validation {
    condition = anytrue([
      var.serviceid_creation == "RESTRICTED",
      var.serviceid_creation == "NOT_RESTRICTED",
      var.serviceid_creation == "NOT_SET"
    ])
    error_message = "serviceid_creation value must be one of RESTRICTED, NOT_RESTRICTED, or NOT_SET"
  }
}

variable "active_session_timeout" {
  type        = number
  description = "Specify how long (seconds) a user is allowed to work continuously in the account"
  default     = "86400"
  validation {
    condition     = var.active_session_timeout >= 900 && var.active_session_timeout <= 86400
    error_message = "Accepted values: 900-86400."
  }
}

variable "inactive_session_timeout" {
  type        = string
  description = "Specify how long (seconds) a user is allowed to stay logged in the account while being inactive/idle"
  default     = "7200"
  validation {
    condition     = var.inactive_session_timeout >= 900 && var.inactive_session_timeout <= 7200
    error_message = "Accepted values: 900-7200."
  }
}

variable "refresh_token_expiration" {
  type        = string
  description = "Defines the refresh token expiration in seconds"
  default     = "259200"
  validation {
    condition     = var.refresh_token_expiration >= 900 && var.refresh_token_expiration <= 2592000
    error_message = "Accepted values: 900-2592000."
  }
}

variable "access_token_expiration" {
  type        = string
  description = "Defines the access token expiration in seconds"
  default     = "3600"
  validation {
    condition     = var.access_token_expiration >= 900 && var.access_token_expiration <= 3600
    error_message = "Accepted values: 900-3600."
  }
}

variable "shell_settings_enabled" {
  description = "Enable global shell settings to all users in the account"
  type        = bool
  default     = false
}

variable "cbr_zones" {
  description = "A list of CBR zones created by the module"
  type = list(object({
    account_id = optional(string)
    addresses = optional(list(object({
      type  = optional(string)
      value = optional(string)
      ref = optional(object({
        account_id       = string
        location         = optional(string)
        service_instance = optional(string)
        service_name     = optional(string)
        service_type     = optional(string)
      }))
    })), [])
    excluded_addresses = optional(list(object({
      type  = optional(string)
      value = optional(string)
    })), [])
    name             = string
    zone_description = optional(string, null)
  }))
  default = []
}

variable "skip_cloud_shell_calls" {
  type        = bool
  description = "Enable/Disable Global Cloud Shell settings in the account."
  default     = false
}
##############################################################################
