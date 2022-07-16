provider "aws" {
    access_key = "AKIAXLU2SE6CLFWWCFMC"
    secret_key = "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"
    region = "us-east-1"
}

resource "aws_instance" "myexample"{
    ami = "ami-b70554c8"
    instance_type = "t2.micro"
}