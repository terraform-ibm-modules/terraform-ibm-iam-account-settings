##################################################################
## Apply account settings
##################################################################

module "iam_account_settings" {
  source               = "../.."
  allowed_ip_addresses = var.allowed_ip_addresses
}
