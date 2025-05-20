variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud API Token"
  sensitive   = true
}

variable "prefix" {
  type        = string
  description = "Prefix name for all related resources"
}

variable "allowed_ip_addresses" {
  description = "List of the IP addresses and subnets from which IAM tokens can be created for the account."
  type        = list(any)
  default     = ["0.0.0.0/0", "::/0"]
}

variable "account_group_ids_to_assign" {
  type        = list(string)
  default     = ["all"]
  description = "A list of account group IDs to assign the template to. Support passing the string 'all' in the list to assign to all account groups."
  nullable    = true
}

variable "account_ids_to_assign" {
  type        = list(string)
  default     = []
  description = "A list of account IDs to assign the template to. Support passing the string 'all' in the list to assign to all child accounts in the enterprise."
  nullable    = true
}
