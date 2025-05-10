
output "organization_arn" {
  value       = aws_organizations_organization.org.arn
  description = "ARN of the Organization"
}

output "organization_id" {
  value       = aws_organizations_organization.org.id
  description = "ID of the Organization"
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
  description = "Map of ARNs of the Accounts"
}

