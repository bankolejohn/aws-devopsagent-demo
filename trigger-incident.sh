#!/bin/bash

echo "🔥 Triggering Incident - Multiple Rapid Failures"
echo "================================================"
echo ""

# Run 10 invocations rapidly to trigger alarms
for i in {1..10}; do
    echo "Invocation $i/10..."
    aws lambda invoke \
        --function-name FaultyFunction \
        --region us-east-1 \
        --log-type Tail \
        response-$i.json &>/dev/null &
done

echo ""
echo "⏳ Waiting for invocations to complete..."
wait

echo "✅ All invocations complete!"
echo ""
echo "📊 Checking alarm status in 60 seconds..."
sleep 60

aws cloudwatch describe-alarms \
    --alarm-names FaultyFunction-ErrorRate FaultyFunction-HighDuration \
    --region us-east-1 \
    --query 'MetricAlarms[*].[AlarmName,StateValue,StateReason]' \
    --output table

echo ""
echo "🔗 View in CloudWatch Console:"
echo "   https://console.aws.amazon.com/cloudwatch/home?region=us-east-1#alarmsV2:"
echo ""
echo "📝 Next: Check CloudWatch Logs for error patterns"
echo "   aws logs tail /aws/lambda/FaultyFunction --follow --region us-east-1"
