variable "user_names" {
    type = list(string)
    default = ["neo","trinity","morpheus"]
    description = "The list of username"
}

variable "custom_tags" {
    description = "Custom tags to set on the Instances in the ASG"
    type = map(string)
    default = {
        "Owner" = "team-foo"
        "DebployedBy" = "terraform"
    }
}
variable "policy_name_prefix" {
  description = "The prefix to use for the IAM policy names"
  type        = string
  default     = ""
}

variable "give_neo_cloudwatch_full_access" {
    description = "If true, neto gets full access to Cloudwatch"
    type = bool
}