data "ibm_iam_account_settings" "iam_account_settings" {
}

locals {
  traits_path = "//${var.api_endpoint}/v1/accounts/${data.ibm_iam_account_settings.iam_account_settings.account_id}/traits"
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
