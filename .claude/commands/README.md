# Claude Commands

Slash commands for the BMT Python Monorepo. These follow the official Claude Code command format.

## Available Commands

### Development

| Command | Description |
|---------|-------------|
| `/dev-new-app` | Create a new application |
| `/dev-new-package` | Create a new package |

### Environment

| Command | Description |
|---------|-------------|
| `/env-check` | Check environment health and status |
| `/env-clean` | Clean environment artifacts and caches |
| `/env-fix` | Fix environment and dependency issues |
| `/env-generate` | Generate environment files from templates |
| `/env-sync` | Sync environment and dependencies |

### Quality Assurance

| Command | Description |
|---------|-------------|
| `/qa-check` | Run Zero-QA quality checks |
| `/qa-fix` | Auto-fix code issues |
| `/qa-review` | Code review checklist |
| `/qa-test` | Run tests with options |
| `/verify` | Verify code changes |
| `/zero-qa-check` | Comprehensive QA check |
| `/zero-qa-gate` | Validate quality gates |

### Git & Version Control

| Command | Description |
|---------|-------------|
| `/git-commit` | Create conventional commit |
| `/git-sync` | Sync repository |
| `/git-status` | Git status overview |
| `/git-changelog` | Generate changelog |

### GitHub

| Command | Description |
|---------|-------------|
| `/github-fix-issues` | Fix GitHub issues |
| `/github-fix-actions` | Fix GitHub Actions failures |
| `/github-fix-pr` | Fix GitHub PR review issues |

### Operations

| Command | Description |
|---------|-------------|
| `/ops-deploy` | Deploy application |

### Documentation

| Command | Description |
|---------|-------------|
| `/docs-update-wiki` | Update wiki pages |
| `/doc-generate` | Generate API docs |

### Scrum/Agile

| Command | Description |
|---------|-------------|
| `/scrum-backlog` | Manage product backlog |
| `/scrum-sprint` | Sprint management |
| `/scrum-planning` | Sprint planning |
| `/scrum-standup` | Daily standup |
| `/scrum-review` | Sprint review |
| `/scrum-retro` | Sprint retrospective |
| `/scrum-burndown` | Sprint burndown |
| `/scrum-refinement` | Backlog refinement |
| `/scrum-dod` | Definition of Done |

### Multi-Agent

| Command | Description |
|---------|-------------|
| `/agent-spawn` | Spawn agent workers |
| `/agent-status` | Check agent status |
| `/agent-collect` | Collect agent results |

## Usage

```bash
# In Claude Code

# Environment management
/env-check all
/env-clean cache
/env-fix deps
/env-generate dev
/env-sync upgrade

# Quality assurance
/qa-check all
/github-fix-pr 123

# Scrum/Agile
/scrum-backlog list
/agent-spawn 3
```

## Adding Commands

Create a new `.md` file in this directory following the official Claude Code format:

```markdown
---
description: Brief description of command
allowed-tools: Bash(git:*), Read, Write
argument-hint: [arg1] [arg2]
---

# Command Title

Description of what the command does.

## Arguments

- `$ARGUMENTS` - All arguments passed to the command
- `$1`, `$2` - Individual positional arguments

## Current Status

!`git status`

## Instructions

Step-by-step instructions for Claude.

## Output

Description of expected output.
```

### Frontmatter Options

| Option | Description |
|--------|-------------|
| `description` | Brief description shown in command list |
| `allowed-tools` | Tools this command can use |
| `argument-hint` | Hint for required arguments |
| `model` | Override model for this command |
| `disable-model-invocation` | Set true for templates only |

### Special Syntax

- `$ARGUMENTS` - All passed arguments
- `$1`, `$2`, etc. - Individual positional arguments
- `!`command`` - Execute bash command inline
- `@filepath` - Include file contents
