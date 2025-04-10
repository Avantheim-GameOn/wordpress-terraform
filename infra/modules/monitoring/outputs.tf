output "cpu_alarm_name" {
  value = aws_cloudwatch_metric_alarm.high_cpu.alarm_name
}

output "available_metrics" {
  value = [
    "CPUUtilization",
    "NetworkIn",
    "NetworkOut",
    "DiskReadBytes",
    "DiskWriteBytes"
  ]
  description = "Métricas CloudWatch EC2 disponíveis por defeito"
}
