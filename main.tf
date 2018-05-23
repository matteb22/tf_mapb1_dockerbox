resource "aws_instance" "mbottini-dockerbox" {
  ami = "ami-43a15f3e"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
  availability_zone = "us-east-1a"
  subnet_id = "${aws_subnet.us-east-1a.id}"
  associate_public_ip_address = true
  count = "4"

  tags {
    Name = "mbottini-dockerbox-${count.index+1}"
    #Name = "${var.instance_name}-${count.index+1}"
  }


  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = "${file(var.my_private_key_path)}"
  }

  provisioner "file" {
    source = "script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }


  # the public SSH key
  key_name = "mbottini-softtek"

}

resource "aws_vpc" "main" {
  cidr_block = "172.10.10.0/24"
  enable_dns_hostnames = true
}

resource "aws_subnet" "us-east-1a" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "172.10.10.0/25"
  availability_zone = "us-east-1a"
}


resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"
  tags {
        Name = "InternetGateway"
    }
}

resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.main.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gw.id}"
}



resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

output "public_ip" {
  value = "${aws_instance.mbottini-dockerbox.*.public_ip}"
}

output "private_dns" {
  value = "${aws_instance.mbottini-dockerbox.*.private_dns}"
}

output "private_ip" {
  value = "${aws_instance.mbottini-dockerbox.*.private_ip}"
}
