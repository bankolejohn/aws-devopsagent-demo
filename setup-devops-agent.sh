#!/bin/bash

set -e

echo "🤖 AWS DevOps Agent Setup"
echo "=========================="
echo ""

# Get AWS account ID
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
echo "AWS Account ID: $ACCOUNT_ID"
echo "Region: us-east-1"
echo ""

# Check if service model exists
if [ ! -f "devopsagent.json" ]; then
    echo "📥 Downloading AWS DevOps Agent service model..."
    curl -s -o devopsagent.json https://d1co8nkiwcta1g.cloudfront.net/devopsagent.json
    echo "✓ Downloaded service model"
fi

# Add model to AWS CLI
echo ""
echo "🔧 Configuring AWS CLI for DevOps Agent..."
aws configure add-model --service-model "file://${PWD}/devopsagent.json" --service-name devopsagent 2>/dev/null || echo "Model already configured"

# Test CLI
echo ""
echo "🧪 Testing DevOps Agent CLI..."
if aws devopsagent help &>/dev/null; then
    echo "✓ DevOps Agent CLI is working"
else
    echo "❌ DevOps Agent CLI test failed"
    exit 1
fi

echo ""
echo "📋 Creating IAM roles..."
echo ""

# Create AgentSpace trust policy
cat > devops-agentspace-trust-policy.json << EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "aidevops.amazonaws.com"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "aws:SourceAccount": "${ACCOUNT_ID}"
        },
        "ArnLike": {
          "aws:SourceArn": "arn:aws:aidevops:us-east-1:${ACCOUNT_ID}:agentspace/*"
        }
      }
    }
  ]
}
EOF

# Create AgentSpace role
echo "Creating DevOpsAgentRole-AgentSpace..."
aws iam create-role \
  --region us-east-1 \
  --role-name DevOpsAgentRole-AgentSpace \
  --assume-role-policy-document file://devops-agentspace-trust-policy.json 2>/dev/null || echo "Role already exists"

# Attach managed policy
aws iam attach-role-policy \
  --role-name DevOpsAgentRole-AgentSpace \
  --policy-arn arn:aws:iam::aws:policy/AIOpsAssistantPolicy 2>/dev/null || echo "Policy already attached"

# Create inline policy
cat > devops-agentspace-inline-policy.json << 'EOF'
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowAwsSupportActions",
      "Effect": "Allow",
      "Action": [
        "support:CreateCase",
        "support:DescribeCases"
      ],
      "Resource": ["*"]
    },
    {
      "Sid": "AllowExpandedAIOpsAssistantPolicy",
      "Effect": "Allow",
      "Action": [
        "aidevops:GetKnowledgeItem",
        "aidevops:ListKnowledgeItems",
        "eks:AccessKubernetesApi",
        "synthetics:GetCanaryRuns",
        "route53:GetHealthCheckStatus",
        "resource-explorer-2:Search"
      ],
      "Resource": ["*"]
    }
  ]
}
EOF

aws iam put-role-policy \
  --role-name DevOpsAgentRole-AgentSpace \
  --policy-name AllowExpandedAIOpsAssistantPolicy \
  --policy-document file://devops-agentspace-inline-policy.json

AGENTSPACE_ROLE_ARN=$(aws iam get-role --role-name DevOpsAgentRole-AgentSpace --query 'Role.Arn' --output text)
echo "✓ AgentSpace Role ARN: $AGENTSPACE_ROLE_ARN"

# Create Operator trust policy
cat > devops-operator-trust-policy.json << EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "aidevops.amazonaws.com"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "aws:SourceAccount": "${ACCOUNT_ID}"
        },
        "ArnLike": {
          "aws:SourceArn": "arn:aws:aidevops:us-east-1:${ACCOUNT_ID}:agentspace/*"
        }
      }
    }
  ]
}
EOF

# Create Operator role
echo ""
echo "Creating DevOpsAgentRole-WebappAdmin..."
aws iam create-role \
  --role-name DevOpsAgentRole-WebappAdmin \
  --assume-role-policy-document file://devops-operator-trust-policy.json \
  --region us-east-1 2>/dev/null || echo "Role already exists"

OPERATOR_ROLE_ARN=$(aws iam get-role --role-name DevOpsAgentRole-WebappAdmin --query 'Role.Arn' --output text)
echo "✓ Operator Role ARN: $OPERATOR_ROLE_ARN"

echo ""
echo "✅ IAM roles created successfully!"
echo ""
echo "📝 Next steps:"
echo "1. Create an Agent Space:"
echo "   aws devopsagent create-agent-space \\"
echo "     --name demo-incident-response \\"
echo "     --agent-space-role-arn $AGENTSPACE_ROLE_ARN \\"
echo "     --operator-app-role-arn $OPERATOR_ROLE_ARN \\"
echo "     --region us-east-1"
echo ""
echo "2. Or use the AWS Console:"
echo "   https://console.aws.amazon.com/devops-agent/"
echo ""
echo "🔗 Save these ARNs for later:"
echo "   AgentSpace Role: $AGENTSPACE_ROLE_ARN"
echo "   Operator Role: $OPERATOR_ROLE_ARN"
