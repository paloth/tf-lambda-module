variable "region" {
  type    = string
  default = "eu-west-1"
}

### Lambda function variables
variable "description" {
  type    = string
  default = null
}

variable "filename" {
  type    = string
  default = null
}

variable "function_name" {
  type = string
}

variable "lambda_role_arn" {
  type = string
}

variable "handler" {
  type = string
}

variable "runtime" {
  type = string
}

variable "reserved_concurrent_executions" {
  type    = number
  default = -1
}

variable "lambda_memory_size" {
  description = "Memory size for the Lambda function."
  type        = number
  default     = 128
}

variable "environment" {
  description = "List of lambda's environment variables"
  type = object({
    variables = map(string)
  })
  default = null
}

### Packaging variables

variable "packaging_type" {
  description = "The type of the lambda packaging (default is zip)"
  type        = string
  default     = "zip"
}

variable "source_dir" {
  description = "Path to the directory to package"
  type        = string
  default     = null
}

variable "output_path" {
  description = "Path to the packaged file with extension"
  type        = string
  default     = null
}

### Lambda trigger variables

### Log variables

variable "log_retention_days"{
  description = "Number of log retention days"
  type = number
  default = 14
}