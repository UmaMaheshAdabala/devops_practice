module "ec2_instance" {
  source        = "../../modules/ec2"
  ami           = "ami-0521cb2d60cfbb1a6"
  instance_type = "t3.micro"
  instance_name = "prod-instance"
}
