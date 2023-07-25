#!/bin/bash

secrets=$(aws secretsmanager get-secret-value --secret-id "$AWS_SECRET_NAME" --query SecretString --output text)

export DB_PASSWORD=$(echo $secrets | jq .DB_PASSWORD -r)
export JWT_SECRET=$(echo $secrets | jq .JWT_SECRET -r)
export MAIL_PASSWORD=$(echo $secrets | jq .MAIL_PASSWORD -r)
