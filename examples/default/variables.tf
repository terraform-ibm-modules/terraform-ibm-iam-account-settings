variable "ibmcloud_api_key" {
  type        = string
  sensitive   = true
  description = "The IBM Cloud API token this account authenticates to"
}

variable "allowed_ip_addresses" {
  description = "List of the IP addresses and subnets from which IAM tokens can be created for the account."
  type        = list(any)
  default     = ["0.0.0.0/0"]
}
