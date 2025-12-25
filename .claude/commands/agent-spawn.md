# Spawn Multi-Agent Workflow

Spawn multi-agent workflow in tmux sessions for parallel backlog implementation.

## Instructions

### Spawning Agents

Based on `$ARGUMENTS`, spawn Claude Code agents in tmux sessions:

#### `spawn {count}` - Spawn multiple agents

1. Check if tmux is available
2. Create a new tmux session named `agents-{timestamp}`
3. For each agent (1 to count):
   - Create a new tmux window named `agent-{n}`
   - Start Claude Code in that window
   - Assign a backlog item from `.scrum/backlog.json` (prioritized)
4. Save session info to `.agents/sessions/{session-id}.json`

#### `spawn {item-ids}` - Spawn agents for specific items

1. Parse comma-separated item IDs
2. Create tmux windows for each item
3. Assign specific backlog items to agents
4. Track assignments in `.agents/assignments.json`

### Session Commands

```bash
# Create tmux session
tmux new-session -d -s agents-$(date +%s)

# Create window for agent
tmux new-window -t agents -n agent-1

# Start Claude Code with task
tmux send-keys -t agents:agent-1 'claude "Work on MONO-001"' Enter
```

### Agent Configuration

Store in `.agents/config.json`:

```json
{
  "maxConcurrentAgents": 5,
  "defaultModel": "sonnet",
  "autoCollect": true,
  "sessionPrefix": "agents",
  "workingBranch": "feature/{item-id}"
}
```

### Agent Assignment

Each agent receives:

```markdown
You are working on backlog item: {ITEM-ID}
Branch: feature/{item-slug}

## Task
{item description}

## Acceptance Criteria
{acceptance criteria}

## Instructions
1. Create feature branch from main
2. Implement the feature
3. Write tests (80%+ coverage)
4. Run quality checks: make zero-qa
5. Commit with conventional commit message
6. Signal completion
```

### Tracking Structure

```
.agents/
├── config.json           # Agent configuration
├── sessions/             # Active session records
├── assignments.json      # Current item-to-agent mapping
├── completed/            # Completed work markers
└── logs/                 # Agent output logs
```

## Arguments

- `$ARGUMENTS` - `{count}` or `{item-ids}` (comma-separated)

## Output

Display spawned agent sessions with assigned items and tmux attach commands.
