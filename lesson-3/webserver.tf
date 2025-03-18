resource "aws_instance" "webserver" {
  ami           = "ami-0c6da69dd16f45f72" # amazon linux
  instance_type = "t3.micro"
  tags = {
    Name = "Apache-papache"
  }
  vpc_security_group_ids = [aws_security_group.webserver.id]
  user_data              = file("user_data.sh")
}

resource "aws_security_group" "webserver" {
  name        = "webserver security group"
  description = "security group for web server"

  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

}
