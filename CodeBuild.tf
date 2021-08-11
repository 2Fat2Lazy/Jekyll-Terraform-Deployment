resource "aws_codebuild_project" "CodeBuild" {
  name          = "mysite-terraform"
  description   = "My Website Build Project."
  build_timeout = "15"
  service_role  = var.codebuild_service_arn

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL" #Uses smallest 'free tier' elegable compute type
    image                       = "aws/codebuild/standard:1.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }

  source {
    type            = "GITHUB"
    location        = var.git_URL
    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = true
    }
  }
}