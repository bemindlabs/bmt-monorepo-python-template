# Backlog Refinement

Conduct backlog refinement (grooming) sessions to prepare items for upcoming sprints.

## Instructions

### Refinement Session Process

1. Create refinement document: `.scrum/refinement/YYYY-MM-DD-refinement.md`
2. Use template:

```markdown
# Backlog Refinement Session

**Date:** {YYYY-MM-DD}
**Duration:** {X} hours
**Facilitator:**
**Attendees:**

## Session Goals

- [ ] Refine top {X} backlog items
- [ ] Estimate unestimated items
- [ ] Clarify acceptance criteria
- [ ] Break down large items

## Items Refined

### {MONO-XXX}: {Title}

**Original Description:**
{description}

**Refined Description:**
{updated description with clarity}

**Acceptance Criteria:**
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

**Story Points:** {X} (was: unestimated/Y)

**Dependencies:**
- {dependency 1}

**Questions Resolved:**
- Q: {question}
  A: {answer}

**Technical Notes:**
- {implementation consideration}

**Ready for Sprint:** Yes/No

---

### {MONO-YYY}: {Title}
...

## Items Requiring Further Refinement

| ID | Title | Blocker | Next Steps |
|----|-------|---------|------------|
|    |       |         |            |

## Items Split

### Original: {MONO-XXX} ({large item})
Split into:
- {MONO-XXX-A}: {subtask 1} ({X} pts)
- {MONO-XXX-B}: {subtask 2} ({X} pts)
- {MONO-XXX-C}: {subtask 3} ({X} pts)

## New Items Identified

| Title | Description | Priority | Source |
|-------|-------------|----------|--------|
|       |             |          |        |

## Parking Lot

Items discussed but deferred:
-

## Action Items

| Action | Owner | Due |
|--------|-------|-----|
|        |       |     |

## Session Notes

-
```

### Refinement Actions

#### Default - Start refinement session

1. Load unrefined backlog items
2. Sort by priority
3. Display items needing refinement
4. Create session document

#### `list` - Show items needing refinement

1. Identify items without:
   - Acceptance criteria
   - Story point estimates
   - Clear descriptions
2. Display refinement queue

```
Items Needing Refinement
━━━━━━━━━━━━━━━━━━━━━━━━

No Estimate:
  MONO-005: Add export feature
  MONO-007: Improve search

No Acceptance Criteria:
  MONO-003: User notifications
  MONO-008: API rate limiting

Large Items (>13 pts):
  MONO-004: Complete auth overhaul (21 pts)

Ready for Sprint: 5/12 items
```

#### `refine {item-id}` - Refine specific item

1. Display current item details
2. Prompt for refined description
3. Define acceptance criteria
4. Estimate story points
5. Identify dependencies
6. Mark as refined

#### `estimate {item-id}` - Estimate single item

1. Display item for estimation
2. Use planning poker or direct input
3. Record estimate with rationale
4. Update backlog

#### `split {item-id}` - Split large item

1. Identify natural split points
2. Create child items
3. Distribute story points
4. Link to parent item
5. Update backlog

#### `criteria {item-id}` - Add acceptance criteria

1. Display item description
2. Prompt for acceptance criteria
3. Validate criteria are testable
4. Save to item

#### `ready` - Check sprint readiness

1. Scan top backlog items
2. Verify each has:
   - Clear description
   - Acceptance criteria
   - Story point estimate
   - No blocking dependencies
3. Report readiness status

```
Sprint Readiness Check
━━━━━━━━━━━━━━━━━━━━━━

✓ MONO-001: Add FastAPI example (5 pts) - READY
✓ MONO-002: Add CLI tool (3 pts) - READY
✗ MONO-003: User notifications - Missing: Acceptance criteria
✓ MONO-004: Fix auth flow (2 pts) - READY
✗ MONO-005: Export feature - Missing: Estimate, Criteria

Ready: 3/5 top items
Recommendation: Refine MONO-003 and MONO-005 before planning
```

### Refinement Guidelines

**Definition of Ready:**
- [ ] Description is clear and complete
- [ ] Acceptance criteria defined
- [ ] Story points estimated
- [ ] Dependencies identified
- [ ] No open questions
- [ ] Small enough for one sprint

**Estimation Guidelines:**
- 1 pt: Trivial, < 2 hours
- 2 pts: Small, half day
- 3 pts: Medium, 1 day
- 5 pts: Large, 2-3 days
- 8 pts: Very large, 3-5 days
- 13 pts: Epic-sized, consider splitting
- 21 pts: Too large, must split

### INVEST Criteria Check

Good user stories are:
- **I**ndependent: No dependencies on other stories
- **N**egotiable: Details can be discussed
- **V**aluable: Delivers value to user/business
- **E**stimable: Can be reasonably estimated
- **S**mall: Fits within a sprint
- **T**estable: Has clear acceptance criteria

## Arguments

- `$ARGUMENTS` - Optional: `list`, `refine {id}`, `estimate {id}`, `split {id}`, `criteria {id}`, `ready`

## Output

Conduct refinement session and prepare backlog items for sprint planning.
