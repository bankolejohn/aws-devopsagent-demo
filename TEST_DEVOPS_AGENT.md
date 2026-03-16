# 🤖 Testing AWS DevOps Agent

You've created a DevOps Agent! Let's put it to work.

## Current Status

✅ DevOps Agent Space created in your account
✅ Lambda functions deployed and failing
✅ CloudWatch alarms in ALARM state
✅ Ready to test autonomous investigation

## Step 1: Verify Agent Space Configuration

1. **Open DevOps Agent Console:**
   ```
   https://console.aws.amazon.com/devops-agent/home?region=us-east-1
   ```

2. **Check your Agent Space:**
   - Name: (whatever you named it)
   - Status: Should be "Active"
   - IAM roles: Configured
   - Web app: Enabled (if you chose that option)

## Step 2: Connect Agent to Your Resources

### Add CloudWatch Integration

1. **In your Agent Space, go to "Integrations" or "Data Sources"**

2. **Add CloudWatch:**
   - Region: us-east-1
   - Log groups: `/aws/lambda/FaultyFunction`
   - Metrics: Enable Lambda metrics
   - Alarms: Enable alarm monitoring

3. **Save the integration**

### Add Lambda Functions to Topology

1. **Go to "Topology" or "Resources" tab**

2. **Add resources:**
   - CloudFormation stack: `aws-devops-demo`
   - Or manually add:
     - Lambda: `FaultyFunction`
     - Lambda: `HealthyFunction`
     - CloudWatch Alarms: Both alarms

3. **Let the agent discover:**
   - Click "Discover resources" or "Auto-discover"
   - Agent will map dependencies automatically

## Step 3: Trigger a New Incident

Let's give the agent something fresh to investigate:

```bash
cd aws-devops-demo

# Clear old alarms (optional)
# Wait for alarms to go back to OK state, or just trigger new ones

# Trigger fresh incident
./demo-trigger.sh
```

Or use the web interface:
```bash
./open-frontend.sh
# Click "Stress Test" button
```

## Step 4: Watch the Agent Investigate

### Automatic Investigation

1. **Go to Agent Space → "Investigations" tab**

2. **You should see:**
   - New investigation started automatically
   - Status: "In Progress" or "Analyzing"
   - Triggered by: CloudWatch alarm state change

3. **Watch in real-time:**
   - Agent correlating logs and metrics
   - Analyzing error patterns
   - Checking recent deployments
   - Building timeline

### Manual Investigation (Alternative)

If automatic doesn't trigger:

1. **Click "Start Investigation" or "New Investigation"**

2. **Select:**
   - Alarm: `FaultyFunction-ErrorRate`
   - Time range: Last 15 minutes
   - Resources: FaultyFunction

3. **Click "Investigate"**

## Step 5: Review Agent Findings

The agent should identify:

### Root Cause Analysis
- ✅ High error rate (60% failures)
- ✅ Multiple failure modes detected
- ✅ Database connection exceptions
- ✅ Memory pressure issues
- ✅ Timeout scenarios

### Correlated Data
- ✅ Error logs with "Database connection failed"
- ✅ Duration spikes to 25+ seconds
- ✅ Memory usage near 128MB limit
- ✅ No recent deployments (rules out deployment issues)

### Recommended Actions
- ✅ Review error handling in Lambda function
- ✅ Increase memory allocation
- ✅ Add retry logic for database connections
- ✅ Implement timeout handling
- ✅ Consider circuit breaker pattern

### Timeline
- ✅ When errors started
- ✅ Alarm trigger time
- ✅ Investigation start time
- ✅ Pattern detection

## Step 6: Test Agent Communication (If Slack Configured)

If you set up Slack integration:

1. **Check your Slack channel**
2. **Agent should post:**
   - Incident detected notification
   - Investigation progress updates
   - Root cause findings
   - Recommended actions

## Step 7: Generate Incident Report

1. **In the investigation view, look for:**
   - "Generate Report" button
   - "Export" option
   - "Create Incident Documentation"

2. **Click it to get:**
   - Executive summary
   - Technical details
   - Timeline visualization
   - Action items
   - Downloadable PDF/Markdown

## Step 8: Test "5 Whys" Analysis

This is the AI-powered deep dive:

1. **In investigation, find "5 Whys" or "Deep Analysis"**

2. **The agent will ask:**
   - Why 1: Why did the function fail?
     - Answer: Database connection errors
   - Why 2: Why did database connections fail?
     - Answer: Simulated error in code
   - Why 3: Why is there a simulated error?
     - Answer: Demo/testing scenario
   - Why 4: Why use simulated errors?
     - Answer: To test monitoring capabilities
   - Why 5: Why test monitoring?
     - Answer: To validate AI-powered incident response

3. **Agent provides:**
   - Root cause chain
   - Systemic issues identified
   - Prevention recommendations

## What Makes This Impressive

### Traditional Approach (Manual):
1. Get paged at 3 AM ⏰
2. Check logs manually 📋
3. Look at metrics 📊
4. Correlate events 🔍
5. Find root cause 🎯
6. Write incident report 📝
**Time: 2-4 hours**

### With DevOps Agent (Automated):
1. Agent detects alarm 🤖
2. Automatically investigates 🔍
3. Correlates all data 📊
4. Identifies root cause 🎯
5. Generates report 📝
6. Suggests fixes 💡
**Time: 2-5 minutes**

## Screenshots to Take

For maximum LinkedIn impact:

1. **Agent Space dashboard** - Shows it's active
2. **Investigation in progress** - Real-time analysis
3. **Root cause findings** - AI conclusions
4. **Timeline visualization** - Event correlation
5. **Recommended actions** - AI suggestions
6. **Incident report** - Professional documentation
7. **Side-by-side comparison:**
   - Your web interface showing errors
   - Agent console showing investigation

## Testing Different Scenarios

Want to see how the agent handles different patterns?

### Scenario 1: Sustained Errors
```bash
# Run multiple times
./demo-trigger.sh
sleep 60
./demo-trigger.sh
```
Agent should detect: Ongoing incident, not transient

### Scenario 2: Error Spike Then Recovery
```bash
# Trigger errors
./demo-trigger.sh
# Wait 5 minutes (alarms go to OK)
# Agent should detect: Resolved incident
```

### Scenario 3: Web Interface Load
```bash
./open-frontend.sh
# Click "Stress Test" multiple times
# Agent should detect: High error rate from API Gateway
```

## Troubleshooting

**Q: Agent not starting investigations automatically**
A: Check:
- CloudWatch integration is connected
- Alarm notifications are enabled
- Agent has permissions to read CloudWatch
- Try manual investigation first

**Q: Agent can't access logs**
A: Verify:
- IAM role has CloudWatch Logs permissions
- Log group name is correct: `/aws/lambda/FaultyFunction`
- Region is us-east-1

**Q: No recommendations showing**
A: 
- Investigation may still be running (wait 2-3 minutes)
- Check if Bedrock access is enabled
- Try refreshing the page

## Success Criteria

You'll know it's working when:
- ✅ Agent automatically detects alarm
- ✅ Investigation starts within 1 minute
- ✅ Root cause identified correctly
- ✅ Recommendations are relevant
- ✅ Timeline shows correlated events
- ✅ Report can be generated

## Next Steps After Testing

1. **Document your findings** - Take notes on what the agent found
2. **Compare to manual analysis** - How much time did it save?
3. **Test edge cases** - What happens with different failure patterns?
4. **Create your LinkedIn post** - Show the before/after
5. **Update your GitHub README** - Add DevOps Agent results

## For Your LinkedIn Post

**Key talking points:**
- "Set up AWS DevOps Agent in preview"
- "Tested autonomous incident investigation"
- "Agent identified root cause in under 3 minutes"
- "Compared to 2+ hours of manual investigation"
- "This is the future of DevOps"

---

**Ready to see the AI in action!** 🚀

Let me know what the agent finds!
