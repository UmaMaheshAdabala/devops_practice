resource "aws_instance" "my_ins" {
  instance_type = var.instance_type
  ami           = var.ami
  tags = {
    Name = var.instance_name
  }
}

