data "archive_file" "packaging" {
  type        = var.packaging_type
  source_file = var.source_file
  output_path = var.output_path
}

resource "aws_lambda_function" "function" {
  description = var.function_description

  filename      = data.archive_file.packaging.output_path
  function_name = var.function_name
  role          = var.function_role_arn
  handler       = var.handler

  source_code_hash = filebase64sha256(data.archive_file.packaging.output_path)

  runtime                        = var.function_runtime
  memory_size                    = var.function_memory_size
  reserved_concurrent_executions = var.function_reserved_concurrent_executions

  dynamic tags {
    for_each = var.function_tags == null ? [] : [var.function_tags]
    content {
      tags = function_tags.value.tags
    }
  }

  dynamic environment {
    for_each = var.function_environment == null ? [] : [var.function_environment]
    content {
      variables = environment.value.variables
    }
  }
}

resource "aws_cloudwatch_event_rule" "trigger_function" {
  name          = var.event_name
  description   = var.event_description
  event_pattern = ""
  is_enabled    = var.is_event_enabled
}

resource "aws_lambda_permission" "allow_cloudwatch_event" {
  statement_id  = "AllowExecutionFromCloudWatchEvent"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.function.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.trigger_function.arn
}

resource "aws_cloudwatch_event_target" "cloudwatch_event_target_function" {
  rule = aws_cloudwatch_event_rule.trigger_function.name
  arn  = aws_lambda_function.function.arn
}

resource "aws_cloudwatch_log_group" "lambda_event_emr_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.function.function_name}"
  retention_in_days = var.log_retention_days
}
