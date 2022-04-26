resource "aws_ssm_parameter" "door_sensor_topic_arn" {
    data_type = "text"
    name      = "/doorSensor/sns_arn"
    tags      = {}
    tags_all  = {}
    tier      = "Standard"
    type      = "String"
    value     = aws_sns_topic.door_sensor_topic.arn
}