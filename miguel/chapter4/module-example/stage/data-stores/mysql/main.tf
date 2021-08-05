terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = "us-east-2"

}

terraform {
  backend "s3" {
    # This backend configuration is filled in automatically at test time by Terratest. If you wish to run this example
    # manually, uncomment and fill in the config below.

    bucket              = "miguel-terraform-states"
    region              = "us-east-2"
    dynamodb_table      = "miguel_terraform_locks"
    key                 = "stage/data-stores/mysql/terraform.tfstate"
    encrypt             = true

  }
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-up-and-running"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  name                = var.db_name
  username            = "admin"
  password            = var.db_password
  skip_final_snapshot = true
}
