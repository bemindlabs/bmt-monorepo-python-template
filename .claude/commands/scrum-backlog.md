# Manage Product Backlog

Manage the product backlog for agile development.

## Instructions

### Backlog Actions

Based on `$ARGUMENTS`, perform one of these actions:

#### `list` - List backlog items

1. Read items from `.scrum/backlog.json`
2. Display sorted by priority
3. Show item details (ID, title, points, priority, status)

```bash
cat .scrum/backlog.json | python -m json.tool
```

#### `add "{title}"` - Add new backlog item

1. Generate new ID (MONO-XXX)
2. Add to `.scrum/backlog.json`:

```json
{
  "id": "MONO-XXX",
  "title": "{title}",
  "description": "",
  "priority": "medium",
  "story_points": 0,
  "status": "backlog",
  "labels": []
}
```

#### `prioritize {id} {priority}` - Update priority

1. Update item priority (critical, high, medium, low)
2. Re-sort backlog by priority

#### `estimate {id} {points}` - Set story points

1. Update story_points field
2. Use Fibonacci scale: 1, 2, 3, 5, 8, 13, 21

#### `start {id}` - Move to in-progress

1. Update status to "in_progress"
2. Create feature branch: `git checkout -b feature/{id}-{slug}`

#### `done {id}` - Mark as completed

1. Update status to "done"
2. Update metadata.last_updated

### Backlog Display Format

```
┌─────────────────────────────────────────────────────────────┐
│ Product Backlog                          Total: XX pts      │
├──────────┬─────────────────────────┬────────┬───────┬──────┤
│ ID       │ Title                   │ Points │ Pri   │ Status│
├──────────┼─────────────────────────┼────────┼───────┼──────┤
│ MONO-001 │ Add FastAPI example     │ 5      │ high  │ backlog│
│ MONO-002 │ Add CLI tool example    │ 3      │ medium│ backlog│
└──────────┴─────────────────────────┴────────┴───────┴──────┘
```

## Arguments

- `$ARGUMENTS` - Action: `list`, `add "{title}"`, `prioritize {id} {priority}`, `estimate {id} {points}`, `start {id}`, `done {id}`

## Output

Execute the backlog action and show updated backlog status.
