data "archive_file" "packaging" {
  type        = var.packaging_type
  source_dir  = var.archive_source_dir
  output_path = var.archive_output_path
}

resource "aws_s3_bucket_object" "upload_lambda" {
  bucket = var.src_bucket_name
  key    = "lambda_function/${var.src_key}"
  source = data.archive_file.packaging.output_path
  etag   = filemd5(data.archive_file.packaging.output_path)
}

resource "aws_lambda_function" "function" {
  description   = var.function_description
  s3_bucket     = var.src_bucket_name
  s3_key        = aws_s3_bucket_object.upload_lambda.key
  function_name = replace(var.function_name, "_", "-")
  role          = var.function_role_arn
  handler       = "${var.function_filename}.${var.function_handler}"

  source_code_hash = filebase64sha256(data.archive_file.packaging.output_path)

  runtime                        = var.function_runtime
  memory_size                    = var.function_memory_size
  reserved_concurrent_executions = var.function_reserved_concurrent_executions
  timeout                        = var.function_timeout

  tags = var.function_tags

  environment {
    variables = var.function_environment
  }
}

resource "aws_cloudwatch_event_rule" "trigger_function" {
  count               = title(var.execution_source) == "Event" ? 1 : 0
  name                = var.event_name
  description         = var.event_description
  event_pattern       = var.event_pattern
  schedule_expression = var.schedule_expression
  is_enabled          = var.is_event_enabled
}

resource "aws_lambda_permission" "allow_cloudwatch_event" {
  count         = title(var.execution_source) == "Lambda" ? 0 : 1
  statement_id  = "AllowExecutionFrom${title(var.execution_source)}"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.function.function_name
  principal     = var.principal_source[title(var.execution_source)]
  source_arn    = aws_cloudwatch_event_rule.trigger_function[0].arn
}

resource "aws_cloudwatch_event_target" "cloudwatch_event_target_function" {
  count = title(var.execution_source) == "Event" ? 1 : 0
  rule  = aws_cloudwatch_event_rule.trigger_function[0].name
  arn   = aws_lambda_function.function.arn
}

resource "aws_cloudwatch_log_group" "function_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.function.function_name}"
  retention_in_days = var.log_retention_days
}
