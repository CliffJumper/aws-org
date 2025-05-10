locals {

  accounts = flatten([
    for i, j in var.organization :
    [
      for k, v in j.accounts : {
        name                       = v.name
        org_name                   = j.name
        parent_name                = i
        email                      = v.email
        iam_user_access_to_billing = try(v.iam_user_access_to_billing, "ALLOW")
        tags                       = try(v.tags, {})
      }
    ]
  ])

  ous = { for i in var.organization : i.name => {
    name = i.name
    tags = try(i.tags, {})
    }
  }
}
