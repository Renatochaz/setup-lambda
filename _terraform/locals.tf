locals {
  target_registry  = split("/", module.ecr.repository_url)[0]
  repository_url   = module.ecr.repository_url
  image_tag_exists = tobool(data.external.image_tag_exists.result["image_tag_exists"])
}