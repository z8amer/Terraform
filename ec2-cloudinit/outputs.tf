output "public_ip" {
    value = aws_instance.ec2_cloud-init.public_ip
}