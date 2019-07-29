# terraform-tutorials  (Pavan Kumar Aleti)
This is for Terraform tutorials

1.

  Installation of terraform


        i) Create Linux EC2 (possibly RHEL)


        ii) Download the Linux version software to Mac


        iii) scp into EC2 to /home/ec2-user/

        `scp -i mykey.pem /path/to/terrafor/file ec2-user@host-ip:/home/ec2-user`


        iv) set the path
            `export PATH=$PATH:/home/ec2-user/`

2.   Terraform Style Guide
     `https://github.com/jonbrouse/terraform-style-guide/blob/master/README.md`

3. Different types of terraform blocks
      i) provider block - declaring providers

      ```
       provider "aws" {
           region       = "region-id"
           accss_key    = "access_key"
           secret_key   = "secret_key"
       }
      ```

      ii) resource block - to create resources

      ```
      resource "resource_type" "resource_name" {
          argument1 = "value"
          argument2 = "value"
      }
      ```

      iii) variable block - for declaring variables

      ```
         variable "variable_name" {
             description = "description of the variable"
             default     = "default value of the variable"
             type        = "string/map/list/number/bool"
         }
      ```

      iv) data block  - data to be fetched from the given provider

      ```
         # Find the latest available AMI that is tagged with Component = web
                data "aws_ami" "web" {
                    filter {
                        name   = "state"
                        values = ["available"]
                    }

                    filter {
                        name   = "tag:Component"
                        values = ["web"]
                    }

                    most_recent = true
                }
        ```

        v) terraform block - terraform specific settings are gathered into this section.
        ```
                 Each terraform block can contain a number of settings related to Terraform's behavior. Within a terraform block, only constant values can be used; arguments may not refer to named objects such as resources, input variables, etc, and may not use any of the Terraform language built-in functions.

                 https://www.terraform.io/docs/configuration/terraform.html
                 locking terraform required_version.
                 terraform {
                   required_version = "~> 0.11.8"

                   backend "s3" {
                     encrypt = true
                   }
                 }
                 Locking particular provider version
                 provider "aws" {
                   version = "~> 2.17.0"

                 }
        ```
4.

    `terraform.tfvars` for default variable values


    Terraform CLI defines the following meta-arguments, which can be used with any resource type to change the behavior of resources:

        depends_on, for specifying hidden dependencies

        count , for creating multiple resource instances

        provider, for selecting a non-default provider configuration

        lifecycle, for lifecycle customizations

        provisioner and connection, for taking extra actions after resource creation


5.

    commands to be used:

      terraform init    - downloads the required modules
      terraform plan    - used to create an execution plan
      terraform apply   - used to apply the changes required to reach the desired state of the configuration,

  `1.ec2-instance` folder and `main.tf`

            provider "aws" {
                region     = "us-west-2"
                access_key = "my-access-key"
                secret_key = "my-secret-key"
            }

            resource "aws_instance" {
                ami_id = "ami-id"  #find one from console
                instance_type = "t2.micro"
            }

    add tags to that and modify resource block.

            resource "aws_instance" {
                ami_id = "ami-id"  #find one from console
                instance_type = "t2.micro"

                tags {
                    Name = "EC2 Instance"
                }
            }


  `2.ec2-instance-multi-files` split the files on purpose

            provider.tf

                    provider "aws" {
                        region     = "us-west-2"
                        access_key = "my-access-key"
                        secret_key = "my-secret-key"
                    }

            ec2.tf

                    resource "aws_instance" {
                        ami_id = "ami-id"  #find one from console
                        instance_type = "t2.micro"

                        tags {
                            Name = "EC2 Instance"
                        }
                    }

   `3.ec2-with-str-variables` create vars.tf and create variables for region, access_key, secret_key and tags

            vars.tf

                 variable "region"{
                     description = "Region to create resources"
                     default     = "us-east-1"
                     type        = string #Default type is string
                 }
                 variable "access_key"{
                     description = "AWS Access Key"
                     default     = "copy-your-access-key-here"
                 }
                 variable "secret_key"{
                     description = "AWS Secret Key"
                     default     = "copy-your-secret-access-key-here"
                 }
                variable "tags"{
                     description = "Name for Tags"
                     default     = "my-ec2-instnace"
                 }


            provider.tf

                    provider "aws" {
                        region     = "${var.region}"
                        access_key = "${var.access_key}"
                        secret_key = "${var.secret_key}"
                    }

            ec2.tf

                    resource "aws_instance" {
                        ami_id = "ami-id"  #find one from console
                        instance_type = "t2.micro"

                        tags {
                            Name = "${var.tags}"
                        }
                    }

   `4.ec2-with-diff-variables` explore map and list variables


       provider.tf

            provider "aws" {
                region     = "${var.region}"
                access_key = "${var.access_key}"
                secret_key = "${var.secret_key}"
            }

       vars.tf

            variable "region"{
                description = "Region to create resources"
                default     = "us-east-1"
                type        = string #Default type is string
            }
            variable "access_key"{
                description = "AWS Access Key"
                default     = "copy-your-access-key-here"
            }
            variable "secret_key"{
                description = "AWS Secret Key"
                default     = "copy-your-secret-access-key-here"
            }
            variable "tags"{
                description = "Name for Tags"
                default     = "my-ec2-instnace"
            }

            variable "amis" {
                    type = "map"
                    default = {
                        us-east-1 = "ami-13be557e"
                        us-west-2 = "ami-06b94666"
                        eu-west-1 = "ami-0d729a60"
                    }
            }

        ec2.tf
            resource "aws_instance" "example" {
                ami           = "${lookup(var.amis, var.region)}"
                instance_type = "t2.micro"

                tags {
                    Name = "${var.tags}"
                }
            }

   `5.terraform.tfvars and outputs.tf` - keep all values in files

      terraform.tfvars

        access_key = "copy-your-access-key-here"
        secret_key = "copy-your-secret-access-key-here"

     provider.tf

            provider "aws" {
                region     = "${var.region}"
                access_key = "${var.access_key}"
                secret_key = "${var.secret_key}"
            }

       vars.tf

            variable "region"{
                description = "Region to create resources"
                default     = "us-east-1"
                type        = string #Default type is string
            }

            variable "access_key"{
                description = "AWS Access Key"
                #Moved the value to terraform.tfvars
            }

            variable "secret_key"{
                description = "AWS Secret Key"
                #Moved the value to terraform.tfvars
            }

            variable "tags"{
                description = "Name for Tags"
                default     = "my-ec2-instnace"
            }

            variable "amis" {
                    type = "map"
                    default = {
                        us-east-1 = "ami-13be557e"
                        us-west-2 = "ami-06b94666"
                        eu-west-1 = "ami-0d729a60"
                    }
            }

            variable "port_number" {
                description = "Remote tcp port to be used for access to the vms created via the nsg applied to the nics."
                default = ["22","3000","9090","9093"]
                type = "list"
            }


        ec2.tf
            resource "aws_instance" "example" {
                ami           = "${lookup(var.amis, var.region)}"
                instance_type = "t2.micro"

                tags {
                    Name = "${var.tags}"
                }
            }

        outputs.tf    
            output "ip" {
                value = ${aws_instance.example.public_ip}
                #Refer the outputs of the aws_instance
            }

   `6. count` - create 2 ec2 instances to explore count

        https://github.com/aleti-pavan/terraform-ec2

   `7. provisioners` - explore local and remote provisioners

       vars.tf
          variable ssh_key {
                default     = "~/.ssh/id_rsa.pub"
                description = "Default pub key"
          }
          variable stack {
                description = "this is name for tags"
                default     = "terraform"
          }

       keypair.tf
            resource "aws_key_pair" "keypair1" {
                    key_name   = "${var.stack}-keypairs"
                    public_key = "${file("${var.ssh_key}")}"
            }

       ec2.tf
            resource "aws_instance" "example" {
                ami           = "${lookup(var.amis, var.region)}"
                instance_type = "t2.micro"

                tags {
                    Name = "${var.tags}"
                }

                provisioner "local-exec" {
                    command = "echo ${aws_instance.example.public_ip} >> public_ip.txt"
                }

                provisioner "remote-exec" {
                    inline = [
                        "sudo yum -y install nginx",
                        "sudo systemctl start nginx",
                        ]
                }

                connection {
                    type     = "ssh"
                    user     = "ec2-user"
                    password = ""
                    private_key = "${file("~/.ssh/id_rsa")}"
                }

            }

       outputs.tf
            output "Login" {
                value = "ssh -i ${aws_key_pair.keypair1.key_name} ec2-user@${aws_instance.example.public_ip}"
            }

   `8.wordpress-app` - explore modules & create a directory structure


       wordpress-app
        ├── app
        │   ├── provider.tf
        │   ├── terraform.tfvars
        │   ├── vars.tf
        │   └── wordpress.tf
        ├── modules
        │   ├── ec2
        │   │   ├── main.tf
        │   │   ├── ouput.tf
        │   │   └── vars.tf
        │   ├── rds
        │   │   ├── main.tf
        │   │   ├── ouput.tf
        │   │   └── vars.tf
        │   └── vpc
        │       ├── main.tf
        │       ├── ouput.tf
        │       └── vars.tf
        └── scripts

   `10. terraform-env-variables`
        https://www.terraform.io/docs/commands/environment-variables.html

   `9. remote state - backend`  
          remote state - explain the state file and add remote state configuration

   `11. Locking the State with S3 and DynamoDB`
          `state_lock repository `
