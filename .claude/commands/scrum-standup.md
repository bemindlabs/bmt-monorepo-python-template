# Daily Standup

Record and manage daily standup notes.

## Instructions

### Standup Process

1. Create standup entry in `.scrum/standups/YYYY-MM-DD.md`
2. Use template:

```markdown
# Daily Standup - {YYYY-MM-DD}

## What I Did Yesterday

-

## What I'm Doing Today

-

## Blockers

-

## Notes

-
```

### Standup Actions

#### Default - Record today's standup

1. Create/open today's standup file
2. Prompt for each section
3. Save standup entry

#### `list` - List recent standups

1. Show last 7 standup entries
2. Display summaries

#### `view {date}` - View specific standup

1. Display standup for given date

#### `blockers` - Show current blockers

1. Scan recent standups for blockers
2. Display unresolved blockers

### Quick Entry Format

If `$ARGUMENTS` contains standup content:

```
/scrum-standup "Done: X, Y | Today: A, B | Blocked: none"
```

Parse and create structured entry.

### Integration

- Link blockers to backlog items
- Update sprint burndown
- Track patterns over time

## Arguments

- `$ARGUMENTS` - Optional: `list`, `view {date}`, `blockers`, or quick entry string

## Output

Create/display standup entry with formatted output.
