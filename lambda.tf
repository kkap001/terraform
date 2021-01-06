resource "aws_lambda_function" "LambdaFunction" {
    filename = "invalidate_lambda.zip"
    function_name = "invalidatelambda"
    handler = "lambda_function.lambda_handler"
    memory_size = 128
    role = "${aws_iam_role.tfinvalidaterole.arn}"
    runtime = "python3.7"
    timeout = 3
    tracing_config {
        mode = "PassThrough"
    }
}

resource "aws_iam_role" "IAMRole" {
    path = "/service-role/"
    name = "cloudfrontrole_Access"
    assume_role_policy = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"lambda.amazonaws.com\"},\"Action\":\"sts:AssumeRole\"}]}"
    max_session_duration = 3600
}

resource "aws_iam_role" "tfinvalidaterole" {
  name = "aws_iam_role.tfinvalidaterole"
  max_session_duration = 3600
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "tf_invalidatepolicy" {
  name = "tf_invalidatepolicy"
  role = aws_iam_role.tfinvalidaterole.id


  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "cloudfront:CreateInvalidation"
      ],
       "Resource": "*"
    }
  ]
}
EOF
}