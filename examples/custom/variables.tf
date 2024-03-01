variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud API token this account authenticates to"
  sensitive   = true
}

variable "prefix" {
  type        = string
  description = "Prefix used for CBR zone names"
  default     = "iam-acct-custom"
}
