########################################################################################################################
# Outputs
########################################################################################################################

output "all_enterprise_accounts" {
  description = "List of all enterprise accounts returned by the data source"
  value       = module.account_settings_template.enterprise_account_ids
}

output "account_settings_template_id" {
  description = "ID of the account settings template"
  value       = split("/", module.account_settings_template.account_settings_template_id_raw)[0]
}
