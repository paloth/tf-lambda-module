# tf-lambda-module

Terraform lambda module

This is a module to create lambda with terraform
Terraform version 0.12

## To do

- [x] Create files
- [x] Write module
  - [x] Define variables
  - [x] Define outputs
  - [x] Define resources
- [ ] Improve module
  - [ ] Conditional event trigger
  - [ ] Add layer
  - [ ] Add error handling
- [x] Test module
- [ ] Document the module
  - [ ] Inputs
  - [ ] Outputs
  - [x] Example

## Resources needed

1. Lambda
2. CloudWatch LogGroup
3. CloudWatch Event
4. Iam Role

## Inputs

### Mandatories Inputs

TBD

### Optional Inputs

TBD

## Outputs

1. Lambda Arn
2. Lambda Name

### Example

```terraform
module "lambda" {
  source = "../tf-lambda-module"

  archive_source_file = "./file_name.py"
  archive_output_path = "./archive_name.zip"

  function_description = "Function Description"
  function_name        = "Function-Name"
  function_role_arn    = "arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME}"
  function_filename    = "file_name"

  function_environment = { var1 = "value1", var2 = "value2", var3 = "value3" }
  function_tags        = { key1 = "TagValue1", key2 = "TagValue2" }

  event_name        = "event_name"
  event_description = "Event description"
}
```
