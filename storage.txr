resource "aws_dynamodb_table" "rasp_db_table" {
    billing_mode   = "PROVISIONED"
    hash_key       = "Serial"
    name           = "door-sensor"
    range_key      = "date_time"
    read_capacity  = 1
    stream_enabled = false
    tags           = {}
    tags_all       = {}
    write_capacity = 1

    attribute {
        name = "Serial"
        type = "S"
    }
    attribute {
        name = "date_time"
        type = "N"
    }

    point_in_time_recovery {
        enabled = false
    }

    timeouts {}

}