resource "aws_ecr_repository" "flask_repo" {
  name = "flask-k8s-demo"

  image_tag_mutability = "IMMUTABLE" # Prevent image tags from being overwritten
  force_delete = true # Allow deletion of repository even if it contains images

  image_scanning_configuration {
    scan_on_push = true
  }
}

# Keep only the latest 3 images, expire older
resource "aws_ecr_lifecycle_policy" "flask_repo_policy" {
  repository = aws_ecr_repository.flask_repo.name

  policy = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Keep last 3 images",
      "selection": {
        "tagStatus": "any",
        "countType": "imageCountMoreThan",
        "countNumber": 3
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}
