##################################################################
## Apply account settings
##################################################################

module "iam_account_settings" {
  source = "../.."
  # After running in monitored mode to test this variable should explicity be set to true to enfoce IP allow listing
  enforce_allowed_ip_addresses = false
}
