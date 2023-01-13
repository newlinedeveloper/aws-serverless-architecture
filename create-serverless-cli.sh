#!/bin/bash

# Create DynamoDB table
aws dynamodb create-table --table-name example-table --attribute-definitions AttributeName=id,attributeType=S --key-schema AttributeName=id,KeyType=HASH --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1

# Create IAM role
aws iam create-role --role-name example-lambda-role --assume-role-policy-document '{"Version":"2012-10-17","Statement":[{"Effect":"Allow","Principal":{"Service":["lambda.amazonaws.com"]},"Action":["sts:AssumeRole"]}]}'

# Attach permissions to IAM role
aws iam attach-role-policy --role-name example-lambda-role --policy-arn arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess

# Create Lambda function
aws lambda create-function --function-name example-lambda --runtime python3.8 --role arn:aws:iam::<YOUR_ACCOUNT_ID>:role/example-lambda-role --handler index.handler --zip-file fileb://path/to/lambda.zip

# Create API Gateway
aws apigateway create-rest-api --name example-api

# Create resource in API Gateway
aws apigateway create-resource --rest-api-id <REST_API_ID> --parent-id <PARENT_RESOURCE_ID> --path-part example

# Create method for resource
aws apigateway put-method --rest-api-id <REST_API_ID> --resource-id <RESOURCE_ID> --http-method POST --authorization-type NONE

# Create integration for method
aws apigateway put-integration --rest-api-id <REST_API_ID> --resource-id <RESOURCE_ID> --http-method POST --type AWS --integration-http-method POST --uri arn:aws:apigateway:<REGION>:lambda:path/2015-03-31/functions/arn:aws:lambda:<REGION>:<YOUR_ACCOUNT_ID>:function:example-lambda/invocations

# Create method response for method
aws apigateway put-method-response --rest-api-id <REST_API_ID> --resource-id <RESOURCE_ID> --http-method POST --status-code 201 --response-models '{"application/json": "Empty"}'

# Create integration response for method
aws apigateway put-integration-response --rest-api-id <REST_API_ID> --resource-id <RESOURCE_ID> --http-method POST --status-code 201 --response-templates '{"application/json": ""}'

# Create deployment for API Gateway
aws apigateway create-deployment --rest-api-id <REST_API_ID> --stage-name prod
