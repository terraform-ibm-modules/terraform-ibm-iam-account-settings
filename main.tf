##############################################################################
# IAM Account Settings
#
# Configures standard account & IAM parameters
##############################################################################


# Validation (Approach based on https://stackoverflow.com/a/66682419)

locals {
  validate_condition1 = var.ignore_ibm_approved_ip_addresses == true && var.custom_allowed_ip_addresses == ""
  validate_msg1       = "Value for 'custom_allowed_ip_addresses' must be passed/added when 'ignore_ibm_approved_ip_addresses = true'"
  # tflint-ignore: terraform_unused_declarations
  validate_check1 = regex("^${local.validate_msg1}$", (!local.validate_condition1 ? local.validate_msg1 : ""))
}


# Data source to get account settings
data "ibm_iam_account_settings" "iam_account_settings" {
}

# Data source to get shell settings
data "ibm_cloud_shell_account_settings" "cloud_shell_account_settings" {
  account_id = data.ibm_iam_account_settings.iam_account_settings.account_id
}

# Configure IAM account settings with specified allowed IPs


resource "ibm_iam_account_settings" "iam_account_settings" {
  if_match                                   = "*"
  allowed_ip_addresses                       = local.iam_allowed_ip_addresses
  mfa                                        = var.mfa
  restrict_create_service_id                 = var.serviceid_creation
  restrict_create_platform_apikey            = var.api_creation
  session_expiration_in_seconds              = var.active_session_timeout
  session_invalidation_in_seconds            = var.inactive_session_timeout
  system_access_token_expiration_in_seconds  = var.access_token_expiration
  system_refresh_token_expiration_in_seconds = var.refresh_token_expiration
}

# Configure global shell settings

resource "ibm_cloud_shell_account_settings" "cloud_shell_account_settings" {
  rev        = data.ibm_cloud_shell_account_settings.cloud_shell_account_settings.rev
  account_id = data.ibm_iam_account_settings.iam_account_settings.account_id
  enabled    = var.shell_settings_enabled
}

# Configure account public access
resource "restapi_object" "account_public_access" {
  path           = "//iam.cloud.ibm.com/v2/groups/settings?account_id={id}"
  data           = "{\"public_access_enabled\": ${var.public_access_enabled}}"
  create_method  = "PATCH"
  create_path    = "//iam.cloud.ibm.com/v2/groups/settings?account_id={id}"
  update_method  = "PATCH"
  update_path    = "//iam.cloud.ibm.com/v2/groups/settings?account_id={id}"
  destroy_method = "GET"
  destroy_path   = "//iam.cloud.ibm.com/v2/groups/settings?account_id={id}"
  read_path      = "//iam.cloud.ibm.com/v2/groups/settings?account_id={id}"
  object_id      = data.ibm_iam_account_settings.iam_account_settings.account_id
  id_attribute   = data.ibm_iam_account_settings.iam_account_settings.account_id
  force_new      = [var.public_access_enabled]
}

# Variables to extract settings applied
locals {
  validate_custom_only                  = var.custom_allowed_ip_addresses != "" && var.ignore_ibm_approved_ip_addresses == true ? true : false
  raw_iam_allowed_ip_addresses          = local.validate_custom_only == false && var.custom_allowed_ip_addresses == "" ? local.concatenated_allowed_ip_addresses : var.custom_allowed_ip_addresses
  consolidated_iam_allowed_ip_addresses = var.ignore_ibm_approved_ip_addresses == false && var.custom_allowed_ip_addresses != "" ? "${local.concatenated_allowed_ip_addresses},${local.raw_iam_allowed_ip_addresses}" : local.raw_iam_allowed_ip_addresses
  iam_allowed_ip_addresses              = var.enforce_allowed_ip_addresses == false ? "?${local.consolidated_iam_allowed_ip_addresses}" : local.consolidated_iam_allowed_ip_addresses
  iam_allowed_ip_addresses_control_mode = var.enforce_allowed_ip_addresses == false ? "MONITOR" : "RESTRICT"
  account_public_access                 = lookup(jsondecode(restapi_object.account_public_access.create_response), "public_access_enabled")
  account_shell_settings_status         = ibm_cloud_shell_account_settings.cloud_shell_account_settings.enabled
  account_iam_serviceid_creation        = ibm_iam_account_settings.iam_account_settings.restrict_create_service_id
  account_iam_apikey_creation           = ibm_iam_account_settings.iam_account_settings.restrict_create_platform_apikey
  account_iam_mfa                       = ibm_iam_account_settings.iam_account_settings.mfa
  account_iam_active_session_timeout    = ibm_iam_account_settings.iam_account_settings.session_expiration_in_seconds
  account_iam_inactive_session_timeout  = ibm_iam_account_settings.iam_account_settings.session_invalidation_in_seconds
  account_iam_access_token_expiration   = ibm_iam_account_settings.iam_account_settings.system_access_token_expiration_in_seconds
  account_iam_refresh_token_expiration  = ibm_iam_account_settings.iam_account_settings.system_refresh_token_expiration_in_seconds
  account_iam_allowed_ip_addresses      = ibm_iam_account_settings.iam_account_settings.allowed_ip_addresses
}
