data "aws_iam_policy" "ssm_parameter_policy" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
}

data "aws_iam_policy" "code_deploy_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy"
}

resource "aws_iam_user" "pi_user" {
    name      = "pi"
    path      = "/"
    tags      = {}
    tags_all  = {}
}

resource "aws_iam_policy" "pi_dynamodb_put_policy" {
    description = "Defines access for Raspberry Pi board to put data into DynamoDB table"
    name        = "Put_DynamoDB_Policy"
    path        = "/"
    policy      = jsonencode(
        {
            Statement = [
                {
                    Action   = [
                        "dynamodb:PutItem",
                        "dynamodb:ListTables",
                    ]
                    Effect   = "Allow"
                    Resource = "*"
                    Sid      = "VisualEditor0"
                },
            ]
            Version   = "2012-10-17"
        }
    )
    tags        = {}
    tags_all    = {}
}

resource "aws_iam_user_policy" "dynamo_policy_attachement" {
  name = "Raspberry_Pi_policy_attachement_for_tables"
  user = aws_iam_user.pi_user.name
  policy = aws_iam_policy.pi_dynamodb_put_policy.policy
}

resource "aws_iam_policy" "sns_door_sensor_policy" {
    description = "Push notification for door sensor"
    name        = "Publish_SNS_Notification_Door_Sensor"
    path        = "/"
    policy      = jsonencode(
        {
            Statement = [
                {
                    Action   = "sns:Publish"
                    Effect   = "Allow"
                    Resource = aws_sns_topic.door_sensor_topic.arn
                    Sid      = "VisualEditor0"
                },
            ]
            Version   = "2012-10-17"
        }
    )
    tags        = {}
    tags_all    = {}
}

resource "aws_iam_user_policy" "sns_policy_attachement" {
  name = "Publish_SNS_Notification_Door_Sensor"
  user = aws_iam_user.pi_user.name
  policy = aws_iam_policy.sns_door_sensor_policy.policy
}

resource "aws_iam_user_policy" "ssm_policy_attachement" {
  name = "AmazonSSMReadOnlyAccess"
  user = aws_iam_user.pi_user.name
  policy = data.aws_iam_policy.ssm_parameter_policy.policy
}

resource "aws_iam_user_policy" "code_deploy_policy_attachement" {
  name = "AmazonEC2RoleforAWSCodeDeploy"
  user = aws_iam_user.pi_user.name
  policy = data.aws_iam_policy.code_deploy_policy.policy
}

resource "aws_iam_role" "raspberry_code_deploy_role" {
    assume_role_policy    = jsonencode(
        {
            Statement = [
                {
                    Action    = "sts:AssumeRole"
                    Effect    = "Allow"
                    Principal = {
                        Service = "codedeploy.amazonaws.com"
                    }
                    Sid       = ""
                },
            ]
            Version   = "2012-10-17"
        }
    )
    description           = "Allows CodeDeploy to call AWS services such as Auto Scaling on your behalf."
    force_detach_policies = false
    managed_policy_arns   = [
        "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole",
    ]
    max_session_duration  = 3600
    name                  = "CodeDeployToRaspberry"
    path                  = "/"
    tags                  = {}
    tags_all              = {}

    inline_policy {}
}