### Lambda function variables

## Function variables

variable "function_description" {
  type    = string
  default = null
}

variable "src_bucket_name" {
  type    = string
  default = null
}

variable "src_key" {
  type    = string
  default = null
}

variable "function_filename" {
  type    = string
  default = null
}

variable "function_name" {
  type = string
}

variable "function_role_arn" {
  type = string
}

variable "function_handler" {
  type    = string
  default = "handler"
}

## Function config variables

variable "function_runtime" {
  type    = string
  default = "python3.7"
}

variable "function_reserved_concurrent_executions" {
  type    = number
  default = -1
}

variable "function_memory_size" {
  description = "Memory size for the Lambda function"
  type        = number
  default     = 128
}

variable "function_timeout" {
  description = "Set the function timeout"
  type        = number
  default     = 900
}

variable "function_tags" {
  description = "List of tags to attach to the function"
  type        = map
  default     = {}
}

variable "function_environment" {
  description = "List of lambda's environment variables"
  type        = map
  default     = {}
}

### Packaging variables

variable "packaging_type" {
  description = "The type of the lambda packaging (default is zip)"
  type        = string
  default     = "zip"
}

variable "archive_source_dir" {
  description = "Path to the directory to package"
  type        = string
  default     = null
}

variable "archive_output_path" {
  description = "Path to the packaged file with extension"
  type        = string
  default     = null
}

### Lambda Execution variables
variable "execution_source" {
  description = "Source of the lamabda execution"
  default     = "Event"
  type        = string
}

variable "principal_source" {
  description = "Principal of the execution source"
  type        = map
  default = {
    Event      = "events.amazonaws.com"
    Sqs        = "sqs.amazonaws.com"
    Sns        = "sns.amazonaws.com"
    ApiGateWay = "apigateway.amazonaws.com"
    S3         = "s3.amazonaws.com"
    Lambda     = "lambda.amazonaws.com"
  }
}

### CloudWatch event variables

variable "event_name" {
  description = "Name of the event to trigger the function"
  type        = string
  default     = ""
}

variable "event_description" {
  description = "Description of the event to trigger the function"
  type        = string
  default     = ""
}

variable "is_event_enabled" {
  description = "Bool to activate or deactivate the lambda trigger"
  type        = bool
  default     = true
}

variable "event_pattern" {
  description = "Event pattern described a JSON object"
  type        = any
  default     = ""
}

variable "schedule_expression" {
  description = "Schedule expression formatted by cron expression or rate"
  type        = string
  default     = ""
}

### Log variables

variable "log_retention_days" {
  description = "Number of log retention days"
  type        = number
  default     = 14
}
