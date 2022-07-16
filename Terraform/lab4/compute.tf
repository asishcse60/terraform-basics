resource "aws_instance" "web_server" {
    ami = "${lookup(var.webserver_amis, var.aws_region)}"
    instance_type = "t2.micro"

    subnet_id = "${aws_default_subnet.learntf_default_subnet.id}"

    depends_on = [aws_s3_bucket.learntf-bins]

    key_name = "${aws_key_pair.deployer-keypair.key_name}"

    vpc_security_group_ids = [aws_security_group.web_server_sec_group.id]

   
    provisioner "file" {
        source = "learntf.index.html"
        destination = "/var/www/html/index.html"
    }

    connection {
        host = aws_instance.web_server.public_ip
        type = "ssh"
        user = "ec2-user"
        private_key = "${file("../aws_rsa")}"
    }
}   

output "webserver_kpublic_ip" {
    value = "${aws_instance.web_server.public_ip}"
    #count = 0
}
