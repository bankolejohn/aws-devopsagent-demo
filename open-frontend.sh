#!/bin/bash

echo "🌐 Opening AWS DevOps Demo Frontend"
echo "===================================="
echo ""
echo "API Endpoints:"
echo "  Healthy: https://ddf1r5yl7e.execute-api.us-east-1.amazonaws.com/prod/healthy"
echo "  Faulty:  https://ddf1r5yl7e.execute-api.us-east-1.amazonaws.com/prod/faulty"
echo ""
echo "Opening frontend in your browser..."
echo ""

# Open the HTML file in default browser
open frontend/index.html

echo "✅ Frontend opened!"
echo ""
echo "💡 Tips:"
echo "  - Click 'Test Healthy Function' to see successful responses"
echo "  - Click 'Test Faulty Function' to trigger random failures"
echo "  - Click 'Stress Test' to trigger CloudWatch alarms"
echo ""
echo "📊 Monitor incidents:"
echo "  https://console.aws.amazon.com/cloudwatch/home?region=us-east-1#alarmsV2:"
