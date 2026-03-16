# AWS DevOps Agent Demo

[![AWS SAM](https://img.shields.io/badge/AWS-SAM-FF9900?style=flat&logo=amazon-aws)](https://aws.amazon.com/serverless/sam/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

A hands-on demo showcasing [AWS DevOps Agent](https://aws.amazon.com/devops-agent/) (preview) and CloudWatch AI-powered incident response, announced at AWS re:Invent 2025.

## Overview

This project deploys two Lambda functions behind an API Gateway with a web UI to simulate real-world production incidents. CloudWatch monitors the functions and fires alarms when thresholds are crossed, giving AWS DevOps Agent something to autonomously investigate.

**What the agent demonstrated on this project:**
- Traced every deployment to the exact SAM CLI version, IAM user, IP address, and S3 artifact hash
- Identified all 3 failure modes from logs alone—without ever seeing the source code
- Correlated a CloudWatch alarm threshold change to a specific CloudFormation deployment
- Tracked 7 alarm transitions across 11 days with exact timestamps and invocation counts
- Flagged its own investigation gaps honestly (no hallucination)

## Architecture

```
Web UI (HTML/JS)
      │
      ▼
API Gateway (REST)
      │
      ├── GET /healthy ──► HealthyFunction (always succeeds)
      └── GET /faulty  ──► FaultyFunction  (random failures)
                                │
                                ▼
                         CloudWatch Logs
                         CloudWatch Alarms
                                │
                                ▼
                        AWS DevOps Agent
                     (autonomous investigation)
```

## Failure Scenarios

The `FaultyFunction` randomly generates:

| Scenario | Probability | Simulates |
|---|---|---|
| Exception (database error) | 60% | Connection failures, unhandled errors |
| Timeout (25s sleep) | 15% | Slow queries, hanging API calls |
| Memory pressure (119/128 MB) | 15% | Memory leaks, large data processing |
| Success | 10% | Intermittent issues |

## Prerequisites

- AWS CLI configured
- Python 3.13+
- AWS SAM CLI (`pip install aws-sam-cli`)

## Deploy

```bash
sam build
sam deploy --stack-name aws-devops-demo --capabilities CAPABILITY_IAM --resolve-s3
```

## Run the Web UI

Open `frontend/index.html` in your browser. The API endpoints are pre-configured after deployment.

- **Test Healthy Function** — always returns 200
- **Test Faulty Function** — random failures
- **Stress Test** — 10 rapid calls to trigger CloudWatch alarms

## Trigger Incidents via CLI

```bash
# Invoke directly to trigger CloudWatch alarms
./demo-trigger.sh

# Or invoke manually
aws lambda invoke --function-name FaultyFunction response.json
```

## Monitor

```bash
# Check alarm status
aws cloudwatch describe-alarms \
  --alarm-names FaultyFunction-ErrorRate FaultyFunction-HighDuration \
  --region us-east-1 \
  --query 'MetricAlarms[*].[AlarmName,StateValue]' \
  --output table

# Tail logs
aws logs tail /aws/lambda/FaultyFunction --follow --region us-east-1
```

## AWS DevOps Agent Setup

1. Open the [DevOps Agent Console](https://console.aws.amazon.com/devops-agent/home?region=us-east-1)
2. Create an Agent Space and configure IAM roles
3. Connect CloudWatch as an integration (region: `us-east-1`)
4. Add `FaultyFunction` and `HealthyFunction` to the topology
5. Trigger incidents using the web UI or `demo-trigger.sh`
6. Watch the agent investigate under the **Investigations** tab

## Cleanup

```bash
aws cloudformation delete-stack --stack-name aws-devops-demo --region us-east-1
```

## Cost

Mostly AWS free tier eligible. Estimated cost: **$0.00–$0.50/month** during active testing.

## Resources

- [AWS DevOps Agent announcement](https://aws.amazon.com/blogs/aws/aws-devops-agent-helps-you-accelerate-incident-response-and-improve-system-reliability-preview/)
- [AWS SAM documentation](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html)
- [CloudWatch Investigations](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Insights-Investigations.html)

## License

MIT
