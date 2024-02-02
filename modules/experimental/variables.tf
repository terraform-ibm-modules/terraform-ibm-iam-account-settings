##############################################################################
# Input Variables
##############################################################################

variable "api_endpoint" {
  description = "Endpoint to use for API calls for `var.fs_validated` and `var.user_list_visibility`"
  type        = string
  default     = "accounts.cloud.ibm.com"
}

variable "fs_validated" {
  description = "Enable use of financial services validated products in the account"
  type        = bool
  default     = true
}

variable "user_list_visibility" {
  description = "Enable restriction of user list visibility in the account"
  type        = bool
  default     = true
}
