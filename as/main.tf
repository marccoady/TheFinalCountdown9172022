# --- as/main.tf

resource "aws_launch_template" "asg_webserver" {
  name_prefix            = "webserver"
  image_id               = "ami-05fa00d4c63e32376"
  instance_type          = var.webserver_type
  vpc_security_group_ids = [var.fc_pb_sg]
  key_name               = var.key

  tags = {
    Name = "webserver"
  }
}

resource "aws_autoscaling_group" "asg_webserver" {
  name                = "asg_webserver"
  vpc_zone_identifier = tolist(var.fc_pb_sn)
  min_size            = 2
  max_size            = 3
  desired_capacity    = 2

  launch_template {
    id      = aws_launch_template.asg_webserver.id
    version = "$Latest"
  }
}

#resource "aws_autoscaling_attachment" "asg_attachment" {
#  autoscaling_group_name = aws_autoscaling_group.asg_webserver.id
#  lb_target_group_arn = var.alb_tg
#}