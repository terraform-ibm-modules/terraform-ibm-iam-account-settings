provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
}

data "ibm_iam_auth_token" "token_data" {
}

data "ibm_iam_account_settings" "iam_account_settings" {
}

provider "restapi" {
  uri                   = "https:"
  write_returns_object  = false
  create_returns_object = false
  debug                 = false
  headers = {
    Account       = data.ibm_iam_account_settings.iam_account_settings.account_id
    Authorization = data.ibm_iam_auth_token.token_data.iam_access_token
    Content-Type  = "application/json"
  }
}
