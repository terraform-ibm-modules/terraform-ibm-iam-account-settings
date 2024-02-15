##############################################################################
# Input Variables
##############################################################################

variable "api_endpoint" {
  description = "Endpoint to use for API calls for `var.fs_validated` and `var.user_list_visibility`"
  type        = string
  default     = "accounts.cloud.ibm.com"

  validation {
    condition = anytrue(
      [
        for region in ["us-south", "us-east", "eu-de", "eu-es", "eu-gb", "ca-tor", "br-sao", "au-syd", "in-che", "jp-osa", "jp-tok", "kr-seo", "eu-fr2"] :
        can(regex("^(?:private\\.${region}\\.)?accounts\\.cloud\\.ibm\\.com$", var.api_endpoint))
      ]
    )
    error_message = "API endpoint must match the following regex: \"^(private\\.<REGION>\\.)?accounts\\.cloud\\.ibm\\.com$\".\nNote that a region is required if using the private endpoint."
  }
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
