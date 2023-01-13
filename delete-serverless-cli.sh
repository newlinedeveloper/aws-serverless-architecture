#!/bin/bash

# Delete DynamoDB table
aws dynamodb delete-table --table-name example-table

# Detach permissions from IAM role
aws iam detach-role-policy --role-name example-lambda-role --policy-arn arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess

# Delete IAM role
aws iam delete-role --role-name example-lambda-role

# Delete Lambda function
aws lambda delete-function --function-name example-lambda

# Delete deployment
aws apigateway delete-deployment --rest-api-id <REST_API_ID> --deployment-id <DEPLOYMENT_ID>

# Delete integration response
aws apigateway delete-integration-response --rest-api-id <REST_API_ID> --resource-id <RESOURCE_ID> --http-method POST --status-code 201

# Delete method response
aws apigateway delete-method-response --rest-api-id <REST_API_ID> --resource-id <RESOURCE_ID> --http-method POST --status-code 201

# Delete integration
aws apigateway delete-integration --rest-api-id <REST_API_ID> --resource-id <RESOURCE_ID> --http-method POST

# Delete method
aws apigateway delete-method --rest-api-id <REST_API_ID> --resource-id <RESOURCE_ID> --http-method POST

# Delete resource
aws apigateway delete-resource --rest-api-id <REST_API_ID> --resource-id <RESOURCE_ID>

# Delete RestApi
aws apigateway delete-rest-api --rest-api-id <REST_API_ID>
