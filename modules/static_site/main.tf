terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
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
  key = var.index_file
  source = var.index_file
  content_type = "text/html"
  etag = filemd5(var.index_file)
  depends_on = [
    aws_s3_bucket.problem-bucket,
  ]
}

resource "aws_s3_bucket_object" "error" {
  bucket = var.domain_name
  key = var.error_file
  source = var.error_file
  content_type = "text/html"
  etag = filemd5(var.error_file)
  depends_on = [
    aws_s3_bucket.problem-bucket,
  ]
}
