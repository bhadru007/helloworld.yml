#!/bin/bash

MY_PATH="`dirname \"$0\"`"

file="$MY_PATH/../config/util-config.properties"

source $file

aws cloudformation deploy --stack-name "$stackName" --template-file "$MY_PATH/../templates/util.json" --parameter-overrides VPC="$vpcid" EC2AMI="$amiid" SSHKey="$keyname" SSHIpAddress="$sship" OwnerTag="$owner" --capabilities CAPABILITY_IAM --profile $profile


aws cloudformation wait stack-create-complete --stack-name "$stackName" --profile $profile

ipaddress=`aws cloudformation describe-stacks --stack-name "$stackName" --profile $profile | jq '.Stacks[].Outputs[].OutputValue' | sed 's/"//g'`


echo ""
echo ""
echo ""
eval `ssh-agent -s`
ssh-add $keylocation


echo "ssh ec2-user@$ipaddress"







