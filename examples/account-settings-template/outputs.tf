########################################################################################################################
# Outputs
########################################################################################################################

output "account_settings_template_id" {
  description = "The ID of the account settings template"
  value       = module.account_settings_template.account_settings_template_id
}

output "account_settings_template_id_raw" {
  description = "Full raw ID (including version) of the account settings template"
  value       = module.account_settings_template.account_settings_template_id_raw
}

output "account_settings_template_version" {
  description = "The version of the account settings Template"
  value       = module.account_settings_template.account_settings_template_version
}

output "all_enterprise_accounts" {
  description = "List of all enterprise accounts returned by the data source"
  value       = module.account_settings_template.enterprise_account_ids
}

output "account_settings_template_assignment_ids" {
  description = "List of assignment IDs to child accounts"
  value       = module.account_settings_template.account_settings_template_assignment_ids
}
