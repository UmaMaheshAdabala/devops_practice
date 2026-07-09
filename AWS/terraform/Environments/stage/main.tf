module "ec2_instance" {
  source        = "../../modules/ec2"
  ami           = "ami-0521cb2d60cfbb1a6"
  instance_type = "t3.micro"
  instance_name = "stage-instance"
}

output "ec2_instance_id" {
  value = module.ec2_instance.instance_id
}
output "ec2_instance_public_ip" {
  value = module.ec2_instance.public_ip
}
