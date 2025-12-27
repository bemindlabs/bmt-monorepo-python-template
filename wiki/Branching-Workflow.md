# Branching Workflow

## Overview

This repository follows a structured Git branching strategy designed for continuous integration and safe production deployments.

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│  feature/*  │────>│     dev     │────>│   staging   │────>│ production  │
│  hotfix/*   │     │             │     │             │     │             │
└─────────────┘     └─────────────┘     └─────────────┘     └─────────────┘
                          │                   │                   │
                    Integration          Pre-prod            Production
                      Testing            Testing               Ready
```

## Branch Types

### Protected Branches

| Branch | Purpose | Deployment Target | Protection |
|--------|---------|-------------------|------------|
| `production` | Production-ready, released code | Production servers | Highest |
| `staging` | Pre-production testing | Staging environment | High |
| `dev` | Integration of features | Development environment | Medium |

### Working Branches

| Pattern | Purpose | Created From | Merges To |
|---------|---------|--------------|-----------|
| `feature/<name>` | New features | `dev` | `dev` |
| `hotfix/<name>` | Urgent production fixes | `production` | `production`, `dev` |
| `release/<version>` | Release preparation | `staging` | `production` |

## Workflow Steps

### 1. Feature Development

```bash
# Start a new feature
git checkout dev
git pull origin dev
git checkout -b feature/TICKET-123-add-user-auth

# Work on feature...
git add .
git commit -m "feat(core): add user authentication"

# Push and create PR to dev
git push -u origin feature/TICKET-123-add-user-auth
gh pr create --base dev --title "feat(core): add user authentication"
```

### 2. Integration to Dev

- Create Pull Request from `feature/*` to `dev`
- Require at least 1 code review approval
- All CI checks must pass (lint, type-check, tests)
- Merge using squash or rebase

### 3. Promotion to Staging

```bash
# After features are integrated in dev
git checkout staging
git pull origin staging
git merge dev
git push origin staging
```

- Merge `dev` to `staging` for pre-production testing
- CI/CD deploys to staging environment automatically
- Perform integration and UAT testing

### 4. Production Release

**Requirements before merging to production:**

- [ ] All tests pass (`make zero-qa`)
- [ ] Test coverage ≥ 80%
- [ ] Code review approved
- [ ] Staging testing completed
- [ ] No critical/blocking issues

```bash
# Release to production
git checkout production
git pull origin production
git merge staging
git tag -a v1.0.0 -m "Release v1.0.0"
git push origin production --tags
```

### 5. Hotfix Workflow

For urgent production issues:

```bash
# Create hotfix from production
git checkout production
git pull origin production
git checkout -b hotfix/TICKET-456-fix-auth-crash

# Fix the issue...
git commit -m "fix(core): resolve auth session crash"

# Merge to production AND dev
git checkout production
git merge hotfix/TICKET-456-fix-auth-crash
git push origin production

git checkout dev
git merge hotfix/TICKET-456-fix-auth-crash
git push origin dev
```

## Branch Naming Conventions

### Feature Branches
```
feature/<ticket-id>-<short-description>
feature/PROJ-123-add-user-auth
feature/PROJ-456-payment-integration
```

### Hotfix Branches
```
hotfix/<ticket-id>-<short-description>
hotfix/PROJ-789-fix-login-crash
hotfix/PROJ-012-security-patch
```

### Release Branches
```
release/v<major>.<minor>.<patch>
release/v1.0.0
release/v2.1.3
```

## Quality Gates

### Dev Branch
- Lint checks pass (`make lint`)
- Type checks pass (`make type-check`)
- Unit tests pass (`make test`)
- PR review approved

### Staging Branch
- All dev branch requirements
- Integration tests pass
- No critical security issues

### Production Branch
- All staging branch requirements
- Test coverage ≥ 80% (`make test-coverage`)
- UAT sign-off
- Release notes prepared

## GitHub Branch Protection Rules

### production
- Require pull request before merging
- Require 2 approvals
- Require status checks: `lint`, `type-check`, `test`, `coverage`
- Require branches to be up to date
- Do not allow bypassing
- Restrict deletions

### staging
- Require pull request before merging
- Require 1 approval
- Require status checks: `lint`, `type-check`, `test`
- Require branches to be up to date

### dev
- Require pull request before merging
- Require 1 approval
- Require status checks: `lint`, `type-check`, `test`

## Quick Reference

| Action | Command |
|--------|---------|
| Start feature | `git checkout -b feature/<name> dev` |
| Create PR | `gh pr create --base dev` |
| Run all checks | `make zero-qa` |
| Check coverage | `make test-coverage` |
| Merge to staging | `git checkout staging && git merge dev` |
| Release to prod | `git checkout production && git merge staging` |
| Create tag | `git tag -a v1.0.0 -m "Release v1.0.0"` |
