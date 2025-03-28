terraform {
  required_version = ">= 1.9.0"
  required_providers {
    # Pin to the lowest provider version of the range defined in the main module to ensure lowest version still works
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "1.65.0"
    }
    restapi = {
      source  = "Mastercard/restapi"
      version = "1.18.2"
    }
  }
}
