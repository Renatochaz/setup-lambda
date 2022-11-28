output "ecr_repository_url" {
  description = "The URL of the repository (in the form `aws_account_id.dkr.ecr.region.amazonaws.com/repositoryName`)"
  value       = module.ecr.repository_url
}

output "lambda_arn" {
  description = "ARN of the Lamda function."
  value       = module.lambda_function_container_image.lambda_function_arn
}

output "current_image_tag" {
  description = "Current TAG of the deployed image."
  value       = var.image_tag
}