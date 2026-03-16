# ✅ Quick DevOps Agent Test Checklist

## What Just Happened
- ✅ Triggered 5 Lambda invocations
- ✅ Generating errors and timeouts
- ✅ CloudWatch alarms should fire in ~60 seconds
- ✅ DevOps Agent should detect and investigate

## In the DevOps Agent Console (Just Opened)

### 1. Check Agent Space Status
- [ ] Agent Space shows "Active"
- [ ] IAM roles configured
- [ ] Integrations connected

### 2. Verify Integrations
Go to "Integrations" tab:
- [ ] CloudWatch connected
- [ ] Region: us-east-1
- [ ] Log groups accessible

### 3. Check Topology
Go to "Topology" tab:
- [ ] FaultyFunction visible
- [ ] CloudWatch alarms mapped
- [ ] Dependencies shown

### 4. Watch for Investigation
Go to "Investigations" tab:
- [ ] New investigation appears (within 2-3 minutes)
- [ ] Status: "In Progress" or "Analyzing"
- [ ] Triggered by: Alarm state change

### 5. Review Findings
Once investigation completes:
- [ ] Root cause identified
- [ ] Error patterns detected
- [ ] Timeline generated
- [ ] Recommendations provided

## What the Agent Should Find

**Expected Root Causes:**
- High error rate (60% of invocations)
- Database connection failures
- Timeout scenarios (25 seconds)
- Memory pressure (near 128MB)

**Expected Recommendations:**
- Review error handling
- Add retry logic
- Increase memory allocation
- Implement timeout handling

## If Investigation Doesn't Start Automatically

**Manual Trigger:**
1. Click "Start Investigation" or "New Investigation"
2. Select alarm: `FaultyFunction-ErrorRate`
3. Time range: Last 15 minutes
4. Click "Investigate"

## Screenshots to Take

Priority screenshots for LinkedIn:
1. [ ] Agent Space dashboard (active status)
2. [ ] Investigation in progress
3. [ ] Root cause analysis results
4. [ ] Timeline visualization
5. [ ] Recommended actions
6. [ ] Incident report (if generated)

## Timing Expectations

- **Alarm fires:** ~90 seconds after invocations
- **Agent detects:** Within 1-2 minutes of alarm
- **Investigation completes:** 2-5 minutes
- **Total time:** ~5-8 minutes from trigger to results

## Quick Commands

**Check alarm status:**
```bash
aws cloudwatch describe-alarms \
  --alarm-names FaultyFunction-ErrorRate \
  --region us-east-1 \
  --query 'MetricAlarms[0].StateValue' \
  --output text
```

**Trigger more incidents:**
```bash
./demo-trigger.sh
```

**Open web interface:**
```bash
./open-frontend.sh
```

## Success = Agent Working!

You'll know it's successful when:
- ✅ Investigation starts automatically
- ✅ Agent correlates logs + metrics + alarms
- ✅ Root cause matches actual issue
- ✅ Recommendations are actionable
- ✅ Report can be generated

## This is What You're Showcasing

**The Power of AI-Driven DevOps:**
- Autonomous detection
- Automatic investigation
- Intelligent correlation
- Actionable insights
- Zero human intervention needed

**Traditional:** 2-4 hours of manual work
**With Agent:** 2-5 minutes, fully automated

---

**Go check the DevOps Agent console now!** 🚀

The investigation should be starting or already in progress.
