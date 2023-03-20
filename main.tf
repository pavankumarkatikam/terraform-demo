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

  provisioner "local-exec" {
    command = "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${aws_ecr_repository.app_ecr_repo.repository_url}"
  }

  provisioner "local-exec" {
    command = "docker build -t myproject ../"
  }
  provisioner "local-exec" {
    command = "docker tag myproject:latest ${aws_ecr_repository.app_ecr_repo.repository_url}/myproject:latest"
  }
  provisioner "local-exec" {
    command = "docker push ${aws_ecr_repository.app_ecr_repo.repository_url}/myproject:latest"
  }
  
}


output "name" {
    value = aws_ecr_repository.app_ecr_repo.repository_url
}
