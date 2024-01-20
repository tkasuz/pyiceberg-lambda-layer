module "lambda_function" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "6.8.0"

  function_name            = "pyiceberg-test"
  handler                  = "index.lambda_handler"
  runtime                  = "python3.12"
  architectures            = ["x86_64"]
  recreate_missing_package = false
  ignore_source_code_hash  = true
  timeout                  = 30
  publish                  = true
  source_path              = "${path.module}/lambdas/index.py"
  create_role              = false
  lambda_role              = aws_iam_role.this.arn

  layers = [
    "arn:aws:lambda:${data.aws_region.current.name}:017000801446:layer:AWSLambdaPowertoolsPythonV2:60",
    data.aws_lambda_layer_version.pyiceberg.arn
  ]

  environment_variables = {
    DATABASE = aws_glue_catalog_database.this.name
    TABLE    = aws_glue_catalog_table.this.name
  }
}
