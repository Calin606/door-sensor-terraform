resource "aws_sns_topic" "door_sensor_topic" {
    content_based_deduplication = false
    fifo_topic                  = false
    name                        = "DoorSensor"
    policy                      = jsonencode(
        {
            Id        = "__default_policy_ID"
            Statement = [
                {
                    Action    = [
                        "SNS:GetTopicAttributes",
                        "SNS:SetTopicAttributes",
                        "SNS:AddPermission",
                        "SNS:RemovePermission",
                        "SNS:DeleteTopic",
                        "SNS:Subscribe",
                        "SNS:ListSubscriptionsByTopic",
                        "SNS:Publish",
                    ]
                    Condition = {
                        StringEquals = {
                            "AWS:SourceOwner" : "328680576009"
                        }
                    }
                    Effect    = "Allow"
                    Principal = {
                        AWS = "*"
                    }
                    Resource  = "arn:aws:sns:us-east-1:328680576009:DoorSensor"
                    Sid       = "__default_statement_ID"
                },
            ]
            Version   = "2008-10-17"
        }
    )
    tags                        = {}
    tags_all                    = {}
}

resource "aws_sns_topic_subscription" "user_update_door_sensor" {
    endpoint                       = "+400742038591"
    protocol                       = "sms"
    raw_message_delivery           = false
    topic_arn                      = aws_sns_topic.door_sensor_topic.arn
}