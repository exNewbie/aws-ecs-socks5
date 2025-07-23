#!/bin/bash

AWS_PROFILE=${1:-"default"}
AWS_REGION=${2:-"us-east-1"}
CLUSTER_NAME=${3:-"socks5"}

AWS_CMD="aws --profile $AWS_PROFILE --region $AWS_REGION"

task_id=$( $AWS_CMD ecs list-tasks --cluster $CLUSTER_NAME --query 'taskArns[0]' --output text 2> /dev/null )
if [ -z "$task_id" ]; then
  echo "{ \"result\": \"No tasks found in cluster $CLUSTER_NAME.\" }"

else
    eni_id=$( $AWS_CMD ecs describe-tasks --cluster $CLUSTER_NAME --tasks $task_id --query 'tasks[0].attachments[0].details[?name==`networkInterfaceId`].value' --output text )
    if [ -z "$eni_id" ]; then
      echo "{ \"result\": \"No ENI found for task $task_id in cluster $CLUSTER_NAME.\" }"
      exit 1
    fi

    taks_pub_ip=$( $AWS_CMD ec2 describe-network-interfaces --network-interface-ids $eni_id --query 'NetworkInterfaces[0].Association.PublicIp' --output text 2> /dev/null )
    if [ -z "$taks_pub_ip" ]; then
      echo "{ \"result\": \"No public IP found for ENI $eni_id.\" }"
      exit 1
    fi

    echo "{ \"result\": \"$taks_pub_ip\" }"
fi
