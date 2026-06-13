resource "aws_instance" "this" {
  ami                     = local.instance_ami
  instance_type           = var.instance_type
  tags = {
      Name        = "TerraformLaunch"
    }
  
}

resource "aws_instance" "import" {
  ami                     = local.instance_ami
  instance_type           = var.instance_type
  tags = {
      Name        = "TerraformImport"
    }

}
