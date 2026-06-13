data "aws_ami" "wordpress_ami" {
  most_recent = true
  owners      = ["099720109477"]  # Canonical's official AWS account ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# 1. Create the Security Group
resource "aws_security_group" "wordpress_sg" {
  name        = "allow-wordpress"
  description = "Allow HTTP and SSH traffic"

 dynamic "ingress" {
    for_each = var.security_group_ingress_rules
    content {
       description = ingress.value.description
       from_port   = ingress.value.from_port
       to_port     = ingress.value.to_port
       protocol    = ingress.value.protocol
       cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.security_group_egress_rules
    content {
       description = egress.value.description
       from_port   = egress.value.from_port
       to_port     = egress.value.to_port
       protocol    = egress.value.protocol
       cidr_blocks = egress.value.cidr_blocks
    }
   }
}

# 2. Launch the Instance and attach the Security Group
resource "aws_instance" "ec2_wordpress" {
  ami                    = data.aws_ami.wordpress_ami.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  user_data              = file("user_data.sh")
  vpc_security_group_ids = [aws_security_group.wordpress_sg.id] 
  associate_public_ip_address = var.associate_public_ip
}

