resource "aws_lb_target_group" "jenkins_example" {
  name        = "dev-demo-jenkins"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
}

resource "aws_lb_target_group_attachment" "jenkins_example" {
  count            = 1
  target_group_arn = aws_lb_target_group.jenkins_example.arn
  target_id        = element(module.ec2_dev_demo.id, count.index)
  port             = 8080

  depends_on       = [aws_lb_target_group.jenkins_example]
}
