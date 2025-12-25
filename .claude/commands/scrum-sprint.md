# Sprint Management

Manage sprint planning, execution, and completion.

## Instructions

### Sprint Actions

Based on `$ARGUMENTS`, perform one of these actions:

#### `start` - Start new sprint

1. Create new sprint file: `.scrum/sprints/sprint-{n}.json`
2. Move selected backlog items to sprint
3. Set sprint dates (14-day duration by default)

```json
{
  "id": "sprint-{n}",
  "name": "Sprint {n}",
  "start_date": "YYYY-MM-DD",
  "end_date": "YYYY-MM-DD",
  "goal": "",
  "items": [],
  "status": "active",
  "velocity": 0
}
```

#### `plan` - Plan sprint items

1. Display backlog items by priority
2. Select items for sprint (consider velocity)
3. Update sprint items list
4. Calculate sprint capacity

#### `status` - Show sprint status

1. Display current sprint progress
2. Show burndown metrics
3. List item statuses

```
Sprint 1: Day 5 of 14
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 35%

Items: 3/8 completed (5 in progress)
Points: 13/34 completed

┌─────────────────────────────────────────┐
│ In Progress                             │
├─────────┬───────────────────────────────┤
│ MONO-01 │ Add FastAPI example           │
│ MONO-02 │ Add CLI tool                  │
└─────────┴───────────────────────────────┘
```

#### `close` - End sprint

1. Move incomplete items back to backlog
2. Calculate actual velocity
3. Update sprint status to "completed"
4. Archive sprint data

#### `review` - Sprint review

1. Summarize completed work
2. Calculate velocity
3. Generate sprint report

### Sprint Metrics

Track in `.scrum/velocity.json`:
- Planned vs actual points
- Velocity trend
- Completion rate

## Arguments

- `$ARGUMENTS` - Action: `start`, `plan`, `status`, `close`, `review`

## Output

Execute sprint action and display relevant sprint information.
