provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
}

data "ibm_iam_account_settings" "iam_account_settings" {
}
