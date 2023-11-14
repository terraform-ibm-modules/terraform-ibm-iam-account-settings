##############################################################################
# IAM Account Settings
#
# Configures standard account & IAM parameters
##############################################################################

# Data source to get account settings
data "ibm_iam_account_settings" "iam_account_settings" {
}

# Data source to get shell settings
data "ibm_cloud_shell_account_settings" "cloud_shell_account_settings" {
  account_id = data.ibm_iam_account_settings.iam_account_settings.account_id
}

# Configure IAM account settings
resource "ibm_iam_account_settings" "iam_account_settings" {
  if_match                                   = "*"
  allowed_ip_addresses                       = local.iam_allowed_ip_addresses
  max_sessions_per_identity                  = var.max_sessions_per_identity
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
# (Using restapi provider for this until official IBM provider support is added -> https://github.com/IBM-Cloud/terraform-provider-ibm/issues/3285)
resource "restapi_object" "account_public_access" {
  path           = var.private_endpoint ? "//private.${local.public_endpoint}" : "//${local.public_endpoint}"
  data           = "{\"public_access_enabled\": ${var.public_access_enabled}}"
  create_method  = "PATCH"
  create_path    = "//${local.public_endpoint}"
  update_method  = "PATCH"
  update_path    = "//${local.public_endpoint}"
  destroy_method = "GET"
  destroy_path   = "//${local.public_endpoint}"
  read_path      = "//${local.public_endpoint}"
  object_id      = data.ibm_iam_account_settings.iam_account_settings.account_id
  id_attribute   = data.ibm_iam_account_settings.iam_account_settings.account_id
  force_new      = [var.public_access_enabled]
}

locals {
  public_endpoint                       = "iam.cloud.ibm.com/v2/groups/settings?account_id={id}"
  concatenated_allowed_ip_addresses     = join(",", var.allowed_ip_addresses)
  iam_allowed_ip_addresses              = var.enforce_allowed_ip_addresses == false ? "?${local.concatenated_allowed_ip_addresses}" : local.concatenated_allowed_ip_addresses
  iam_allowed_ip_addresses_control_mode = var.enforce_allowed_ip_addresses == false ? "MONITOR" : "RESTRICT"
  account_public_access                 = jsondecode(restapi_object.account_public_access.create_response)["public_access_enabled"]
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
