#!/bin/bash

set -e

echo "🚀 Deploying AWS DevOps Demo..."

# Check if SAM CLI is installed
if ! command -v sam &> /dev/null; then
    echo "❌ AWS SAM CLI not found. Installing via pip..."
    pip install aws-sam-cli
fi

# Build and deploy
echo "📦 Building SAM application..."
sam build

echo "🚢 Deploying to AWS..."
sam deploy \
    --stack-name aws-devops-demo \
    --capabilities CAPABILITY_IAM \
    --resolve-s3 \
    --no-confirm-changeset \
    --no-fail-on-empty-changeset

echo "✅ Deployment complete!"
echo ""
echo "📊 View CloudWatch Logs:"
echo "   aws logs tail /aws/lambda/FaultyFunction --follow"
echo ""
echo "🧪 Test the functions:"
echo "   aws lambda invoke --function-name HealthyFunction response.json"
echo "   aws lambda invoke --function-name FaultyFunction response.json"
