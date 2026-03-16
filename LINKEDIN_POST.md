# LinkedIn Post (Final Version)

---

I built a hands-on demo to test AWS DevOps Agent—one of the most significant DevOps announcements from AWS re:Invent 2025. Here's what the AI found, and why it impressed me.

The setup: two AWS Lambda functions behind an API Gateway, with a simple web UI to trigger requests. One function runs perfectly. The other fails randomly—timeouts, database errors, memory pressure—simulating real production incidents. CloudWatch monitors everything and fires alarms when thresholds are crossed.

Then I connected AWS DevOps Agent and let it investigate.

Here's what it autonomously produced in its root cause analysis:

→ It identified all 3 failure modes from logs alone—never once saw the source code. It correctly concluded the "database connection failed" error was NOT a real connectivity issue but hardcoded simulated logic.

→ It tracked 7 alarm transitions across 11 days with exact timestamps, error counts, and sample sizes per minute window—e.g. "3 errors out of 5 invocations at 08:50Z, then 1 error out of 4 at 08:51Z."

→ It calculated a 39% average error rate across all observed sessions and correctly described the failure selection as probabilistic/random.

→ It correlated a CloudFormation config change (alarm threshold 2 → 1) to a specific deployment and explained precisely why alarm frequency increased afterward.

→ It flagged its own limitation: "Cannot inspect source code repository to verify simulated failure logic"—and explained why. The agent was honest about what it didn't know.

That last point stood out to me. It didn't hallucinate. It told me where its analysis stopped and why.

The same investigation—correlating logs, metrics, deployment history, alarm transitions, and config changes across 11 days—would take an engineer hours to piece together manually.

A few takeaways:

• The quality of AI investigation is directly tied to your observability setup. The agent was powerful because CloudWatch had clean, structured data to work with.

• Honesty about gaps matters as much as the findings. An agent that knows what it doesn't know is far more trustworthy in production.

• This is still in preview, but the signal is clear: autonomous incident response is no longer a concept—it's here.

The full project is open source—Lambda functions, API Gateway, CloudWatch alarms, a frontend UI, and deployment scripts. Free to deploy on AWS free tier.

🔗 GitHub link in the comments.

Have you started exploring AI-powered incident response in your stack? I'd love to hear what you're seeing.

#AWS #DevOps #CloudComputing #ArtificialIntelligence #Serverless #CloudWatch #SRE #PlatformEngineering #AWSreInvent #LearningInPublic

---

## Comment to Post Separately:

GitHub: https://github.com/bankolejohn/aws-devopsagent-demo

Built with AWS SAM, Lambda, API Gateway, CloudWatch, and AWS DevOps Agent (preview).
Fork it, trigger some incidents, and see what the AI finds. 🚀

---

## Posting Tips:

1. Best time: Tuesday–Thursday, 8–10 AM or 12–1 PM your timezone
2. Add screenshots: web UI + agent root cause analysis + CloudWatch alarms in ALARM state
3. Engage with every comment in the first 2 hours (boosts reach significantly)
4. Consider a carousel: slide 1 (problem) → slide 2 (architecture) → slide 3 (agent findings) → slide 4 (the gap it flagged) → slide 5 (takeaways)
5. Share in AWS User Groups and DevOps/SRE communities on LinkedIn
