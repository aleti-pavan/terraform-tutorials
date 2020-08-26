resource "random_pet" "tags"{
  length = 3
}

# resource "aws_instance" "ec2" {
#     count = var.instances
#     ami = data.aws_ami.rhel.id
#     instance_type = var.vm_size
#     subnet_id = aws_subnet.subnet[count.index].id
#     associate_public_ip_address = true
#     vpc_security_group_ids = ["${aws_security_group.sg.id}"]
#     #key_name = aws_key_pair.sshkey.key_name

#     tags = {
#         Name = "${var.stack}-${random_pet.tags.id}-ec2"
#     }
# }


# data "aws_ami" "rhel" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["RHEL-7.6_HVM_GA-20181017-x86_64*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   owners = ["309956199498"] # Canonical
# }