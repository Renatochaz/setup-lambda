locals {
  target_registry = split("/", module.ecr.repository_url)[0]
  repository_url = module.ecr.repository_url
}