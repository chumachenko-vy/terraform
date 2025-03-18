resource "aws_instance" "webserver" {
  ami                    = "ami-0c6da69dd16f45f72" # amazon linux
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.Dynamic_SG.id]

  tags = {
    Name  = "web"
    Owner = "VCH"
  }
  depends_on = [aws_instance.database, aws_instance.app_server]

}

resource "aws_instance" "app_server" {
  ami                    = "ami-0c6da69dd16f45f72" # amazon linux
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.Dynamic_SG.id]

  tags = {
    Name  = "app"
    Owner = "VCH"
  }

  depends_on = [aws_instance.database]

}
resource "aws_instance" "database" {
  ami                    = "ami-0c6da69dd16f45f72" # amazon linux
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.Dynamic_SG.id]

  tags = {
    Name  = "database"
    Owner = "VCH"
  }


}


resource "aws_security_group" "Dynamic_SG" {
  name        = "Dynamic Security Group"
  description = "security group for web server ssh sql"


  dynamic "ingress" {

    for_each = ["80", "443", "8080", "22", "3306"]

    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }



  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}

