# FSCloud IBM Cloud IAM Account Settings Solution

This solution is designed to configure IBM Cloud IAM account settings in such a way that complies with the relevant controls from the [IBM Cloud Framework for Financial Services](https://cloud.ibm.com/docs/framework-financial-services?topic=framework-financial-services-about).

**Current limitations:**
The module currently does not support setting the following FSCloud requirements:
- Check whether user list visibility restrictions are configured in IAM settings for the account owner
    - Follow these [steps](https://cloud.ibm.com/docs/account?topic=account-iam-user-setting) as a workaround to set this manually in the UI
- Check whether the Financial Services Validated setting is enabled in account settings
    - Follow these [steps](https://cloud.ibm.com/docs/account?topic=account-enabling-fs-validated) as a workaround to set this manually in the UI
