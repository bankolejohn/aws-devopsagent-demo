# AWS DevOps Agent - Console Setup Guide

Since the CLI is in preview and may have issues, let's use the AWS Console (recommended approach).

## Step 1: Trigger Some Incidents First

Run this to generate failures for the agent to investigate:

```bash
cd aws-devops-demo
./test-functions.sh
```

Wait 2-3 minutes, then run it again:
```bash
./test-functions.sh
```

This creates incident patterns for the DevOps Agent to analyze.

## Step 2: Access DevOps Agent Console

1. Open your browser and go to:
   ```
   https://us-east-1.console.aws.amazon.com/devops-agent/home?region=us-east-1
   ```

2. If you see "Service not available" or access denied:
   - The service might not be publicly available yet in preview
   - You may need to request preview access
   - Check AWS announcements for availability

## Step 3: Alternative - Use CloudWatch Investigations (Available Now)

CloudWatch AI-powered investigations are generally available and work similarly:

### Enable CloudWatch Application Signals

1. Go to CloudWatch Console:
   ```
   https://console.aws.amazon.com/cloudwatch/home?region=us-east-1
   ```

2. Navigate to: **Application Signals** (left sidebar under "Insights")

3. Click **Get started** or **Enable Application Signals**

### View Your Alarms

1. Go to: **Alarms** → **All alarms**

2. You should see:
   - `FaultyFunction-ErrorRate`
   - `FaultyFunction-HighDuration`

3. Check their status - they should be in ALARM state after running tests

### Start an Investigation

1. Click on an alarm that's in ALARM state

2. Look for **Investigate** or **Analyze** button

3. CloudWatch will:
   - Analyze logs and metrics
   - Correlate recent changes
   - Identify patterns
   - Suggest root causes

### Generate Incident Report

1. Once investigation completes, click **Generate report**

2. Review the AI-generated analysis:
   - Timeline of events
   - Correlated metrics
   - Log patterns
   - Recommended actions

3. Try the **5 Whys Analysis** feature for deeper investigation

## Step 4: Check Alarm Status

```bash
cd aws-devops-demo
aws cloudwatch describe-alarms \
  --alarm-names FaultyFunction-ErrorRate FaultyFunction-HighDuration \
  --region us-east-1 \
  --query 'MetricAlarms[*].[AlarmName,StateValue,StateReason]' \
  --output table
```

## Step 5: View Lambda Logs

```bash
# View recent errors
aws logs tail /aws/lambda/FaultyFunction --follow --region us-east-1
```

## Troubleshooting

### DevOps Agent Not Available
- **Preview Access**: AWS DevOps Agent is in limited preview
- **Request Access**: Contact AWS support or your account manager
- **Alternative**: Use CloudWatch Investigations (available now)

### No Alarms Triggering
- Run `./test-functions.sh` multiple times
- Wait 2-3 minutes between runs
- Check CloudWatch metrics to verify errors are being recorded

### CloudWatch Investigations Not Showing
- Ensure you're in us-east-1 region
- Check IAM permissions for CloudWatch and Bedrock
- Enable Application Signals first

## What to Expect

### CloudWatch Investigations Will Show:
- Error rate spikes
- Duration anomalies
- Memory usage patterns
- Correlation with deployments
- Log error patterns

### AI Analysis Will Provide:
- Root cause hypothesis
- Timeline of events
- Affected resources
- Recommended remediation
- Historical pattern analysis

## Next Steps

1. **Generate more incidents** - Run test script multiple times
2. **Review investigations** - Check CloudWatch console
3. **Document findings** - Take screenshots for your LinkedIn post
4. **Experiment** - Try different failure scenarios

## Cost Note

- CloudWatch Investigations: ~$0.10 per investigation
- First few investigations may be free tier eligible
- Total cost for demo: < $1.00

## Resources

- [CloudWatch Investigations Docs](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Insights-Investigations.html)
- [AWS DevOps Agent Blog](https://aws.amazon.com/blogs/aws/aws-devops-agent-helps-you-accelerate-incident-response-and-improve-system-reliability-preview/)
