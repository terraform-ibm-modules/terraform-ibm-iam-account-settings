
##############################################################################
# IAM Account Settings Template
#
# Configures standard account & IAM parameters
##############################################################################

# Data source to get account settings
data "ibm_iam_account_settings" "iam_account_settings" {
}

resource "ibm_iam_account_settings_template" "account_settings_template_instance" {
  name        = var.template_name
  description = var.template_description

  account_settings {
    allowed_ip_addresses = local.iam_allowed_ip_addresses
    max_sessions_per_identity = var.max_sessions_per_identity
    mfa = var.mfa
    dynamic "user_mfa" {
      for_each = local.user_mfa_list
      content {
        iam_id = user_mfa.value.iam_id
        mfa    = user_mfa.value.mfa
      }
    }
    restrict_create_service_id                 = var.serviceid_creation
    restrict_create_platform_apikey            = var.api_creation
    session_expiration_in_seconds              = var.active_session_timeout
    session_invalidation_in_seconds            = var.inactive_session_timeout
    system_access_token_expiration_in_seconds  = var.access_token_expiration
    system_refresh_token_expiration_in_seconds = var.refresh_token_expiration
  }

  committed = true
}

locals {
  user_mfa_list                         = var.user_mfa_reset == true ? [] : (length(var.user_mfa) == 0 ? data.ibm_iam_account_settings.iam_account_settings.user_mfa : var.user_mfa) # Use this as workaround for issue https://github.com/IBM-Cloud/terraform-provider-ibm/issues/4967
  concatenated_allowed_ip_addresses     = join(",", var.allowed_ip_addresses)
  iam_allowed_ip_addresses              = var.enforce_allowed_ip_addresses == false ? "?${local.concatenated_allowed_ip_addresses}" : local.concatenated_allowed_ip_addresses
}

data "ibm_enterprise_accounts" "all_accounts" {}

data "ibm_enterprise_account_groups" "all_groups" {
  depends_on = [data.ibm_enterprise_accounts.all_accounts]
}

locals {
  group_targets = [
    for group in data.ibm_enterprise_account_groups.all_groups.account_groups : {
      id   = group.id
      type = "AccountGroup"
    }
  ]

  compared_list = flatten(
    [
      for group in local.group_targets :
      [
        for provided_group in var.account_group_ids_to_assign :
        provided_group if group.id == provided_group
      ]
    ]
  )

  all_groups = length(var.account_group_ids_to_assign) > 0 ? var.account_group_ids_to_assign[0] == "all" ? true : false : false
  # tflint-ignore: terraform_unused_declarations
  validate_group_ids = !local.all_groups ? length(local.compared_list) != length(var.account_group_ids_to_assign) ? tobool("Could not find all of the groups listed in the 'account_group_ids_to_assign' value. Please verify all values are correct") : true : true

  combined_targets = local.all_groups ? {
    for target in local.group_targets :
    "${target.type}-${target.id}" => target
    } : {
    for target in local.group_targets :
    "${target.type}-${target.id}" => target if contains(var.account_group_ids_to_assign, target.id)
  }

}

resource "ibm_iam_account_settings_template_assignment" "account_settings_template_assignment_instance" {
  for_each = local.combined_targets

  template_id      = split("/", ibm_iam_account_settings_template.account_settings_template_instance.id)[0]
  template_version = ibm_iam_account_settings_template.account_settings_template_instance.version
  target           = each.value.id
  target_type      = each.value.type

  provisioner "local-exec" {
    command = "echo Assigned template to ${each.value.type}: ${each.value.id}"
  }
}