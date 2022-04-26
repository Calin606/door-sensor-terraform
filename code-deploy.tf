resource "aws_codedeploy_app" "door_sensor_raspberry" {
    compute_platform    = "Server"
    name                = "doorSensor"
    tags                = {}
    tags_all            = {}
}

resource "aws_codedeploy_deployment_group" "door_sensor_deployment_group" {
    app_name               = "doorSensor"
    autoscaling_groups     = []
    deployment_config_name = "CodeDeployDefault.AllAtOnce"
    deployment_group_name  = "doorSensor"
    service_role_arn       = aws_iam_role.raspberry_code_deploy_role.arn
    tags                   = {}
    tags_all               = {}

    deployment_style {
        deployment_option = "WITHOUT_TRAFFIC_CONTROL"
        deployment_type   = "IN_PLACE"
    }

}
