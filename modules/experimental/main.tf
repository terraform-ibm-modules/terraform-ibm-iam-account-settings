# Account traits, set with the IBM provider's ibm_account_traits resource
# (PATCH /v1/accounts/{account_id}/traits) on the provider's account.
# The values map to the API exactly as the restapi version did.
resource "ibm_account_traits" "this" {
  endpoint               = var.api_endpoint
  fs_ready               = var.fs_validated
  team_directory_enabled = var.user_list_visibility
}

# Drop the old restapi objects from state without calling their destroy. Their
# destroy was a no-op GET, so nothing in the account changes during the upgrade.
removed {
  from = restapi_object.fs_validated
  lifecycle {
    destroy = false
  }
}

removed {
  from = restapi_object.user_list_visibility
  lifecycle {
    destroy = false
  }
}
