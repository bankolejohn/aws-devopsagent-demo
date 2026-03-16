# Creating GitHub Repository

## Option 1: Using GitHub Web Interface (Recommended)

### Step 1: Create Repository on GitHub
1. Go to https://github.com/new
2. Fill in the details:
   - **Repository name:** `aws-devops-demo-2025`
   - **Description:** `Demo showcasing AWS DevOps Agent and CloudWatch AI investigations (2025)`
   - **Visibility:** Public (or Private if you prefer)
   - **DO NOT** initialize with README, .gitignore, or license (we already have these)
3. Click **Create repository**

### Step 2: Push Your Local Repository
After creating the repo, GitHub will show you commands. Use these:

```bash
cd aws-devops-demo

# Add the remote repository (replace YOUR_USERNAME with your GitHub username)
git remote add origin https://github.com/YOUR_USERNAME/aws-devops-demo-2025.git

# Push to GitHub
git branch -M main
git push -u origin main
```

## Option 2: Using GitHub CLI (if installed)

If you want to install GitHub CLI first:

```bash
# macOS
brew install gh

# Then authenticate
gh auth login

# Create and push repository
cd aws-devops-demo
gh repo create aws-devops-demo-2025 --public --source=. --remote=origin --push
```

## Option 3: Manual Commands (After Creating Repo on GitHub)

```bash
cd aws-devops-demo

# Replace YOUR_USERNAME with your actual GitHub username
git remote add origin https://github.com/YOUR_USERNAME/aws-devops-demo-2025.git

# Verify remote
git remote -v

# Push to GitHub
git push -u origin main
```

## Verify

After pushing, visit your repository:
```
https://github.com/YOUR_USERNAME/aws-devops-demo-2025
```

## Add Topics (Optional)

On GitHub, add these topics to make your repo discoverable:
- `aws`
- `devops`
- `lambda`
- `cloudwatch`
- `aws-devops-agent`
- `serverless`
- `infrastructure-as-code`
- `aws-sam`
- `ai-ops`

## Next Steps

1. Add a nice repository banner/logo (optional)
2. Enable GitHub Actions for CI/CD (optional)
3. Add GitHub Issues templates
4. Share your demo with the community!
