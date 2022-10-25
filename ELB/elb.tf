# Create a new load balancer
resource "aws_elb" "ram" {
  name = "ram-elb"
  availability_zones = [ "us-east-1a", "us-east-1b" ]

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    healthy_threshhold = 2
    unhealthy_threshold = 2
    timeout = 5
    target = "HTTP:80/"
    interval = 30
  }

  // ELB attachments

  instances = [ "${aws_instance.first_server.id}", "${aws_instance.second_server.id}"]
  cross_zone_load_balancing = true
  idle_timeout = 40
  tags = {
    Name = "Demo-ELB"
  }
}