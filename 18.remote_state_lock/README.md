State file Locking:

Prerequisites:

1. S3 bucket with versioning enabled, versioning helps even if you lose the state file different version  of the state is available for point_in_time_recovery
2. DynamoDB Table with LockID as primary hash_key.

One you have above resources available we can use these details in the backend configuration of any Terraform Project.


Process to enable Locking:

1. Add terraform block as show below with required inputs like bucket, DynamoDB table Name

                terraform {
                  required_version = "v0.11.11"   #Terraform Version required

                  backend "s3" {
                    bucket         = "singular-hound-ter-state" #S3 bucket Name
                    encrypt        = true                       #Encrytion at rest
                    key            = "pavantest.tfstate"        #Name of the state file to be created/referred
                    region         = "eu-west-2"                #Region of backend
                    dynamodb_table = "singular-hound-ter-state" #DynamoDB Table for enabling Locking
                  }
                }

2. terraform init would find whether backend config changed or not.




Test Scenario:

1. First create the s3/dynamodb tables with given TF configuration ( these can be created manually as well, so that we don't have choice to destroy these with single command. We shouldn't lose these for future runs of terraform projects using these.)

2. Update the terraform configuration with above given details and do terraform init, plan and apply

3. Another developer should try while this code being executed, he shouldn't be able to as state is locked.


commands to explore:


`terraform force-unlock LOCK_ID`

`terraform init lock=false/true`
