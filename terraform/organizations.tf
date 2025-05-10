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
}

data "aws_organizations_organization" "org" {}

resource "aws_organizations_organizational_unit" "ous" {
  for_each = local.ous

  name      = each.value.name
  parent_id = data.aws_organizations_organization.org.roots[0].id
}


resource "aws_organizations_account" "accounts" {
  for_each = { for i, j in local.accounts : j.name => j }

  name      = each.value.name
  email     = each.value.email
  parent_id = aws_organizations_organizational_unit.ous[each.value.org_name].id
  tags      = try(each.value.tags, {})
}

