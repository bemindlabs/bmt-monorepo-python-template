# Sprint Review

Conduct sprint review/demo sessions to showcase completed work to stakeholders.

## Instructions

### Sprint Review Process

1. Create review document: `.scrum/reviews/sprint-{n}-review.md`
2. Use template:

```markdown
# Sprint {n} Review

**Date:** {YYYY-MM-DD}
**Duration:** {X} minutes
**Facilitator:**
**Attendees:**
- Product Owner:
- Stakeholders:
- Team Members:

## Sprint Summary

**Sprint Goal:** {goal}
**Goal Achieved:** Yes/Partially/No

### Metrics

| Metric | Planned | Actual | % |
|--------|---------|--------|---|
| Story Points | X | Y | Z% |
| Items Completed | X | Y | Z% |
| Bugs Fixed | - | X | - |

## Completed Work

### {MONO-XXX}: {Title}
**Demo:** {Description of what will be demonstrated}
**Demonstrated by:** {Name}
**Acceptance Criteria Met:** Yes/No
**Stakeholder Feedback:**
-

### {MONO-YYY}: {Title}
...

## Items Not Completed

| ID | Title | Reason | Action |
|----|-------|--------|--------|
|    |       |        | Move to next sprint / Return to backlog |

## Product Backlog Updates

Based on feedback, the following changes are proposed:

### New Items
| Title | Priority | Notes |
|-------|----------|-------|
|       |          |       |

### Reprioritized Items
| ID | Old Priority | New Priority | Reason |
|----|--------------|--------------|--------|
|    |              |              |        |

## Stakeholder Feedback Summary

| Stakeholder | Feedback | Action Item |
|-------------|----------|-------------|
|             |          |             |

## Demo Notes

-

## Next Steps

1.
2.
3.
```

### Review Actions

#### Default - Conduct sprint review

1. Load current sprint from `.scrum/sprints/`
2. Gather completed items with demo notes
3. Calculate sprint metrics
4. Create review document
5. Prompt for stakeholder feedback

#### `prepare` - Prepare demo agenda

1. List all completed items
2. Assign demo responsibilities
3. Create demo script/outline
4. Estimate demo duration

```
Sprint {n} Review Agenda
━━━━━━━━━━━━━━━━━━━━━━━━
Total Duration: ~45 minutes

1. Sprint Goal Recap (5 min)
2. Demos:
   - MONO-001: Add FastAPI example (10 min) - @developer1
   - MONO-002: Add CLI tool (8 min) - @developer2
   - MONO-003: Fix auth bug (5 min) - @developer3
3. Metrics Review (5 min)
4. Stakeholder Feedback (10 min)
5. Backlog Updates (5 min)
```

#### `demo {item-id}` - Record demo for specific item

1. Display item details
2. Record demo notes
3. Capture stakeholder feedback
4. Update item status

#### `feedback` - Collect stakeholder feedback

1. Display completed work summary
2. Prompt for feedback per item
3. Capture new backlog suggestions
4. Record priority change requests

#### `metrics` - Show sprint metrics

1. Calculate velocity
2. Compare planned vs actual
3. Show completion rate
4. Display trend chart

```
Sprint {n} Metrics
━━━━━━━━━━━━━━━━━
Velocity: 32 points (planned: 34)
Completion: 94%

Items:
  Completed: ████████████████████ 8
  Partial:   ██░░░░░░░░░░░░░░░░░░ 1
  Incomplete:░░░░░░░░░░░░░░░░░░░░ 0

Goal Status: Achieved
```

#### `finalize` - Complete review session

1. Save all feedback
2. Update backlog with new items
3. Archive review document
4. Generate summary for stakeholders

### Review Best Practices

- Focus on demonstrating working software
- Keep demos concise and relevant
- Encourage stakeholder questions
- Document all feedback
- Update product backlog based on input
- Celebrate team achievements

## Arguments

- `$ARGUMENTS` - Optional: `prepare`, `demo {item-id}`, `feedback`, `metrics`, `finalize`

## Output

Conduct comprehensive sprint review and capture stakeholder feedback.
