output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value = aws_instance.instance_terraform.public_ip
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}