# Setting Up AWS DevOps Agent & CloudWatch AI Investigations

## Prerequisites
- AWS Console access
- Lambda functions deployed (✓ Already done)
- CloudWatch alarms configured (✓ Already done)

## Part 1: Enable CloudWatch AI-Powered Investigations

### Step 1: Enable CloudWatch Application Signals
1. Go to AWS Console → CloudWatch
2. Navigate to **Application Signals** (left sidebar under "Insights")
3. Click **Get started** or **Enable Application Signals**
4. Select your region: `us-east-1`
5. Click **Enable**

### Step 2: Configure CloudWatch Investigations
1. In CloudWatch console, go to **Alarms** → **All alarms**
2. You should see:
   - `FaultyFunction-ErrorRate`
   - `FaultyFunction-HighDuration`
3. Click on an alarm that's in ALARM state
4. Look for **Investigate** button (AI-powered feature)
5. Click **Investigate** to start AI analysis

### Step 3: Generate Incident Reports
Once an investigation is running:
1. CloudWatch will analyze metrics, logs, and recent changes
2. Click **Generate incident report** when investigation completes
3. Review the AI-generated root cause analysis
4. Use **5 Whys Analysis** feature to dig deeper

**Note:** CloudWatch Investigations uses generative AI and may require:
- Amazon Bedrock access in your account
- Appropriate IAM permissions for AI features

## Part 2: Set Up AWS DevOps Agent (Preview)

### Step 1: Access DevOps Agent Console
1. Go to AWS Console
2. Search for **"AWS DevOps Agent"** in the services search bar
3. Or navigate directly: https://console.aws.amazon.com/devops-agent/

**Important:** AWS DevOps Agent is in preview and may not be available in all regions yet. Check availability at: https://aws.amazon.com/devops-agent/

### Step 2: Create an Agent Space
1. Click **Create Agent Space**
2. Configure:
   - **Name:** `demo-incident-response`
   - **Description:** `Automated incident response for demo Lambda functions`
3. **IAM Role Configuration:**
   - Choose **Create new role** (recommended)
   - Grant permissions for:
     - CloudWatch (read logs, metrics, alarms)
     - Lambda (describe functions, get configurations)
     - CloudFormation (describe stacks)
4. **Enable Web App:** Check this box for UI access
5. Click **Create**

### Step 3: Connect Observability Tools
1. In your Agent Space, go to **Integrations** tab
2. Add **Amazon CloudWatch:**
   - Select region: `us-east-1`
   - Grant access to log groups: `/aws/lambda/*`
   - Enable metric access
3. Click **Connect**

### Step 4: Configure Application Topology
1. Go to **Topology** tab
2. Click **Discover resources**
3. Select:
   - CloudFormation stack: `aws-devops-demo`
   - Lambda functions: `HealthyFunction`, `FaultyFunction`
4. Click **Add to topology**

The agent will automatically map:
- Function dependencies
- CloudWatch alarms
- Recent deployments
- Log patterns

### Step 5: Set Up Incident Response
1. Go to **Incident Management** tab
2. Configure **Automatic Response:**
   - Trigger: CloudWatch Alarm state change to ALARM
   - Actions: Investigate and correlate data
3. **Optional - Slack Integration:**
   - Add Slack webhook URL for notifications
   - Agent will post investigation updates to channel

### Step 6: Test the Agent
1. Trigger more failures:
   ```bash
   cd aws-devops-demo
   ./test-functions.sh
   ```
2. Wait for alarms to trigger (1-2 minutes)
3. Go to DevOps Agent console → **Investigations**
4. You should see an active investigation
5. Review the agent's findings:
   - Root cause analysis
   - Correlated metrics and logs
   - Recommended mitigations
   - Timeline of events

## Part 3: Advanced Configuration (Optional)

### Connect GitHub/GitLab for Deployment Tracking
1. In Agent Space, go to **Integrations**
2. Add **GitHub** or **GitLab**
3. Provide repository access
4. Agent will correlate deployments with incidents

### Configure Slack Notifications
1. Create Slack webhook: https://api.slack.com/messaging/webhooks
2. In Agent Space → **Notifications**
3. Add webhook URL
4. Configure notification triggers

### Enable Proactive Monitoring
1. Go to **Settings** → **Proactive Analysis**
2. Enable **Pattern Detection**
3. Agent will analyze historical incidents and suggest preventive measures

## Verification

### Check CloudWatch Investigations
```bash
# View recent investigations
aws cloudwatch describe-insight-rules --region us-east-1

# Check alarm history
aws cloudwatch describe-alarm-history \
  --alarm-name FaultyFunction-ErrorRate \
  --region us-east-1
```

### Monitor DevOps Agent Activity
- Console: https://console.aws.amazon.com/devops-agent/
- Check **Investigations** tab for active/completed investigations
- Review **Insights** for patterns and recommendations

## Troubleshooting

### CloudWatch Investigations Not Available
- Ensure you're in a supported region (us-east-1, us-west-2, eu-west-1)
- Check IAM permissions for Bedrock access
- Verify Application Signals is enabled

### DevOps Agent Not Available
- AWS DevOps Agent is in preview (as of 2025)
- May require preview access request
- Check AWS announcements for general availability

### No Investigations Triggered
- Ensure alarms are in ALARM state
- Check Agent Space has correct permissions
- Verify topology includes your Lambda functions

## Cost Considerations

- CloudWatch Investigations: Charged per investigation
- AWS DevOps Agent: Preview pricing TBD
- CloudWatch Logs: Standard ingestion/storage rates
- Lambda invocations: Free tier eligible

## Next Steps

1. Generate more diverse failure patterns
2. Review AI-generated incident reports
3. Set up automated remediation actions
4. Integrate with your CI/CD pipeline
5. Configure custom investigation rules
