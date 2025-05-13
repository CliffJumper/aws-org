# aws-org

IAC and automation to manage my AWS ORG

## NUKE

Some of the accounts are subject to periodic Nuking via [aws-nuke](https://github.com/ekristen/aws-nuke).
This is handled via a GitHub Action that runs on a schedule and can be triggered manually.

### Access Configuration
For this to work, the GitHub aciton uses OIDC to get access to an ops role.  The Ops role is granted access to the various accounts subject to nuke via another assume-role done by the reusable workflow.  

---
## Security Scanning
I've set up a GitHub Action to run [Checkmarx's KICS](https://checkmarx.com/product/opensource/kics-open-source-infrastructure-as-code-project/) tool against the Terraform code.  This is run on a Cron schedule, and on PR creation and updates.  The PR runs only update the PR conversation with the results in Markdown.  The Scheduled runs upload the SARIF file so that findings will be in the `Security` tab of the repo.## Requirements

---
## Terraform
The Terraform for the org and accounts sets up OUs and accounts within them. Like the nuke action, OIDC is used to access the Org master account to do the required work. The Layout of the OUs and accounts is generally flat, with each OS sitting as peers to each other, and accounts falling into one of the OUs.  This allows me to have a Terraform Map specifying the OUs and their accounts. The Terraform code uses `for` and `for_each` clauses to build the OUs and Accounts. 

The general layout of the `organizations` variable is:
```
{
  "ou_1_name" : {
    "name" : "Text Name of OU",
    "accounts" : [
      {
        "name" : "Account 1 Name",
        "email" : "account1@email.address",
        "iam_user_access_to_billing" : "ALLOW",
      },
      {
        "name" : "Account 2 Name",
        "email" : "account2@email.address"
      }
    ]
  },
  "ou_2_name" : {
    "name" : "Text Name of OU 2",
    "accounts" : [
      {
        "name" : "Account 3 Name",
        "email" : "account3@email.address",
      },
      {
        "name" : "Account 4 Name",
        "email" : "account4@email.address"
      },
    ]
  }
}
```
This variable is stored in an AWS Parameter Store SecureString base64 encoded.  That made it easier to get around some string quoting issues in the manipulation done in the GitHub Actions that manage running Terraform Plan and Apply.

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.11.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

### Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.97.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [aws_organizations_account.accounts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_account) | resource |
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organization) | resource |
| [aws_organizations_organizational_unit.ous](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit) | resource |
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_organization"></a> [organization](#input\_organization) | The Map of the Organization.  It is a map with an account list and an ou list in it. | `map(any)` | n/a | yes |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_organization_account_arns_map"></a> [organization\_account\_arns\_map](#output\_organization\_account\_arns\_map) | Map of ARNs of the Accounts |
| <a name="output_organization_account_ids_map"></a> [organization\_account\_ids\_map](#output\_organization\_account\_ids\_map) | Map of ARNs of the Accounts |
| <a name="output_organization_arn"></a> [organization\_arn](#output\_organization\_arn) | ARN of the Organization |
| <a name="output_organization_id"></a> [organization\_id](#output\_organization\_id) | ID of the Organization |
| <a name="output_organization_ou_arns_map"></a> [organization\_ou\_arns\_map](#output\_organization\_ou\_arns\_map) | Map of ARNs of the OUs |
| <a name="output_organization_ou_ids_map"></a> [organization\_ou\_ids\_map](#output\_organization\_ou\_ids\_map) | Map of IDs of the OUs |
