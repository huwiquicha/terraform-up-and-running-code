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