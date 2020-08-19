terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile = var.profile
  region  = var.region
}

resource "aws_s3_bucket" "problem-bucket" {
  bucket = var.domain_name
  acl    = "public-read"
  policy = data.aws_iam_policy_document.website_policy.json

  website {
    index_document = "index.html"
    error_document = "error.html"

    routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": "documents/"
    }
}]
EOF
  }
}

resource "aws_s3_bucket_object" "index" {
  bucket = var.domain_name
  key = "index.html"
  source = "index.html"
  content_type = "text/html"
  etag = filemd5("index.html")
}

resource "aws_s3_bucket_object" "error" {
  bucket = var.domain_name
  key = "error.html"
  source = "error.html"
  content_type = "text/html"
  etag = filemd5("error.html")
}
