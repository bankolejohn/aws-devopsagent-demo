#!/bin/bash

echo "🧪 Testing AWS DevOps Demo Functions"
echo "======================================"
echo ""

# Test healthy function
echo "Testing HealthyFunction (should succeed)..."
aws lambda invoke --function-name HealthyFunction --log-type Tail response-healthy.json
cat response-healthy.json
echo -e "\n"

# Test faulty function multiple times to trigger alarms
echo "Testing FaultyFunction (will trigger various failures)..."
for i in {1..5}; do
    echo "Attempt $i/5..."
    aws lambda invoke --function-name FaultyFunction --log-type Tail response-faulty-$i.json 2>/dev/null || true
    sleep 1
done

echo ""
echo "✅ Tests complete!"
echo "📊 Check CloudWatch for alarms and metrics"
echo "   Console: https://console.aws.amazon.com/cloudwatch"
