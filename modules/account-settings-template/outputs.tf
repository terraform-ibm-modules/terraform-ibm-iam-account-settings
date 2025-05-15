########################################################################################################################
# Outputs
########################################################################################################################

output "account_settings_template_id" {
  description = "The ID of the account settings template"
  value       = split("/", ibm_iam_account_settings_template.account_settings_template_instance.id)[0]
}

output "enterprise_account_ids" {
  description = "List of child enterprise account IDs"
  value       = data.ibm_enterprise_accounts.all_accounts.accounts[*].id
}

output "account_settings_template_id_raw" {
  description = "Full raw ID (including version) of the account settings template"
  value       = ibm_iam_account_settings_template.account_settings_template_instance.id
}

output "account_settings_template_version" {
  description = "The version of the account settings Template"
  value       = ibm_iam_account_settings_template.account_settings_template_instance.version
}

output "account_settings_template_assignment_ids" {
  description = "List of assignment IDs to child accounts"
  value = {
    for k, v in ibm_iam_account_settings_template_assignment.account_settings_template_assignment_instance : k => v.id
  }
}