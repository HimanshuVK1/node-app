resource "aws_ecr_repository" "my_ecr_repo" {
  name                 = "ecrrepo"
  image_tag_mutability = "MUTABLE"  # or "IMMUTABLE" based on your requirement
  image_scanning_configuration {
    scan_on_push = true
  }
}