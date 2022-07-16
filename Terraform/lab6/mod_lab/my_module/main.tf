resource "aws_instance" "web_server" {
    ami = "ami-b70554c8"
    instance_type = "t2.micro"
    count = "${var.server_count}"
} 