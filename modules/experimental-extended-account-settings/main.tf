data "ibm_iam_account_settings" "iam_account_settings" {
}

locals {
  traits_path = "//${var.api_endpoint}/v1/accounts/${data.ibm_iam_account_settings.iam_account_settings.account_id}/traits"
}

module "iam_account_settings" {
  source                       = "../.."
  allowed_ip_addresses         = var.allowed_ip_addresses
  enforce_allowed_ip_addresses = var.enforce_allowed_ip_addresses
  max_sessions_per_identity    = var.max_sessions_per_identity
  public_access_enabled        = var.public_access_enabled
  mfa                          = var.mfa
  user_mfa                     = var.user_mfa
  user_mfa_reset               = var.user_mfa_reset
  api_creation                 = var.api_creation
  serviceid_creation           = var.serviceid_creation
  active_session_timeout       = var.active_session_timeout
  inactive_session_timeout     = var.inactive_session_timeout
  refresh_token_expiration     = var.refresh_token_expiration
  access_token_expiration      = var.access_token_expiration
  shell_settings_enabled       = var.shell_settings_enabled
}

resource "restapi_object" "fs_validated" {
  path           = local.traits_path
  data           = "{\"fs_ready\": ${var.fs_validated}}"
  create_method  = "PATCH"
  create_path    = local.traits_path
  destroy_method = "GET"
  destroy_path   = local.traits_path
  read_method    = "GET"
  read_path      = local.traits_path
  update_method  = "PATCH"
  update_path    = local.traits_path
  object_id      = data.ibm_iam_account_settings.iam_account_settings.account_id
  id_attribute   = data.ibm_iam_account_settings.iam_account_settings.account_id
  force_new      = [var.fs_validated]
}

resource "restapi_object" "user_list_visibility" {
  path           = local.traits_path
  data           = "{\"team_directory_enabled\": ${var.user_list_visibility}}"
  create_method  = "PATCH"
  create_path    = local.traits_path
  destroy_method = "GET"
  destroy_path   = local.traits_path
  read_method    = "GET"
  read_path      = local.traits_path
  update_method  = "PATCH"
  update_path    = local.traits_path
  object_id      = data.ibm_iam_account_settings.iam_account_settings.account_id
  id_attribute   = data.ibm_iam_account_settings.iam_account_settings.account_id
  force_new      = [var.user_list_visibility]
}
