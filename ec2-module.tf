

# day la cach goi module de tao resource
module "ec2_dev_demo" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  version                     = "2.6.0"
  name                        = "hungbn-dev-demo-app"
  instance_count              = 1
  instance_type               = "t2.micro"
  key_name                    = "hungbn"
  associate_public_ip_address = true
  disable_api_termination     = false
  cpu_credits                 = "standard"

  root_block_device = [{
    volume_type           = "gp2"
    volume_size           = "8"
    delete_on_termination = true
  }]

  ami                    = var.ami_id
  vpc_security_group_ids = [aws_security_group.ssh_demo.id]
  #vpc_security_group_ids = var.security_group_ids
  subnet_id              = var.subnet_id

  tags       = {
    Stack = "demo"
    Role = "app"
    Environment = "dev"
  }
  volume_tags = {
    Name        = "hungbn-dev-demo-app-root-volume"
    Stack       = "demo"
    Role        = "app"
    Environment = "dev"
  }
}
resource "aws_security_group" "ssh_demo" {
  name        = "allow_ssh_demo"
  description = "Allow SSH only from myip"
  vpc_id      = var.vpc_id

  ingress {
    description      = "SSH from myip"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["171.232.98.38/32"]
  }

  ingress {
    description      = "Allow LB"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    security_groups  = ["sg-033dd680566d84c6a"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}
