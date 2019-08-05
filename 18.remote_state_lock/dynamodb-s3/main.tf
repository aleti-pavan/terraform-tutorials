provider "aws" {
  version    = "v2.17.0"
  region     = "us-east-1"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

resource "random_pet" "server" {
  length = 2
}

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name           = "${random_pet.server.id}-ter-state"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags {
    Name = "DynamoDB Terraform State Lock Table"
  }
}

resource "aws_s3_bucket" "bucket" {
  bucket = "${random_pet.server.id}-ter-state"
  acl    = "private"

  versioning {
    enabled = true
  }
}

output "s3_url" {
  value = "${aws_s3_bucket.bucket.id}"
}

output "dynamodb_table" {
  value = "${aws_dynamodb_table.dynamodb-terraform-state-lock.id}"
}
