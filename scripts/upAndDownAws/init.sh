#!/bin/bash

[ "$1" = "up" ] && state="stopped" || state="running"

listInstance=$(aws ec2 describe-instances --filters \
 Name=instance-state-name,Values="$state" \
 Name=tag:env,Values="dev" --output json)

instance=$(echo $listInstance | jq '.Reservations[].Instances[0].InstanceId')

len=${#instance[@]}

if ((len >= 1)); then
  for i in $instance; do
    id="${i//\"/}"
    if [ "$1" = "up" ]; then
      echo "demarre instance ${id}"
      aws ec2 start-instances --instance-ids "$id"
    else
      echo "stop instance ${id}"
      aws ec2 stop-instances --instance-ids "$id"
    fi
  done
fi
