provider "aws" {
  region = "eu-west-2"
}

data "aws_ami" "connectivity_tester_linux" {
  most_recent = true
  filter {
    name = "name"
    values = [
      "connectivity-tester-linux*"]
  }
}

resource "aws_security_group" "allow_http" {
  name = "allow_http"
  description = "Allow all inbound http traffic"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}

resource "aws_instance" "linux" {
  instance_type = "t2.micro"
  ami = "${data.aws_ami.connectivity_tester_linux.id}"
  security_groups = [
    "allow_http"]
  user_data = <<EOT
CHECK_self=127.0.0.1:80
CHECK_google=google.com:80
CHECK_googletls=google.com:443
LISTEN_http=0.0.0.0:80
EOT
}

output "connectivity_tester_linux public dns" {
  value = "${aws_instance.linux.public_dns}"
}