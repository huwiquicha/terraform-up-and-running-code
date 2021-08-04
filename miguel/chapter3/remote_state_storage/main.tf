/*terraform {
  backend "s3" {
    bucket              = "miguel-terraform-states"
    region              = "us-east-2"
    dynamodb_table      = "miguel_terraform_locks"
    key                 = "miguel-example-chapter3/terraform.tfstate"
    encrypt             = true
  }
}*/

provider "aws" {
  region          = "us-east-2"
}

resource "aws_s3_bucket" "terraform_state" {
 bucket           = var.bucket_name

 #Prevent accidental deletion of this S3 bucket
 lifecycle {
  prevent_destroy         = false
 }

 #Enable Versioning so we can see the full revision history of state files
 versioning {
  enabled = true
 }

 server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
      }
    }
 }

 force_destroy      = true
}

resource "aws_dynamodb_table" "terraform_locks" {
  name             = var.table_name
  hash_key         = "LockID"
  billing_mode     = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}