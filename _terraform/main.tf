
resource "null_resource" "registry_login" {
  provisioner "local-exec" {
    command = "aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${local.target_registry}"
  }
}

resource "null_resource" "build_image" {
  triggers = {
    order = null_resource.registry_login.id
  }

  provisioner "local-exec" {
    command = "docker build -t ${local.repository_url}:${var.image_tag} ${path.root}/.."
  }
}

resource "null_resource" "push_image" {
  triggers = {
    order = null_resource.build_image.id
  }

  provisioner "local-exec" {
    command = "docker push ${local.repository_url}:${var.image_tag}"
  }
}

resource "null_resource" "registry_logout" {
  triggers = {
    order = null_resource.push_image.id
  }

  provisioner "local-exec" {
    command = "docker logout ${local.target_registry}"
  }
}

module "ecr" {
  source = "terraform-aws-modules/ecr/aws"

  repository_name = var.ecr_name
  create_repository_policy = false
  attach_repository_policy = false

  repository_read_write_access_arns = ["arn:aws:iam::012345678901:role/terraform"]
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })
}

module "lambda_function_container_image" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "${var.lambda_name}"
  description   = "${var.lambda_description}"

  create_package = false

  image_uri    = "${local.repository_url}:${var.image_tag}"
  package_type = "Image"

  depends_on = [null_resource.push_image]
}