resource "aws_eip" "my_static_ip" {
  instance = aws_instance.webserver.id
}


resource "aws_instance" "webserver" {
  ami                    = "ami-0c6da69dd16f45f72" # amazon linux
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.Dynamic_SG.id]
  user_data = templatefile("user_data.sh.tpl", {
    f_name = "Vald",
    l_name = "Ch",
    names  = ["Vasya", "petya", "Donald", "Test"]
  })

  tags = {
    Name  = "webserver build by terraform!"
    Owner = "VCH"
  }
  lifecycle {
    create_before_destroy = true
  }


}

resource "aws_security_group" "Dynamic_SG" {
  name        = "Dynamic Security Group"
  description = "security group for web server ssh"


  dynamic "ingress" {

    for_each = ["80", "443", "8080", "22"]

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

output "webserver_instance_id" {
  value = aws_instance.webserver.id
}

output "static_public_ip" {
  value = aws_eip.my_static_ip.public_ip
}
