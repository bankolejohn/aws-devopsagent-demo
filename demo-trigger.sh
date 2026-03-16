#!/bin/bash

echo "🎬 Simple Demo - Trigger Alarms"
echo "================================"
echo ""
echo "Improvements made:"
echo "  ✅ Error rate increased to 60% (was 25%)"
echo "  ✅ Alarm threshold lowered to 1 error (was 2)"
echo "  ✅ Duration threshold lowered to 10s (was 20s)"
echo ""
echo "Invoking Lambda 5 times directly..."
echo ""

for i in {1..5}; do
    echo "Invocation $i/5..."
    aws lambda invoke \
        --function-name FaultyFunction \
        --region us-east-1 \
        response-$i.json &>/dev/null
    sleep 1
done

echo ""
echo "✅ Invocations complete!"
echo ""
echo "⏰ Waiting 90 seconds for CloudWatch to evaluate alarms..."
echo "(CloudWatch aggregates metrics every 60 seconds)"
echo ""

# Show countdown
for i in {90..1}; do
    printf "\rTime remaining: %02d seconds" $i
    sleep 1
done
printf "\n\n"

echo "📊 Checking alarm status..."
echo ""

aws cloudwatch describe-alarms \
    --alarm-names FaultyFunction-ErrorRate FaultyFunction-HighDuration \
    --region us-east-1 \
    --query 'MetricAlarms[*].[AlarmName,StateValue,StateReason]' \
    --output table

echo ""
echo "🔗 View in CloudWatch Console:"
echo "   https://console.aws.amazon.com/cloudwatch/home?region=us-east-1#alarmsV2:"
echo ""
echo "💡 If alarms aren't in ALARM state yet:"
echo "   - Run this script again (more data helps)"
echo "   - Wait another minute and check console"
echo "   - CloudWatch can take 2-3 minutes total"
