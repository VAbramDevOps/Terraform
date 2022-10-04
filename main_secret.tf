terraform {
  backend "s3" {
    bucket = "bucket_name"
    key = "terraform/project/terraform.tfstate"
    region = "us-east-1"
  }
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}
 
resource "aws_secretsmanager_secret" "secretDB" {
   name = "my-test-secret-terraform"
   description = "My first secret via Terraform"
}
 
resource "aws_secretsmanager_secret_version" "sversion" {
  secret_id = aws_secretsmanager_secret.secretDB.id
  secret_string = <<EOF
   {
    "username": "admin",
    "password": "${random_password.password.result}"
   }
EOF
}
 
data "aws_secretsmanager_secret" "secretDB" {
  arn = aws_secretsmanager_secret.secretDB.arn
}
 
data "aws_secretsmanager_secret_version" "creds" {
  secret_id = data.aws_secretsmanager_secret.secretDB.arn
}
 
locals {
  db_creds = jsondecode(data.aws_secretsmanager_secret_version.creds.secret_string)
}