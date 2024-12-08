terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.16"
    }
  }
  required_version = ">= 1.3"
}
 
provider "aws" {
  region = "${var.region}"
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "cip_extraction_assets" {
  bucket = "${var.prefix}-${var.bucket_name}"
  lifecycle {
    prevent_destroy = false
  }

  tags = var.tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.cip_extraction_assets.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

resource "aws_s3_bucket_policy" "cip_extraction_assets_policy" {
  bucket = aws_s3_bucket.cip_extraction_assets.bucket

  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action    = "s3:*"
        Effect    = "Deny"
        Principal = {
          AWS = "*"
        }
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
        Resource = [
          "${aws_s3_bucket.cip_extraction_assets.arn}",
          "${aws_s3_bucket.cip_extraction_assets.arn}/*"
        ]
      }
    ]
  })
}

#resource "aws_s3_object" "object_upload" {
 # bucket = aws_s3_bucket.cip_extraction_assets.bucket
 # source = "${path.module}/objects/testing/my-object.txt"
 # key    = "testing/my-object.txt"
  #acl    = "private"
#}