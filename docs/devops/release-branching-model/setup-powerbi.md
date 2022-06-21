---
---

## Create a new Service Principal

1. In Azure Active Directory, create a new [App Registration](https://portal.azure.com/#view/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/~/RegisteredApps). Provide a name and set a secret.

   ![AAD App Registrations](/images/setup-powerbi-072158.png)

   ![Register new app](/images/setup-powerbi-072429.png)

   ![New client secret](/images/setup-powerbi-072532.png)

2. Create a new AAD security group and add the service principal as a member.

   ![Security Group](/images/setup-powerbi-072711.png)

## Enable use of Service Principals

1. In [Power BI Tenant Settings](https://app.powerbi.com/admin-portal/tenantSettings), specify the security group under "Allow service principals to use Power BI APIs".

   ![Tenant Settings Allow Service Principals](/images/setup-powerbi-072907.png)

## Authorize service principals

1. In each Power BI Workspace to be used as a deployment target, make the service principal a workspace user.

2. For (thin) reports, the minimum access level is **Contributor**.

   ![Workspace Contributor](/images/setup-powerbi-073423.png)

3. For datasets, the **Member** level is required if dataset users should be set automatically. Otherwise, **Contributor** is sufficient.

   ![Workspace Member](/images/setup-powerbi-073156.png)
