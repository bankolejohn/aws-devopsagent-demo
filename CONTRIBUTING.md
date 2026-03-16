# Contributing to AWS DevOps Demo

Thank you for your interest in contributing! This project is meant to showcase AWS DevOps capabilities from 2025.

## How to Contribute

### Reporting Issues
- Check existing issues first
- Provide clear description and steps to reproduce
- Include AWS region and service availability info

### Suggesting Enhancements
- Open an issue with the "enhancement" label
- Describe the AWS service or feature you'd like to add
- Explain how it demonstrates DevOps capabilities

### Pull Requests
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Test deployment in your AWS account
5. Commit with clear messages (`git commit -m 'Add amazing feature'`)
6. Push to your branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

## Development Guidelines

### Code Style
- Keep Lambda functions simple and focused
- Add comments for complex logic
- Follow Python PEP 8 style guide

### Infrastructure
- Use AWS SAM for infrastructure as code
- Keep resources minimal to reduce costs
- Document any new AWS services used

### Documentation
- Update README.md for new features
- Add setup instructions for new services
- Include cost estimates for new resources

## Testing
- Test deployments in us-east-1 region
- Verify CloudWatch alarms trigger correctly
- Check that cleanup scripts work properly

## Questions?
Open an issue with the "question" label and we'll help you out!

## Code of Conduct
Be respectful, constructive, and helpful to all contributors.
