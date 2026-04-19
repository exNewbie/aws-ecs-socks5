#!/bin/bash

PUB_IP=$( curl -s ifconfig.io )
HOSTED_ZONE=$1
RECORD_NAME=$2
TMP_JSON=/tmp/rs.json
echo "{ \"Changes\": [ { \"Action\": \"UPSERT\", \"ResourceRecordSet\": { \"Name\": \"${RECORD_NAME}\", \"Type\": \"A\", \"TTL\": 10, \"ResourceRecords\": [ { \"Value\": \"${PUB_IP}\" } ] } } ] }" > $TMP_JSON

aws route53 change-resource-record-sets --hosted-zone-id $HOSTED_ZONE --change-batch file://$TMP_JSON

rm $TMP_JSON
