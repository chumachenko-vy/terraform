
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
