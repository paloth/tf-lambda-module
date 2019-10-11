resource "aws_lambda_function" "function" {
  description = var.description

  filename      = var.filename
  function_name = var.function_name
  role          = var.lambda_role_arn
  handler       = var.handler

  source_code_hash = filebase64sha256(var.filename)

  runtime                        = var.runtime
  memory_size                    = var.lambda_memory_size
  reserved_concurrent_executions = var.reserved_concurrent_executions

  dynamic environment {
    for_each = var.environment == null ? [] : [var.environment]
    content {
      variables = environment.value.variables
    }
  }
}
