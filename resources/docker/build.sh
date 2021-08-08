#!/bin/bash

set -eu -o pipefail

main()
{
  AWS_ACCOUNT_ID=$( aws sts get-caller-identity | jq -r .Account )
  IMAGE="${AWS_ACCOUNT_ID}.dkr.ecr.ap-southeast-2.amazonaws.com/update-dns"
  image_tag="${IMAGE}:latest"

  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip

  docker build --compress --squash --rm -t $image_tag .

  aws ecr get-login-password \
    | docker login --username AWS --password-stdin \
    ${AWS_ACCOUNT_ID}.dkr.ecr.ap-southeast-2.amazonaws.com
  
  if ( ! aws ecr list-images --repository-name update-dns 2> /dev/null ); then
    echo "Creating the repository on ECR..."
    aws ecr create-repository --repository-name update-dns > /dev/null
  fi

  docker push ${image_tag}
  rm -rf aws awscliv2.zip
}

main "$@"
