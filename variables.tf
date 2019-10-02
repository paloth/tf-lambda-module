### Lambda function variables
variable "filename" {
  type    = string
  default = null
}

variable "function_name" {
  type = string
}

variable "handler" {
  type = string
}

variable "lambda_memory_size" {
  description = "Memory size for the Lambda function."
  type        = number
  default     = 128
}

variable "environment" {
  type = object({
    variables = map(string)
  })
  default = null
}

### Lambda trigger variables
