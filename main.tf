terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.45.0"
    }
  }
}


resource "aws_ecr_repository" "app_ecr_repo" {
  name = "app-repo"

  command = "export REPOSITORY_URL=${aws_ecr_repository.app_ecr_repo.repository_url}"
  
}


output "name" {
    value = aws_ecr_repository.app_ecr_repo.repository_url
}
