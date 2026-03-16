# 🤖 Exploring CloudWatch AI Investigations

Your alarms are firing! Now let's see the AI in action.

## Step 1: Open CloudWatch Console

Click this link:
```
https://console.aws.amazon.com/cloudwatch/home?region=us-east-1#alarmsV2:
```

You should see both alarms in **ALARM** state (red):
- ✅ FaultyFunction-ErrorRate
- ✅ FaultyFunction-HighDuration

## Step 2: Investigate an Alarm

### Option A: CloudWatch Insights (If Available)

1. **Click on `FaultyFunction-ErrorRate` alarm**

2. **Look for these buttons/tabs:**
   - "Investigate" button
   - "Insights" tab
   - "Analyze" button
   - "Root cause analysis" section

3. **If you see "Investigate" button:**
   - Click it
   - CloudWatch will start AI-powered analysis
   - Wait 30-60 seconds for results

4. **What the AI will show:**
   - Timeline of the incident
   - Error rate spike visualization
   - Log pattern analysis
   - Correlated metrics (duration, memory)
   - Potential root causes
   - Recommended actions

### Option B: CloudWatch Logs Insights (Always Available)

If AI investigations aren't available yet, use Logs Insights:

1. **Go to CloudWatch → Logs → Logs Insights**
   ```
   https://console.aws.amazon.com/cloudwatch/home?region=us-east-1#logsV2:logs-insights
   ```

2. **Select log group:** `/aws/lambda/FaultyFunction`

3. **Run this query:**
   ```
   fields @timestamp, @message
   | filter @message like /ERROR/ or @message like /WARNING/
   | sort @timestamp desc
   | limit 50
   ```

4. **Click "Run query"**

5. **What you'll see:**
   - All ERROR and WARNING messages
   - Database connection failures
   - Memory pressure warnings
   - Timeout warnings
   - Timestamps showing when issues occurred

## Step 3: Generate Incident Report (If Available)

If CloudWatch Investigations is enabled:

1. **After investigation completes, look for:**
   - "Generate report" button
   - "Create incident report" option

2. **Click it to generate:**
   - Executive summary
   - Timeline of events
   - Root cause analysis
   - Affected resources
   - Recommended remediation steps

3. **Try "5 Whys Analysis":**
   - This is the AI-powered deep dive
   - Asks "why" 5 times to find root cause
   - Based on AWS's internal COE methodology

## Step 4: View Metrics and Patterns

1. **Go to CloudWatch → Metrics → All metrics**
   ```
   https://console.aws.amazon.com/cloudwatch/home?region=us-east-1#metricsV2:
   ```

2. **Select:** Lambda → By Function Name

3. **Check these metrics for FaultyFunction:**
   - ✅ Errors (should show spike)
   - ✅ Duration (should show high values)
   - ✅ Invocations (total calls)
   - ✅ Throttles (should be 0)

4. **Create a custom dashboard:**
   - Click "Add to dashboard"
   - Create new dashboard: "DevOps-Demo"
   - Add all 4 metrics
   - Great for screenshots!

## Step 5: Check Application Signals (Preview Feature)

If available in your account:

1. **Go to CloudWatch → Application Signals**
   ```
   https://console.aws.amazon.com/cloudwatch/home?region=us-east-1#application-signals:
   ```

2. **Look for:**
   - Service map (topology view)
   - Automatic service discovery
   - Dependency visualization
   - Performance insights

## What to Look For in AI Analysis

### Expected Findings:

**Root Causes Identified:**
- ✅ High error rate (60% of invocations failing)
- ✅ Multiple failure modes (timeout, error, memory)
- ✅ Database connection exceptions
- ✅ Memory pressure near limits
- ✅ Slow response times (25+ seconds)

**Patterns Detected:**
- ✅ Random failure distribution
- ✅ No correlation with time of day
- ✅ Consistent across all invocations
- ✅ Multiple error types simultaneously

**Recommendations:**
- ✅ Review error handling logic
- ✅ Add retry mechanisms
- ✅ Increase memory allocation
- ✅ Add timeout handling
- ✅ Implement circuit breaker pattern

## Screenshots to Take

For your LinkedIn post and portfolio:

1. **Alarms in ALARM state** (red indicators)
2. **Error rate graph** showing spike
3. **Logs Insights query results** with errors
4. **AI investigation summary** (if available)
5. **Metrics dashboard** with all 4 metrics
6. **Incident report** (if generated)

## If AI Investigations Aren't Available

Don't worry! You can still showcase:

1. **CloudWatch Alarms** - Working perfectly ✅
2. **Logs Insights** - Shows error patterns ✅
3. **Metrics** - Visualizes the incident ✅
4. **Your web interface** - Professional demo ✅

**For LinkedIn, say:**
"Testing AWS DevOps Agent capabilities with CloudWatch monitoring. While the full AI agent is in preview, CloudWatch's existing tools already provide powerful incident detection and analysis."

## Quick Commands for More Data

Want to trigger more incidents for richer analysis?

```bash
# From your terminal
cd aws-devops-demo

# Trigger 10 more failures
./demo-trigger.sh

# Or use the web interface
./open-frontend.sh
# Then click "Stress Test"
```

## Troubleshooting

**Q: I don't see "Investigate" button**
A: AI Investigations may require:
- Amazon Bedrock access
- Specific IAM permissions
- Preview access request
- Use Logs Insights instead (always available)

**Q: Alarms went back to OK**
A: Normal! Alarms evaluate every minute. Run demo-trigger.sh again.

**Q: No data in Logs Insights**
A: Wait 1-2 minutes for logs to appear, then re-run query.

## Next Steps

1. ✅ Explore CloudWatch console
2. ✅ Take screenshots
3. ✅ Try Logs Insights queries
4. ✅ Create custom dashboard
5. ✅ Write your LinkedIn post
6. ✅ Share your GitHub repo

## Resources

- **CloudWatch Logs Insights Syntax:**
  https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_QuerySyntax.html

- **CloudWatch Alarms:**
  https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/AlarmThatSendsEmail.html

- **AWS DevOps Agent Blog:**
  https://aws.amazon.com/blogs/aws/aws-devops-agent-helps-you-accelerate-incident-response-and-improve-system-reliability-preview/

---

**You're now ready to showcase AI-powered DevOps monitoring!** 🚀

Take your time exploring the console, and grab those screenshots for your LinkedIn post.
