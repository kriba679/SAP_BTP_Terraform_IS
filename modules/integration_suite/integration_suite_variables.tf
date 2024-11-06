variable "subaccount_id" {
  type        = string
  description = "The subaccount ID."
}

variable "integration_suite_admins" {
  type        = list(string)
  description = "Defines the colleagues who are admins for Integration Suite."
}
