output "instance_id" {
  value = aws_instance.my_ins.id
}

output "public_ip" {
  value = aws_instance.my_ins.public_ip
}
