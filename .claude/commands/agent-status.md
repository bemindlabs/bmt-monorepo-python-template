# Agent Status

Check status of running agents and their assigned tasks.

## Instructions

### Status Check Process

1. **List Active Sessions**
   - Read `.agents/sessions/*.json`
   - Check tmux session status

2. **Agent Status Table**

```
Agent Status Report
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Session: agents-1703505600

| Agent   | Item     | Status      | Branch              |
|---------|----------|-------------|---------------------|
| agent-1 | MONO-001 | working     | feature/mono-001    |
| agent-2 | MONO-002 | testing     | feature/mono-002    |
| agent-3 | MONO-003 | completed   | feature/mono-003    |

Active: 2 | Completed: 1 | Failed: 0
```

3. **Detailed View**

For each agent:
- Current task
- Time elapsed
- Last activity
- Git status

### Commands

```bash
# List tmux sessions
tmux list-sessions

# Check specific agent window
tmux capture-pane -t agents:agent-1 -p | tail -20

# View agent logs
cat .agents/logs/session-id/agent-1.log
```

### Status Actions

#### `list` - List all agents

Show all active and recent agent sessions.

#### `{agent-id}` - Specific agent status

Show detailed status for one agent.

#### `logs {agent-id}` - View agent logs

Display recent log output.

## Arguments

- `$ARGUMENTS` - Optional: `list`, `{agent-id}`, `logs {agent-id}`

## Output

Agent status table with current progress and commands to interact.
