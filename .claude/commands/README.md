# Claude Commands

Slash commands for the BMT Python Monorepo.

## Available Commands

### Development

| Command | Description |
|---------|-------------|
| `/dev-new-app` | Create a new application |
| `/dev-new-package` | Create a new package |

### Quality Assurance

| Command | Description |
|---------|-------------|
| `/qa-check` | Run Zero-QA quality checks |
| `/qa-fix` | Auto-fix code issues |
| `/qa-review` | Code review checklist |
| `/qa-test` | Run tests with options |
| `/zero-qa-check` | Comprehensive QA check |
| `/zero-qa-gate` | Validate quality gates |

### Git & Version Control

| Command | Description |
|---------|-------------|
| `/git-commit` | Create conventional commit |
| `/git-sync` | Sync repository |
| `/git-status` | Git status overview |
| `/git-changelog` | Generate changelog |

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
| `/scrum-standup` | Daily standup |
| `/scrum-retro` | Sprint retrospective |

### Multi-Agent

| Command | Description |
|---------|-------------|
| `/agent-spawn` | Spawn agent workers |
| `/agent-status` | Check agent status |
| `/agent-collect` | Collect agent results |

## Usage

```bash
# In Claude Code
/qa-check all
/scrum-backlog list
/agent-spawn 3
```

## Adding Commands

Create a new `.md` file in this directory:

```markdown
# Command Title

Description of what the command does.

## Instructions

Step-by-step instructions for Claude.

## Arguments

- `$ARGUMENTS` - Description of expected arguments

## Output

Description of expected output.
```
