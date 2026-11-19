# prefix will be prepended to all resource names
variable "prefix" {
  type    = string
  description = "set in variables.tfvars"
}

# description of the function
variable "description" {
  type    = string
  description = "set in variables.tfvars"
}

# FunctionGraph: Function name
variable "function_name" {
  type    = string
  description = "set in variables.tfvars"
}

variable "handler_name" {
  type    = string
  description = "set in variables.tfvars"
}

# Resource tag:
variable "tag_app_group" {
  type    = string
  description = "set in variables.tfvars"
}

variable "SMN_ENDPOINT" {
  type    = string
  description = "set in variables.tfvars"
}

variable "SMN_EMAIL_ADDRESS" {
  type    = set(string)
  description = "set in variables.auto.tfvars"
}

variable "IP_RANGES_WHITELIST" {
  type    = set(string)
  description = "set in variables.auto.tfvars"
}

variable "TEST_USER_NAME" {
  type    = string
  description = "set in variables.auto.tfvars"
}

variable "TEST_USER_ID" {
  type    = string
  description = "set in variables.auto.tfvars"
}

variable "TEST_ALLOWED_SOURCE_IP" {
  type    = string
  description = "set in variables.auto.tfvars"
}
variable "TEST_DENIED_SOURCE_IP" {
  type    = string
  description = "set in variables.auto.tfvars"
}

