
resource "aws_instance" "my_ubuntu" {
  ami           = "ami-04cdc91e49cb06165"
  instance_type = "t3.micro"

  tags = {
    Name    = "My ubuntu"
    Owner   = "vch"
    Project = "Terraform lessons"
  }
}
