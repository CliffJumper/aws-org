variable "organization" {
  type        = map(any)
  description = "The Map of the Organization.  It is a map with an account list and an ou list in it."
}

variable "tags" {
  description = "Default tags to apply to all resources"
  type        = map(string)
  default     = {}
}
