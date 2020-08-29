# Execution

## Validate & Deploy template

`aws cloudformation validate-template --template-body file://ec2-with-sg.yaml --profile terraform --region eu-west-2 | jq`

`aws cloudformation create-stack --stack-name test-stack --template-body file://ec2-with-sg.yaml --profile terraform --region eu-west-2 | jq`

#### Delete Stack

`aws cloudformation delete-stack --stack-name test-stack --profile terraform --region eu-west-2`
