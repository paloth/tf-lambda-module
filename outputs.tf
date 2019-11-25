output "function_name" {
  value = aws_lambda_function.function.function_name
}

output "function_arn" {
  value = aws_lambda_function.function.arn
}

output "function_log_group" {
  value = aws_cloudwatch_log_group.function_log_group.name
}

output "function_log_group_arn" {
  value = aws_cloudwatch_log_group.function_log_group.arn
}
