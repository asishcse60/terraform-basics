resource "aws_instance" "web_server" {
    ami = "${lookup(var.webserver_amis, var.aws_region)}"
    instance_type = "t2.micro"
}   

output "webserver_kpublic_ip" {
    value = "${aws_instance.web_server.public_ip}"
    #count = 0
}

resource "aws_instance" "bastion" {
    ami = "${lookup(var.webserver_amis, var.aws_region)}"
    instance_type = "t2.micro"

    count = "${var.target_env == "dev" ? 3 : 0}"

}
 
output "bastion_ips" {
    value = "${aws_instance.bastion.*.private_ip}"
}

output "bastion_ip_0" {
    value = "${aws_instance.bastion.*.private_ip[0]}"
}

data "template_file" "webserver_policy_template"{

    template = "${file("${path.module}/policy.tpl")}"
    vars ={
        arn = "${aws_instance.web_server.arn}"
    }
    
}

output "web_server_policy_output" {
    value = "${data.template_file.webserver_policy_template.rendered}"
}