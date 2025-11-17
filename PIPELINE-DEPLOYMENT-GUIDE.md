# 🚀 Complete Pipeline Deployment Guide

## 📋 Pipeline Overview

Your multi-environment Terraform pipeline is now complete with the following architecture:

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   LAB (dev)     │───▶│ NLV (staging)   │───▶│  LV (prod)      │
│ feature/users/** │    │    staging      │    │     main        │
│  Auto-deploy    │    │  Approval Gate  │    │  Approval Gate  │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## Required GitHub Secrets

Add these secrets to your GitHub repositoryy (`Settings` → `Secrets and variables` → `Actions`):

```yaml
# Azure Service Principal Credentials
AZURE_CLIENT_ID: "your-service-principal-client-id"
AZURE_CLIENT_SECRET: "your-service-principal-client-secret"
AZURE_SUBSCRIPTION_ID: "your-azure-subscription-id"
AZURE_TENANT_ID: "your-azure-tenant-id"

# GitHub Personal Access Token (for cross-repo access and PR creation)
GH_PAT: "your-github-personal-access-token"
```

### 🔐 Service Principal Setup

1. **Create Service Principal:**
```bash
az ad sp create-for-rbac --name "terraform-github-actions" --role="Contributor" --scopes="/subscriptions/{subscription-id}"
```

2. **Save the output values as GitHub secrets:**
   - `appId` → `AZURE_CLIENT_ID`
   - `password` → `AZURE_CLIENT_SECRET`
   - `tenant` → `AZURE_TENANT_ID`
   - Your subscription ID → `AZURE_SUBSCRIPTION_ID`

### 🎫 GitHub PAT Setup

1. Go to GitHub Settings → Developer settings → Personal access tokens
2. Create a classic token with these permissions:
   - `repo` (full repository access)
   - `workflow` (workflow access)
   - `read:org` (read organization)
3. Save the token as `GH_PAT` secret

## 🛡️ Environment Protection Rules

Create these GitHub Environments with protection rules:

### 1. LAB Environment
- **Name:** `lab`
- **Protection:** None (auto-deploy for development)
- **Secrets:** None (inherits from repository)

### 2. NLV Environment  
- **Name:** `nlv`
- **Protection:** Required reviewers (1-2 team leads)
- **Wait timer:** 0 minutes
- **Secrets:** None (inherits from repository)

### 3. LV Environment
- **Name:** `lv` 
- **Protection:** Required reviewers (2+ senior team members)
- **Wait timer:** 5-10 minutes
- **Secrets:** None (inherits from repository)

### 4. Apply Gate Environments
Create these for additional approval gates:
- `lab-apply` (no protection)
- `nlv-apply` (requires approval)
- `lv-apply` (requires approval)

### 5. Destroy Gate Environments
Create these for infrastructure destruction:
- `lab-destroy` (minimal protection)
- `nlv-destroy` (requires approval)
- `lv-destroy` (requires strong approval)

## 📁 Pipeline Components

### 🔄 Reusable Templates (`.github/templates/`)
1. `terraform-validate.yml` - Code validation and linting
2. `terraform-plan.yml` - Infrastructure planning
3. `terraform-apply.yml` - Infrastructure deployment
4. `terraform-destroy.yml` - Infrastructure destruction

### 🏃‍♂️ Main Workflows (`.github/workflows/`)
1. `deploy-feature.yml` - Feature branch → LAB deployment
2. `deploy-staging.yml` - Staging branch → NLV deployment  
3. `deploy-main.yml` - Main branch → LV deployment
4. `combined-pipeline.yml` - Manual trigger for all environments

### 🗂️ Environment Configurations
- `environments/lab-customer-config.yml` - LAB environment settings
- `environments/nlv-customer-config.yml` - NLV environment settings
- `environments/lv-customer-config.yml` - LV environment settings

## 🚀 Deployment Flow

### 1. Feature Development (LAB)
```bash
# Create feature branch
git checkout -b feature/new-infrastructure
# or
git checkout -b users/shubhi/vodafonepoc

# Make changes and commit
git add .
git commit -m "Add new infrastructure components"
git push origin feature/new-infrastructure
```

**Pipeline Actions:**
- ✅ Terraform validate
- ✅ Terraform plan  
- ✅ Terraform apply to LAB
- 🤖 Auto-create PR to staging

### 2. Staging Deployment (NLV)
```bash
# Merge the auto-created PR to staging
# This triggers staging deployment
```

**Pipeline Actions:**
- ✅ Terraform validate
- ✅ Terraform plan for NLV
- ⏳ **APPROVAL GATE** - Team lead approval required
- ✅ Terraform apply to NLV
- 🤖 Auto-create PR to main

### 3. Production Deployment (LV)
```bash
# Merge the auto-created PR to main
# This triggers production deployment  
```

**Pipeline Actions:**
- ✅ Terraform validate
- ✅ Terraform plan for LV
- ⏳ **APPROVAL GATE** - Senior team approval required
- ✅ Terraform apply to LV
- 🎉 Production deployment complete

## 🎯 Branch Strategy

```
users/shubhi/vodafonepoc ──┐
feature/new-feature     ──┼─▶ staging ──▶ main
feature/bug-fix         ──┘      │           │
                                 │           │
                                LAB ────── NLV ────── LV
                               (auto)   (approval)  (approval)
```

### Branch Patterns:
- **Feature branches:** `feature/**`, `users/**`
- **Staging branch:** `staging`
- **Production branch:** `main`

## 🧪 Testing Your Pipeline

### Step 1: Initial Push
```bash
# Push to your current branch
git add .
git commit -m "Initial pipeline setup"
git push origin users/shubhi/vodafonepoc
```

### Step 2: Monitor Workflow
1. Go to GitHub → Actions tab
2. Watch the "🧪 Deploy Feature Branch (LAB Environment)" workflow
3. Verify all steps pass:
   - ✅ Terraform Validate
   - ✅ Terraform Plan  
   - ✅ Terraform Apply
   - ✅ Auto-PR Creation

### Step 3: Check Auto-Generated PR
1. Go to Pull Requests tab
2. Look for auto-generated PR: "Auto PR: Deploy users/shubhi/vodafonepoc to staging"
3. Review the PR description and changes

### Step 4: Test Staging Deployment
1. Approve and merge the staging PR
2. Watch "🔄 Deploy Staging Branch (NLV Environment)" workflow
3. Approve when prompted (if protection rules are set)

### Step 5: Test Production Deployment
1. Merge the auto-generated main PR
2. Watch "🏁 Deploy Main Branch (LV Environment)" workflow  
3. Provide senior approval when prompted

## 🔍 Troubleshooting

### Common Issues:

1. **Secret not found errors:**
   - Verify all secrets are added to repository settings
   - Check secret names match exactly (case-sensitive)

2. **Branch protection conflicts:**
   - Ensure GH_PAT has sufficient permissions
   - Check branch protection rules don't conflict

3. **Module access errors:**
   - Verify `repo-modules-env` repository exists
   - Ensure GH_PAT has access to the modules repository
   - Check module paths in `main.tf`

4. **Azure authentication failures:**
   - Verify Service Principal has Contributor role
   - Check subscription ID is correct
   - Ensure client secret hasn't expired

### Debug Commands:
```bash
# Check workflow status
gh run list --limit 5

# View specific workflow run
gh run view [run-id]

# Check repository secrets (won't show values)
gh secret list
```

## ✅ Pre-Deployment Checklist

- [ ] All GitHub secrets configured
- [ ] Service Principal has correct permissions
- [ ] GitHub PAT has repository access
- [ ] Environment protection rules created
- [ ] Module repository accessible
- [ ] Branch protection rules configured
- [ ] Team approval processes defined

## 🎉 Success Indicators

Your pipeline is working correctly when you see:

1. ✅ Automatic LAB deployments on feature pushes
2. 🤖 Auto-generated PRs to staging after LAB success
3. ⏳ Approval gates working for NLV/LV environments
4. 🔄 Seamless progression: LAB → NLV → LV
5. 📊 Clear infrastructure state across all environments
6. 🗑️ Manual destroy capabilities when needed

---

## 🆘 Support Commands

If you need help with any step:

```bash
# Test Azure connection
az account show

# Check GitHub CLI access
gh auth status

# Validate Terraform
terraform validate

# Check workflow syntax
gh workflow list
```

Your enterprise-grade Terraform pipeline is now ready for production use! 🚀