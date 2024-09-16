resource "aws_instance" "webserver" {
  ami                    = "ami-0c6da69dd16f45f72" # amazon linux
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.webserver.id]
  user_data = templatefile("user_data.sh.tpl", {
    f_name = "Vald",
    l_name = "Ch",
    names  = ["Vasya", "petya", "Donald", "Test", "XYZ!"]
  })

  tags = {
    Name  = "webserver build by terraform!"
    Owner = "VCH"
  }
  lifecycle {
    ignore_changes = ["ami", "user_data"]
  }

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
