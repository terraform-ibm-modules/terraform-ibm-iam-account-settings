terraform {
  required_version = ">= 1.3.0"
  required_providers {
    # Each required provider's version should be a flexible range to future proof the module's usage with upcoming minor and patch versions.
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = ">= 1.65.0, < 2.0.0"
    }
  }
}
