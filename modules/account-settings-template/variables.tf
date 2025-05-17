
variable "template_name" {
  description = "Name of the account settings template"
  type        = string
}

variable "template_description" {
  description = "Description of the account settings template"
  type        = string
  default     = null
}

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

variable "account_group_ids_to_assign" {
  type        = list(string)
  default     = ["all"]
  description = "A list of account group IDs to assign the template to. Support passing the string 'all' in the list to assign to all account groups."
  nullable    = false

  validation {
    condition     = contains(var.account_group_ids_to_assign, "all") ? length(var.account_group_ids_to_assign) == 1 : true
    error_message = "When specifying 'all' in the list, you cannot add any other values to the list"
  }
}
