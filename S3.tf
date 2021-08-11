resource "aws_s3_bucket" "terraformed-bucket" {
  bucket = var.artifact_bucket_name
  acl    = var.artifact_bucket_acl

  tags = {
    Name = "<Tag for your artifact S3 bucket>"
  }
}

resource "aws_s3_bucket" "my-site" {
  bucket = var.web_bucket_name
  acl    = "public-read"       #Required for public access
  policy = file("policy.json") #See policy.json and change to represent your S3 resource

  website {
    index_document = var.index_loc #See variables.tfvars
    error_document = var.error_loc #See variables.tfvars
  }

  tags = {
    Name = "<Tag for your website bucket>"
  }
}

