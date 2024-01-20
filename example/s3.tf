resource "aws_s3_bucket" "this" {
  bucket        = "pyiceberg-${random_string.this.id}-bucket"
  force_destroy = true
}

resource "random_string" "this" {
  length           = 30
  upper            = false
  lower            = true
  special          = true
  override_special = ".-"
}
