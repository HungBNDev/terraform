output "eip_ec2_dev_demo_app_public_ip" {
  value = module.ec2_dev_demo.public_ip
}
output "eip_ec2_dev_demo_app_private_ip" {
  value = module.ec2_dev_demo.private_ip
}
output "data_aws_subnet_all" {
  value = data.aws_subnet.all
}
output "resource_alb_test_subnets" {
  value = aws_lb.test.subnets
}
