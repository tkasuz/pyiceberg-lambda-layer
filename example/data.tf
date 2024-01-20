data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_lambda_layer_version" "pyiceberg" {
  layer_name = "pyiceberg"
}
