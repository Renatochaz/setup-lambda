variable "ecr_name" {
  description = "Name of the ECR private repository."
  type        = string
}

variable "region" {
  description = "AWS Region."
  type        = string
}

variable "image_tag" {
  description = "Tag of the image to be deployed"
  type = string
}

variable "lambda_name" {
  description = "Name of the Lambda function"
  type = string
}

variable "lambda_description" {
  description = "Description of the Lambda function"
  type = string
}