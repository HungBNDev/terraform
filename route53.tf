resource "aws_route53_record" "jenkins_test" {
  zone_id    = aws_route53_zone.jenkins.id
  name       = "jenkins-test-demo.vytran.tk"
  type       = "A"
  alias {
    name                   = "test-lb-tf-1911438033.ap-southeast-1.elb.amazonaws.com"
    zone_id                = "Z1LMS91P8CMLE5"
    evaluate_target_health = true
  }
  depends_on = [aws_route53_zone.jenkins]
}

resource "aws_route53_zone" "jenkins" {
  name = "jenkins-test-demo.vytran.tk"

  tags = {
    Environment = "dev"
  }
}
