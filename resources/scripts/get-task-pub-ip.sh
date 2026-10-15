#!/bin/bash

AWS_PROFILE=${1:-"default"}
AWS_REGION=${2:-"us-east-1"}
CLUSTER_NAME=${3:-"socks5"}

AWS_CMD="aws --profile $AWS_PROFILE --region $AWS_REGION"

MAX_RETRIES=20
RETRY_INTERVAL=10

for i in $(seq 1 $MAX_RETRIES); do
  task_id=$( $AWS_CMD ecs list-tasks --cluster $CLUSTER_NAME --query 'taskArns[0]' --output text 2>/dev/null )

  if [ -z "$task_id" ] || [ "$task_id" = "None" ]; then
    sleep $RETRY_INTERVAL
    continue
  fi

  eni_id=$( $AWS_CMD ecs describe-tasks --cluster $CLUSTER_NAME --tasks $task_id \
    --query 'tasks[0].attachments[0].details[?name==`networkInterfaceId`].value' \
    --output text 2>/dev/null )

  if [ -z "$eni_id" ] || [ "$eni_id" = "None" ]; then
    sleep $RETRY_INTERVAL
    continue
  fi

  task_pub_ip=$( $AWS_CMD ec2 describe-network-interfaces \
    --network-interface-ids $eni_id \
    --query 'NetworkInterfaces[0].Association.PublicIp' \
    --output text 2>/dev/null )

  if [ -z "$task_pub_ip" ] || [ "$task_pub_ip" = "None" ]; then
    sleep $RETRY_INTERVAL
    continue
  fi

  echo "{ \"result\": \"$task_pub_ip\" }"
  exit 0
done

echo "Timed out waiting for public IP in cluster $CLUSTER_NAME" >&2
exit 1
