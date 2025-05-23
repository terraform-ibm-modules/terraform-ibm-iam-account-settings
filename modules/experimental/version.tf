terraform {
  required_version = ">= 1.9.0"
  required_providers {
    # Use "greater than or equal to" range in modules
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = ">= 1.49.0, < 2.0.0"
    }
    restapi = {
      source  = "Mastercard/restapi"
      version = ">= 1.18.2,< 2.0.0"
    }
  }
}
