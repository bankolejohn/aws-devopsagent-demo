# LinkedIn Post (Final Version)

---

I built a hands-on demo to test AWS DevOps Agent—one of the most significant DevOps announcements from AWS re:Invent 2025. Here's what I found.

The setup was straightforward: two AWS Lambda functions behind an API Gateway, with a simple web UI to trigger requests. One function runs perfectly. The other fails randomly—timeouts, database errors, memory pressure—simulating real production incidents. CloudWatch monitors everything and fires alarms when thresholds are crossed.

Then I connected AWS DevOps Agent and let it investigate.

In under 3 minutes, without any guidance, the agent:

→ Traced every deployment to the exact SAM CLI version, IAM user, IP address, and S3 artifact hash

→ Detected that both Lambda functions share the same code bundle and correctly identified they use separate handlers from the same package

→ Correlated an alarm threshold change (2 → 1) to a specific CloudFormation deployment and explained why alarms started firing more frequently afterward

→ Tracked the alarm's full history, identified it was the 4th occurrence, and mapped each trigger to specific invocation patterns

That same investigation would take an on-call engineer 2–4 hours at 3 AM—manually correlating logs, metrics, deployment history, and config changes across multiple consoles.

The agent did it autonomously, accurately, and fast.

A few takeaways from building this:

• AI-driven DevOps isn't replacing engineers—it's eliminating the repetitive, time-consuming investigation work so engineers can focus on what actually matters

• The quality of the agent's findings depends heavily on how well your observability is set up. Garbage in, garbage out.

• This is still in preview, but the signal is clear: autonomous incident response is no longer a concept—it's here.

The full project is open source—Lambda functions, API Gateway, CloudWatch alarms, frontend UI, and deployment scripts. Free to deploy on AWS free tier.

🔗 GitHub link in the comments.

What's your take on AI-powered incident response? Are you already exploring it, or still evaluating?

#AWS #DevOps #CloudComputing #ArtificialIntelligence #Serverless #CloudWatch #SRE #PlatformEngineering #AWSreInvent #LearningInPublic

---

## Comment to Post Separately:

GitHub: https://github.com/bankolejohn/aws-devopsagent-demo

Built with AWS SAM, Lambda, API Gateway, CloudWatch, and AWS DevOps Agent (preview).
Fork it, trigger some incidents, and see what the AI finds. 🚀

---

## Posting Tips:

1. Best time: Tuesday–Thursday, 8–10 AM or 12–1 PM your timezone
2. Add screenshots: web UI + agent investigation results + CloudWatch alarms in ALARM state
3. Engage with every comment in the first 2 hours (boosts reach significantly)
4. Consider a carousel: slide 1 (problem) → slide 2 (architecture) → slide 3 (agent findings) → slide 4 (takeaways)
5. Share in AWS User Groups and DevOps/SRE communities on LinkedIn
