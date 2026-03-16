#!/bin/bash

echo "🎯 Guaranteed Alarm Trigger"
echo "============================"
echo ""
echo "This will invoke the function until we get 5+ exceptions"
echo "to guarantee the CloudWatch alarm fires."
echo ""

error_count=0
attempt=0

while [ $error_count -lt 5 ]; do
    attempt=$((attempt + 1))
    echo "Attempt $attempt (errors so far: $error_count)..."
    
    result=$(aws lambda invoke \
        --function-name FaultyFunction \
        --region us-east-1 \
        --log-type Tail \
        response-temp.json 2>&1)
    
    # Check if there was a function error
    if echo "$result" | grep -q "FunctionError"; then
        error_count=$((error_count + 1))
        echo "  ❌ Error! (Total: $error_count)"
    else
        echo "  ⚠️  No exception this time"
    fi
    
    sleep 0.5
done

rm -f response-temp.json

echo ""
echo "✅ Got $error_count errors!"
echo "⏰ Waiting 90 seconds for CloudWatch to process..."
sleep 90

echo ""
echo "📊 Alarm Status:"
aws cloudwatch describe-alarms \
    --alarm-names FaultyFunction-ErrorRate \
    --region us-east-1 \
    --query 'MetricAlarms[0].[AlarmName,StateValue,StateReason]' \
    --output table

echo ""
echo "🔗 View in console:"
echo "   https://console.aws.amazon.com/cloudwatch/home?region=us-east-1#alarmsV2:alarm/FaultyFunction-ErrorRate"
