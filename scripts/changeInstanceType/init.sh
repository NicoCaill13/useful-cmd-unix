#!/bin/bash

export AWS_SECRET_ACCESS_KEY=yours
export AWS_ACCESS_KEY_ID=yours
export AWS_DEFAULT_REGION=eu-west-1

if [ -z "$1" ]; then
  echo "first arg is mandatory and must be equal to the first part of EC2 slug tag"
  exit 1
elif [ -z "$2" ]; then
  echo "second arg is mandatory and must be equal to the second part of EC2 slug tag"
  exit 1
elif [ -z "$3" ]; then
  echo "third arg is mandatory and must be equal to the EC2 instance type"
  exit 1
else
  env="${1} ${2}"
  instance=$(aws ec2 describe-instances --filters Name=instance-state-name,Values=running Name=tag:slug,Values="$env" --output json | jq '.Reservations[]')
  instanceType=$(aws ec2 describe-instance-types --instance-types "$3" --output json | jq '.InstanceTypes[]')
fi

if [ -z "$instance" ]; then
  echo "this EC2 instance does not exist"
  exit 1
fi

instanceId=$(echo "$instance" | jq '.Instances[0].InstanceId')
id="${instanceId//\"/}"
aws ec2 stop-instances --instance-ids "$id"
aws ec2 wait instance-stopped --instance-ids "$id"
aws ec2 modify-instance-attribute --instance-id "$id" --instance-type "$3"
aws ec2 start-instances --instance-ids "$id"