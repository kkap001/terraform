resource "aws_s3_bucket" "angularbucketfor" {
  bucket = "tangclnumerbucket"
  acl    = "private"
  force_destroy = true

  tags = {
     Key  = "distributionId"
     value = "ECJ14GYA8GB67"
  }
 versioning {
    enabled = true
  }
}
resource "aws_codebuild_project" "example" {
  depends_on = [
    aws_s3_bucket.angularbucketfor
  ]
  name          = "test-project"
  description   = "test_codebuild_project"
  build_timeout = "5"
  service_role  = "aws_iam_role.cbrole"
  
  artifacts {
    type = "S3"
    name = "code"
    namespace_type = "NONE"
    location = "tangclnumerbucket"
    packaging = "NONE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "angular"
      value = "20"
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "log-group"
      stream_name = "log-stream"
    }
  }

  source {
    type            = "CODECOMMIT"
    location        = "https://git-codecommit.ap-south-1.amazonaws.com/v1/repos/angularcase"
    git_clone_depth = 1
    git_submodules_config {
      fetch_submodules = true
    }
  }
}