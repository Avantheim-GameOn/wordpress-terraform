resource "aws_cloudwatch_dashboard" "wp_dashboard" {
  dashboard_name = "${var.project_name}-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric",
        x = 0,
        y = 0,
        width = 12,
        height = 6,
        properties = {
          metrics = [
            [ "AWS/EC2", "CPUUtilization", "InstanceId", var.instance_id ]
          ],
          period = 300,
          stat   = "Average",
          region = "eu-west-1",
          title  = "Uso de CPU"
        }
      },
      {
        type = "metric",
        x = 0,
        y = 7,
        width = 12,
        height = 6,
        properties = {
          metrics = [
            [ "AWS/EC2", "NetworkIn", "InstanceId", var.instance_id ],
            [ ".",       "NetworkOut", ".", var.instance_id ]
          ],
          period = 300,
          stat   = "Sum",
          region = "eu-west-1",
          title  = "Tráfego de rede"
        }
      }
    ]
  })
}
