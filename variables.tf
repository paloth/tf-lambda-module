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

### Lambda trigger variables
