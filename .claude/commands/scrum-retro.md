# Sprint Retrospective

Conduct and record sprint retrospectives.

## Instructions

### Retrospective Process

1. Create retro file: `.scrum/retros/sprint-{n}-retro.md`
2. Use template:

```markdown
# Sprint {n} Retrospective

**Date:** {YYYY-MM-DD}
**Facilitator:**
**Attendees:**

## Sprint Summary

- **Goal:**
- **Velocity:** {planned} planned / {actual} completed
- **Completion Rate:** {X}%

## What Went Well

-

## What Could Be Improved

-

## Action Items

| Action | Owner | Due Date | Status |
|--------|-------|----------|--------|
|        |       |          |        |

## Key Metrics

- Stories Completed: X/Y
- Bugs Found: X
- Technical Debt: +/- X points

## Notes

-
```

### Retro Actions

#### Default - Create new retrospective

1. Review completed sprint
2. Gather feedback for each section
3. Create action items
4. Save retrospective

#### `list` - List past retrospectives

1. Show all retrospectives
2. Display key metrics trend

#### `actions` - Show open action items

1. Scan retros for incomplete actions
2. Display pending items

#### `view {sprint}` - View specific retro

1. Display retrospective for sprint

### Facilitation Prompts

**What Went Well:**
- What helped us succeed?
- What should we keep doing?

**What Could Be Improved:**
- What slowed us down?
- What was frustrating?

**Action Items:**
- What specific changes will we make?
- Who owns each action?

## Arguments

- `$ARGUMENTS` - Optional: `list`, `actions`, `view {sprint-id}`

## Output

Create/display retrospective with team feedback and action items.
