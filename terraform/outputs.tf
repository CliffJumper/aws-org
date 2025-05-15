output "organization_arn" {
  value       = aws_organizations_organization.org.arn
  description = "ARN of the Organization"
}

output "organization_id" {
  value       = aws_organizations_organization.org.id
  description = "ID of the Organization"
}

output "organization_root_id" {
  value       = data.aws_organizations_organization.org.roots[0].id
  description = "ID of the Organization Root"
}

output "organization_root_arn" {
  value       = data.aws_organizations_organization.org.roots[0].arn
  description = "ARN of the Organization Root"
}

output "organization_ou_ids_map" {
  value = {
    for k, v in aws_organizations_organizational_unit.ous : k => v.id
  }
  description = "Map of IDs of the OUs"
}

output "organization_ou_arns_map" {
  value = {
    for k, v in aws_organizations_organizational_unit.ous : k => v.arn
  }
  description = "Map of ARNs of the OUs"
}

output "organization_account_arns_map" {
  value = {
    for k, v in aws_organizations_account.accounts : k => v.arn
  }
  description = "Map of ARNs of the Accounts"
}

output "organization_account_ids_map" {
  value = {
    for k, v in aws_organizations_account.accounts : k => v.id
  }
  description = "Map of IDs of the Accounts"
}

output "organization_account_emails_map" {
  value = {
    for k, v in aws_organizations_account.accounts : k => v.email
  }
  description = "Map of email addresses of the Accounts"
}

output "organization_account_parent_ous" {
  value = {
    for k, v in aws_organizations_account.accounts : k => v.parent_id
  }
  description = "Map of parent OU IDs for each account"
}

