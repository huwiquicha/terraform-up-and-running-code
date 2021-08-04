terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = "us-east-2"

  # Allow any 2.x version of the AWS provider
  version = "~> 2.0"
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

 // This is only here so we can destroy the bucket as part of automated tests. You should not copy this for production
 // usage
 force_destroy = true
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