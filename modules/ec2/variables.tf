variable "instance_type" {
    type = string
    default = "t3.micro"
}

locals {
  instance_ami = "ami-05d62b9bc5a6ca605"
}

output "instance_id" {
    description = "The ID of the EC2 Instance"
    value = aws_instance.this.id
}
