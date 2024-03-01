variable "ibmcloud_api_key" {
  type        = string
  sensitive   = true
  description = "The IBM Cloud API token this account authenticates to"
}

variable "allowed_ip_addresses" {
  description = "List of the IP addresses and subnets from which IAM tokens can be created for the account."
  type        = list(any)
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
      var.mfa == "TOTP",
      var.mfa == "TOTP4ALL",
      var.mfa == "LEVEL1",
      var.mfa == "LEVEL2",
      var.mfa == "LEVEL3"
    ])
    error_message = "mfa value must be one of TOTP, TOTP4ALL, LEVEL1, LEVEL2, LEVEL3"
  }
}

variable "active_session_timeout" {
  type        = number
  description = "Specify how long (seconds) a user is allowed to work continuously in the account"
  default     = "3600"
  validation {
    condition     = var.active_session_timeout >= 900 && var.active_session_timeout <= 3600
    error_message = "Accepted values: 900-3600."
  }
}

variable "inactive_session_timeout" {
  type        = string
  description = "Specify how long (seconds) a user is allowed to stay logged in the account while being inactive/idle"
  default     = "900"
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
    condition     = var.refresh_token_expiration >= 900 && var.refresh_token_expiration <= 259200
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
