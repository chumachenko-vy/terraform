data "aws_ami" "latest_ubuntu" {
  owners      = [""]
  most_recent = true
  filter {
    name   = "name"
    values = [""]
  }
}

output "latest_ubuntu_ami_id" {
  value = ""
}
