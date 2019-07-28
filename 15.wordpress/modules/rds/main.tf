resource "aws_db_subnet_group" "mysql" {
  name       = "${var.stack}-subnetgroup"
  subnet_ids = ["${var.subnet_id1}","${var.subnet_id2}"]
  #subnet_ids = ["${var.subnet_ids}"]
  tags = {
    Name = "WordPress Subnet Group"
  }
}

resource aws_security_group "mysql" {
  name        = "${var.stack}-DBSG"
  description = "managed by terrafrom for db servers"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name = "${var.stack}-DBSG"
  }

  ingress {
    protocol        = "tcp"
    from_port       = 3306
    to_port         = 3306
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_db_instance" "db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "${var.stack}name"
  username             = "${var.db_user}"
  password             = "${var.db_pass}"
  parameter_group_name = "default.mysql5.7"
  vpc_security_group_ids = ["${aws_security_group.mysql.id}"]
  db_subnet_group_name = "${aws_db_subnet_group.mysql.id}"
  skip_final_snapshot = true
}
