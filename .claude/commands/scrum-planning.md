# Sprint Planning

Conduct comprehensive sprint planning sessions following the Scrum framework.

## Instructions

### Planning Session Process

1. Create planning document: `.scrum/planning/sprint-{n}-planning.md`
2. Use template:

```markdown
# Sprint {n} Planning

**Date:** {YYYY-MM-DD}
**Duration:** {X} hours
**Facilitator:**
**Attendees:**

## Sprint Goal

> {Clear, concise sprint goal that provides focus}

## Capacity Planning

| Team Member | Available Days | Capacity (hrs) | Notes |
|-------------|----------------|----------------|-------|
|             |                |                |       |

**Total Team Capacity:** {X} hours
**Recommended Story Points:** {X} (based on velocity)

## Selected Backlog Items

| ID | Title | Points | Acceptance Criteria | Assigned |
|----|-------|--------|---------------------|----------|
|    |       |        |                     |          |

**Total Points:** {X}
**Sprint Load:** {X}% of capacity

## Task Breakdown

### {MONO-XXX}: {Title}
- [ ] Task 1 (Xh)
- [ ] Task 2 (Xh)
- [ ] Task 3 (Xh)

## Dependencies & Risks

| Risk/Dependency | Impact | Mitigation |
|-----------------|--------|------------|
|                 |        |            |

## Definition of Done Reminder

- [ ] Code complete with tests
- [ ] Code reviewed and approved
- [ ] Documentation updated
- [ ] All acceptance criteria met

## Agreements

- Sprint start: {YYYY-MM-DD}
- Sprint end: {YYYY-MM-DD}
- Daily standup time: {HH:MM}
- Sprint review scheduled: {YYYY-MM-DD HH:MM}
```

### Planning Actions

#### Default - Start new planning session

1. Review last sprint velocity from `.scrum/velocity.json`
2. Calculate team capacity
3. Present prioritized backlog items
4. Facilitate item selection based on capacity
5. Create sprint goal
6. Save planning document

#### `capacity` - Calculate team capacity

1. Prompt for team member availability
2. Calculate total available hours
3. Recommend story points based on velocity
4. Display capacity summary

```
Team Capacity for Sprint {n}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Available Days: 10
Total Capacity: 80 hours
Historical Velocity: 34 pts/sprint
Recommended Load: 30-38 points
```

#### `goal {description}` - Set sprint goal

1. Validate goal is specific and achievable
2. Link goal to selected items
3. Update sprint file

#### `select {item-ids}` - Select backlog items

1. Validate items exist in backlog
2. Check total points vs capacity
3. Move items to sprint
4. Display updated sprint

#### `breakdown {item-id}` - Break down item into tasks

1. Display item details
2. Prompt for task breakdown
3. Estimate task hours
4. Save tasks to planning document

#### `finalize` - Complete planning session

1. Validate sprint goal exists
2. Confirm all items have tasks
3. Create sprint file in `.scrum/sprints/`
4. Archive planning document
5. Notify team

### Velocity Reference

Display velocity trend:
```
Last 5 Sprints Velocity
Sprint 5: ████████████████████ 34
Sprint 4: ██████████████████░░ 31
Sprint 3: ███████████████████░ 33
Sprint 2: ████████████████░░░░ 28
Sprint 1: ██████████████░░░░░░ 25
Average: 30.2 pts/sprint
```

### Planning Poker (Optional)

For estimation during planning:
1. Present item to team
2. Each member selects estimate (1,2,3,5,8,13,21)
3. Reveal estimates simultaneously
4. Discuss outliers
5. Re-vote or accept consensus

## Arguments

- `$ARGUMENTS` - Optional: `capacity`, `goal {description}`, `select {ids}`, `breakdown {id}`, `finalize`

## Output

Create comprehensive sprint planning documentation and initialize sprint.
