# AWS DevOps Demo - 2025 Services Showcase

[![AWS](https://img.shields.io/badge/AWS-DevOps%20Agent-FF9900?style=flat&logo=amazon-aws)](https://aws.amazon.com/devops-agent/)
[![CloudWatch](https://img.shields.io/badge/CloudWatch-AI%20Investigations-FF9900?style=flat&logo=amazon-aws)](https://aws.amazon.com/cloudwatch/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![SAM](https://img.shields.io/badge/AWS-SAM-orange?style=flat&logo=amazon-aws)](https://aws.amazon.com/serverless/sam/)

A minimal project demonstrating the latest AWS DevOps capabilities announced in 2025, including AWS DevOps Agent and CloudWatch AI-powered investigations.

> 🚀 **Featured AWS Services**: DevOps Agent (Preview) | CloudWatch AI Investigations | Lambda | CloudWatch Alarms

## 🎯 What This Demonstrates

- **AWS DevOps Agent (Preview)** - Autonomous incident response and investigation
- **CloudWatch AI Investigations** - Automated root cause analysis with "5 Whys"
- **Generative AI Observability** - AI-powered monitoring and insights
- **Lambda Functions** - Intentional failure scenarios for testing
- **CloudWatch Alarms** - Automated incident detection

## 🏗️ Architecture

- **Frontend:** Single-page web app (HTML/CSS/JavaScript)
- **API Gateway:** REST API with CORS enabled
- **Lambda Functions:** 2 serverless functions (healthy + faulty)
- **CloudWatch:** Logs, Metrics, and Alarms
- **IAM:** Least privilege roles
- **Infrastructure as Code:** AWS SAM (Serverless Application Model)

### API Endpoints

After deployment, you get:
- `GET /healthy` - Always succeeds (baseline)
- `GET /faulty` - Random failures (testing)

### Failure Scenarios

The faulty function randomly generates:
- **Timeout**: Sleeps for 25 seconds (near Lambda timeout)
- **Error**: Raises database connection exception
- **Memory**: Allocates large data structures
- **Success**: Occasionally succeeds (20% chance)

## 📋 Prerequisites

- AWS CLI configured with valid credentials
- AWS account with Lambda and CloudWatch permissions
- Python 3.13 (or 3.12+)
- AWS SAM CLI (auto-installed by deploy script)

## 🚀 Quick Start

### 1. Deploy the Infrastructure

```bash
cd aws-devops-demo
./deploy.sh
```

### 2. Open the Web Interface

```bash
./open-frontend.sh
```

This opens a beautiful web interface where you can:
- ✅ Test the healthy function (always succeeds)
- ⚠️ Test the faulty function (random failures)
- 🔥 Run stress tests (trigger CloudWatch alarms)
- 📊 See real-time success/error statistics

### 3. Alternative: CLI Testing

```bash
# Test via command line
./test-functions.sh

# Or trigger rapid failures
./trigger-incident.sh
```

## 📊 Monitoring

View logs and metrics in CloudWatch console:
- CloudWatch → Log groups → `/aws/lambda/FaultyFunction`
- CloudWatch → Alarms → View alarm status
- CloudWatch → Metrics → AWS/Lambda namespace

## 🤖 AWS DevOps Agent - Real Results

After setting up AWS DevOps Agent and triggering incidents, here's what the AI autonomously discovered:

### What the Agent Found (Without Any Human Guidance)

- **Deployment tracking** - Traced every SAM CLI deployment, who ran it, from what IP, with what tool version, and the exact S3 artifact hash
- **Code correlation** - Detected that both Lambda functions share the same deployment package and correctly identified they use different handlers from the same bundle
- **Config change detection** - Caught the alarm threshold change from 2 → 1 and correctly linked it to increased alarm frequency
- **Duration pattern analysis** - Tracked exact alarm transition timestamps, counted historical occurrences, and correlated to invocation counts

### Time Comparison

| Approach | Time to Root Cause |
|---|---|
| Manual investigation | 2-4 hours |
| AWS DevOps Agent | ~3 minutes |

> "The agent pieced together the entire incident story - deployments, code changes, config changes, alarm history - completely autonomously."

## 🧪 Testing Different Failure Scenarios

The `FaultyFunction` randomly generates:
- **Timeout**: Sleeps for 25 seconds (near Lambda timeout)
- **Error**: Raises database connection exception
- **Memory**: Allocates large data structures
- **Success**: Occasionally succeeds (20% chance)

## 💰 Cost Estimate

- Lambda: Free tier eligible (1M requests/month)
- CloudWatch Alarms: $0.10/alarm (first 10 free)
- CloudWatch Logs: First 5GB/month free
- **Estimated: $0.00 - $0.50/month**

## 🧹 Cleanup

Delete all resources:

```bash
aws cloudformation delete-stack --stack-name aws-devops-demo
```

Or keep it running for minimal cost to continue exploring.

## 📚 Learn More

- [AWS DevOps Agent Documentation](https://aws.amazon.com/devops-agent/)
- [CloudWatch AI Investigations](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Insights-Investigations.html)
- [AWS re:Invent 2025 Announcements](https://aws.amazon.com/blogs/mt/2025-top-10-announcements-for-aws-cloud-operations/)

## 🤝 Contributing

Feel free to open issues or submit PRs to improve this demo!

## 📄 License

MIT License - feel free to use this for learning and demos.
