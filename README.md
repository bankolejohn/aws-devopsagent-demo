# AWS DevOps Demo - 2025 Services Showcase

A minimal project demonstrating the latest AWS DevOps capabilities announced in 2025, including AWS DevOps Agent and CloudWatch AI-powered investigations.

## 🎯 What This Demonstrates

- **AWS DevOps Agent (Preview)** - Autonomous incident response and investigation
- **CloudWatch AI Investigations** - Automated root cause analysis with "5 Whys"
- **Generative AI Observability** - AI-powered monitoring and insights
- **Lambda Functions** - Intentional failure scenarios for testing
- **CloudWatch Alarms** - Automated incident detection

## 🏗️ Architecture

- 2 Lambda functions (healthy + faulty with random failures)
- CloudWatch Logs & Metrics
- CloudWatch Alarms for error detection
- IAM roles with least privilege
- Infrastructure as Code (AWS SAM)

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

### 2. Generate Test Incidents

```bash
./test-functions.sh
```

This will trigger various failure scenarios:
- Timeouts (25+ seconds)
- Application errors (exceptions)
- Memory pressure
- High duration

### 3. Set Up AI-Powered DevOps Features

```bash
./quick-setup.sh
```

Then follow the detailed guide in [SETUP_DEVOPS_AGENT.md](SETUP_DEVOPS_AGENT.md)

## 📊 Monitoring

View logs and metrics in CloudWatch console:
- CloudWatch → Log groups → `/aws/lambda/FaultyFunction`
- CloudWatch → Alarms → View alarm status
- CloudWatch → Metrics → AWS/Lambda namespace

## 🤖 AWS DevOps Agent Setup

The AWS DevOps Agent (announced at re:Invent 2025) acts as an autonomous on-call engineer:

1. **Create Agent Space** in AWS Console
2. **Connect to CloudWatch** for observability data
3. **Configure topology** to map your Lambda functions
4. **Enable automatic incident response**

See [SETUP_DEVOPS_AGENT.md](SETUP_DEVOPS_AGENT.md) for detailed instructions.

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
