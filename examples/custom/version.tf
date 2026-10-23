terraform {
  required_version = ">= 1.9.0"
  required_providers {
    # Pin to the lowest provider version that supports ibm_account_traits (used by modules/experimental)
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "2.9.0"
    }
  }
}
