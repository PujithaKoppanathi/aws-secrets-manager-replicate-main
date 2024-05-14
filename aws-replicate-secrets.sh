#!/bin/bash

#ensure proper ./aws/config file is present on Jenkins to leverage the IAM role for authentication

testarray=($(curl -s https://raw.github.com/org/repo/account-list | jq -r 'keys|.[]'))

for i in ${testarray[@]}
do
        profileName=$(echo $i | sed 's/team.-//')
        echo $profileName

         aws secretsmanager replicate-secret-to-regions --secret-id Devops/Github/Access_Token --add-replica-regions Region=ap-southeast-2 Region=eu-central-1 Region=ap-northeast-1 Region=us-east-2 Region=eu-west-2 --profile $profileName --region us-east-1

         aws secretsmanager replicate-secret-to-regions --secret-id Devops/Github/Pipeline --add-replica-regions Region=ap-southeast-2 Region=eu-central-1 Region=ap-northeast-1 Region=us-east-2 Region=eu-west-2 --profile $profileName --region us-east-1

         aws secretsmanager replicate-secret-to-regions --secret-id Devops/Github/Cron --add-replica-regions Region=ap-southeast-2 Region=eu-central-1 Region=ap-northeast-1 Region=us-east-2 Region=eu-west-2 --profile $profileName --region us-east-1

done
