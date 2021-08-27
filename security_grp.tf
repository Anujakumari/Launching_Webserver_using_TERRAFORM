
#  *****  Creating a Security Group   *****

resource "aws_security_group" "sg_task-5" {
  depends_on = [aws_vpc.vpc_task-5]
  vpc_id = aws_vpc.vpc_task-5.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]

  }

  tags = {
    Name = "Security group for task-5"
  }
}