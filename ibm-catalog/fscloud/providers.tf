data "ibm_iam_auth_token" "tokendata" {}

provider "restapi" {
  uri                  = "https:"
  write_returns_object = true
  debug                = false # set to true to show detailed logs, but use carefully as it might print API key values.
  headers = {
    Authorization = data.ibm_iam_auth_token.tokendata.iam_access_token
    Content-Type  = "application/json"
    if-Match      = "*"
  }
}

provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
}
