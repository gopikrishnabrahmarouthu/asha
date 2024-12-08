module "aws-s3" {
  source = "./aws-s3"

  bucket = "module.aws-s3.bucket"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}