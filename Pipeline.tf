resource "aws_codepipeline" "bar" {
  name     = "tf-test-pipeline"
  role_arn = var.codepipeline_service_arn

  artifact_store {
    location = aws_s3_bucket.terraformed-bucket.id
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["mysite"]

      configuration = {
        Owner                = "${var.repo_owner}"
        Repo                 = "mysite"
        OAuthToken           = "${var.oauth_token}"
        Branch               = "master"
        PollForSourceChanges = "${var.poll_source_changes}"

      }
    }
  }


  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["mysite"]
      output_artifacts = ["mysite_built"]
      version          = "1"

      configuration = {
        ProjectName   = aws_codebuild_project.CodeBuild.name
        PrimarySource = "mysite_built"

      }
    }
  }
}
