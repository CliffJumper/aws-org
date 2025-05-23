# AWS Organizations Configuration
# Manages the AWS Organization structure including OUs and member accounts

# Disable KICS rule on IAM Access Analyzer because we don't use it.
# kics-scan disable=e592a0c5-5bdb-414c-9066-5dba7cdea370

resource "aws_organizations_organization" "org" {
  feature_set = "ALL"

  aws_service_access_principals = [
    "member.org.stacksets.cloudformation.amazonaws.com",
    "sso.amazonaws.com"
  ]

  enabled_policy_types = [
    "SERVICE_CONTROL_POLICY",
    "RESOURCE_CONTROL_POLICY",
    "DECLARATIVE_POLICY_EC2",
    "TAG_POLICY"
  ]

  lifecycle {
    prevent_destroy = true # Prevent accidental organization deletion
  }
}

data "aws_organizations_organization" "org" {}

resource "aws_organizations_organizational_unit" "ous" {
  for_each = local.ous

  name      = each.value.name
  parent_id = data.aws_organizations_organization.org.roots[0].id

  tags = merge(
    var.tags,
    {
      Name            = each.value.name
      aws-nuke-exempt = true
    }
  )

  lifecycle {
    prevent_destroy = true # Prevent accidental OU deletion
  }
}

resource "aws_organizations_account" "accounts" {
  for_each  = { for i, j in local.accounts : j.name => j }
  name      = each.value.name
  email     = each.value.email
  parent_id = aws_organizations_organizational_unit.ous[each.value.org_name].id

  iam_user_access_to_billing = "ALLOW"
  close_on_deletion          = false # Prevent accidental account deletion

  tags = merge(
    var.tags,
    {
      Name            = each.value.name
      OwnerEmail      = each.value.email
      aws-nuke-exempt = true
    }
  )

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      role_name, # Ignore changes to role_name after creation
      iam_user_access_to_billing
    ]
  }
}
