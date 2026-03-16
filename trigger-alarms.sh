#!/bin/bash

echo "🚨 Triggering CloudWatch Alarms"
echo "================================"
echo ""
echo "This script invokes Lambda directly (not through API Gateway)"
echo "to ensure CloudWatch metrics are recorded properly."
echo ""

# Invoke Lambda directly 15 times to trigger error alarm
for i in {1..15}; do
    echo "Direct invocation $i/15..."
    aws lambda invoke \
        --function-name FaultyFunction \
        --region us-east-1 \
        --log-type Tail \
        /dev/null &>/dev/null &
done

echo ""
echo "⏳ Waiting for invocations to complete..."
wait

echo "✅ All invocations complete!"
echo ""
echo "⏰ Waiting 90 seconds for CloudWatch to aggregate metrics..."
sleep 90

echo ""
echo "📊 Checking alarm status..."
aws cloudwatch describe-alarms \
    --alarm-names FaultyFunction-ErrorRate FaultyFunction-HighDuration \
    --region us-east-1 \
    --query 'MetricAlarms[*].[AlarmName,StateValue,StateReason]' \
    --output table

echo ""
echo "🔗 View in CloudWatch Console:"
echo "   https://console.aws.amazon.com/cloudwatch/home?region=us-east-1#alarmsV2:"
echo ""
echo "💡 The web interface is great for demos, but direct Lambda invocations"
echo "   are better for triggering CloudWatch alarms quickly."
