data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}
data "external" "image_tag_exists" {
  program = ["python", "${path.root}/src/verifier.py"]
  query = {
    ecr_name  = var.ecr_name
    image_tag = var.image_tag
  }
}