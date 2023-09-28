#!/bin/bash

eval "$(jq -r '@sh "export cluster_name=\(.cluster_name) aws_region=\(.aws_region)"')"
count=$( aws ecs list-tasks --cluster $cluster_name --region $aws_region | jq '.taskArns | length' )

echo "{\"count\": \"$count\"}" | jq
