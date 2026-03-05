#!/bin/bash

echo "🔍 AWS DevOps Agent & CloudWatch AI Setup Helper"
echo "=================================================="
echo ""

# Check current region
REGION=$(aws configure get region)
echo "Current AWS Region: $REGION"
echo ""

# Check if CloudWatch Application Signals is available
echo "📊 Checking CloudWatch Application Signals..."
aws cloudwatch describe-insight-rules --region $REGION 2>/dev/null
if [ $? -eq 0 ]; then
    echo "✓ CloudWatch API accessible"
else
    echo "⚠ CloudWatch API check failed"
fi
echo ""

# Check alarm status
echo "🚨 Current Alarm Status:"
aws cloudwatch describe-alarms \
    --alarm-names FaultyFunction-ErrorRate FaultyFunction-HighDuration \
    --region $REGION \
    --query 'MetricAlarms[*].[AlarmName,StateValue,StateReason]' \
    --output table
echo ""

# Check Lambda function metrics
echo "📈 Recent Lambda Errors (last 5 minutes):"
aws cloudwatch get-metric-statistics \
    --namespace AWS/Lambda \
    --metric-name Errors \
    --dimensions Name=FunctionName,Value=FaultyFunction \
    --start-time $(date -u -v-5M +%Y-%m-%dT%H:%M:%S) \
    --end-time $(date -u +%Y-%m-%dT%H:%M:%S) \
    --period 300 \
    --statistics Sum \
    --region $REGION \
    --query 'Datapoints[*].[Timestamp,Sum]' \
    --output table
echo ""

echo "🔗 Quick Links:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "CloudWatch Console:"
echo "  https://console.aws.amazon.com/cloudwatch/home?region=$REGION"
echo ""
echo "CloudWatch Alarms:"
echo "  https://console.aws.amazon.com/cloudwatch/home?region=$REGION#alarmsV2:"
echo ""
echo "Lambda Functions:"
echo "  https://console.aws.amazon.com/lambda/home?region=$REGION#/functions"
echo ""
echo "AWS DevOps Agent (Preview):"
echo "  https://console.aws.amazon.com/devops-agent/"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📖 Next Steps:"
echo "1. Open SETUP_DEVOPS_AGENT.md for detailed instructions"
echo "2. Visit CloudWatch console to enable Application Signals"
echo "3. Check if AWS DevOps Agent is available in your region"
echo "4. Run ./test-functions.sh to generate more incidents"
