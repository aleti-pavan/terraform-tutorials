data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "template_file" "phpconfig" {
  template = "${file("${var.php_file_path}")}"

  vars {
    db_port = "${var.db_port}"
    db_host = "${var.db_host}"
    db_user = "${var.db_user}"
    db_pass = "${var.db_pass}"
    db_name = "${var.db_name}"
  }
}

resource "aws_key_pair" "keypair1" {
  key_name   = "${var.stack}-keypairs"
  public_key = "${file("${var.ssh_key}")}"
}


resource "aws_instance" "ec2" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.instance_type}"

/*  depends_on = [
    "aws_db_instance.mysql",
  ]
*/

  key_name                    = "${aws_key_pair.keypair1.key_name}"
  vpc_security_group_ids      = ["${aws_security_group.web.id}"]
  subnet_id                   = "${var.pub_subnetid1}"
  associate_public_ip_address = true

  user_data = "${file("${var.userdata_file_path}")}"

  tags {
    Name = "EC2 Instance"
  }

  provisioner "file" {
    source      = "${var.userdata_file_path}"
    destination = "/tmp/userdata.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file("~/.ssh/id_rsa")}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/userdata.sh",
      "/tmp/userdata.sh",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file("~/.ssh/id_rsa")}"
    }
  }

  provisioner "file" {
    content     = "${var.config_rendered}"
    destination = "/tmp/wp-config.php"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file("~/.ssh/id_rsa")}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo cp /tmp/wp-config.php /var/www/html/wp-config.php",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file("~/.ssh/id_rsa")}"
    }
  }

  timeouts {
    create = "20m"
  }
}




resource aws_security_group "web" {
  name        = "${var.stack}-webSG"
  description = "This is for ${var.stack}s web servers security group"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name = "${var.stack}-webSG"
  }

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "icmp"
    from_port   = -1
    to_port     = -1
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
