resource "aws_security_group" "sg" {
  name = "ec2-instances-sg"
}

resource "aws_security_group_rule" "sg_rule" {
  type              = "ingress"
  security_group_id = aws_security_group.sg.id
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}


resource "aws_security_group" "alb_sg" {
}
