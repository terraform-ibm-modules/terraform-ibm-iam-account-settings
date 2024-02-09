# FSCloud IBM Cloud IAM Account Settings Solution

This solution is designed to configure IBM Cloud IAM account settings in such a way that complies with the relevant controls from the [IBM Cloud Framework for Financial Services](https://cloud.ibm.com/docs/framework-financial-services?topic=framework-financial-services-about).

**Current limitations:**

This module consumes the experimental submodule that uses the RestAPI provider to call an experimental API that is currently unsupported to set the `FS Validated` and `User List Visibility Restrictions` values in the example.

The module currently supports setting the following FSCloud requirements using the RestAPI provider until the IBM provider supports these settings:

- Check whether user list visibility restrictions are configured in IAM settings for the account owner
- Check whether the Financial Services Validated setting is enabled in account settings

Tracking issue with IBM provider -> <https://github.com/IBM-Cloud/terraform-provider-ibm/issues/4204>
