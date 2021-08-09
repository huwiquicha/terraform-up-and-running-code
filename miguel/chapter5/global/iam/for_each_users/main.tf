provider "aws" {
    region = "us-east-2"
}

resource "aws_iam_user" "example" {
    for_each = toset(var.user_names)
    name = each.value

    #tags = var.custom_tags
    tags = {for k,v in var.custom_tags: upper(k)=>upper(v)} #similar to line before
    
}