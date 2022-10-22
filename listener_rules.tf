resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  depends_on = [aws_subnet.in_secondary_cidr]
  security_groups    = [aws_security_group.ssh_demo.id]
  subnets            = [for s in data.aws_subnet.all : s.id]

  enable_deletion_protection = true

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_listener_rule" "jenkins_demo" {
  listener_arn = aws_lb_listener.jenkins_demo.id
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jenkins_example.arn
  }

  condition {
    host_header {
      values = ["jenkins-test-demo.vytran.tk"]
    }
  }
}

resource "aws_lb_listener" "jenkins_demo" {
  load_balancer_arn = aws_lb.test.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Fixed response content"
      status_code  = "200"
    }
  }
}
