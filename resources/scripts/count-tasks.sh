#!/bin/bash

AWS_PROFILE=$1

eval "$(jq -r '@sh "export cluster_name=\(.cluster_name) aws_region=\(.aws_region)"')"
count=$( aws --profile ${AWS_PROFILE} ecs list-tasks --cluster $cluster_name --region $aws_region | jq '.taskArns | length' )

echo "{\"count\": \"$count\"}" | jq

