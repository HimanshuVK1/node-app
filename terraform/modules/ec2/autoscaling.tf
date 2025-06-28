resource "aws_launch_template" "launch_template" {
  name_prefix   = "nodeapp"
  image_id      = "ami-0b09627181c8d5778"
  instance_type = "t3.micro"

  vpc_security_group_ids = [var.security_group_id]
  iam_instance_profile {
    name = var.iam_instance_profile_name
  }

  user_data = base64encode(<<EOF
#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
sudo echo "<html><body><h1>Welcome to Apache httpd web server!</h1></body></html>" > /var/www/html/index.html
EOF
  )

  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "node-app-instance"
    }
  }
}

# Creating our Auto Scaling group with Launch Template
resource "aws_autoscaling_group" "autoscaling_group" {
  name                = "autoscaling-group-asg"
  desired_capacity    = 2
  max_size            = 3
  min_size            = 1
  health_check_type   = "EC2"
  vpc_zone_identifier = var.public_subnet_ids

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }

  # Add tags
  tag {
    key                 = "Name"
    value               = "node-app-asg-instance"
    propagate_at_launch = true
  }

  # Add health check grace period
  health_check_grace_period = 300
}

resource "aws_lb_target_group" "target_group" {
  name        = var.target_group_name
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  # Health check configuration
  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
}

# Attach ASG to Target Group
resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.autoscaling_group.id
  lb_target_group_arn    = aws_lb_target_group.target_group.arn
}

