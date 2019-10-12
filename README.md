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

## Resources needed

1. Lambda
2. CloudWatch LogGroup
3. CloudWatch Event
4. Iam Role

## Inputs

### Mandatories Inputs

```terraform
module "lambda" {
  source = "../tf-lambda-module"

  archive_source_file = "./test.py"
  archive_output_path = "./test.zip"

  function_description = "this is a test"
  function_name        = "test"
  function_role_arn    = "arn:aws:iam::791927302548:role/run_job_dev_lambda_zappa"
  function_filename    = "test"

  function_environment = { test = "value", other = "value2", another = "one" }
  function_tags        = { Mytag = "lol" }

  event_name        = "test"
  event_description = "test descr"
}
```

### Optional Inputs

TBD

## Outputs

1. Lambda Arn
2. Lambda Name
