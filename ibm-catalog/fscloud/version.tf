terraform {
  required_version = ">= 1.0.0, <1.6.0"
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "1.61.0"
    }
    restapi = {
      source  = "Mastercard/restapi"
      version = "1.18.2"
    }
  }
}
