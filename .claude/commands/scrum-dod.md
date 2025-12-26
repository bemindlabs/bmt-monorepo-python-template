# Definition of Done

Manage and verify the Definition of Done (DoD) for the team.

## Instructions

### Definition of Done Management

1. Store DoD in `.scrum/definition-of-done.md`
2. Default template:

```markdown
# Definition of Done

Last Updated: {YYYY-MM-DD}

## Code Complete

- [ ] All acceptance criteria met
- [ ] Code follows style guidelines (lint passes)
- [ ] No new warnings or errors
- [ ] Self-reviewed before PR

## Testing

- [ ] Unit tests written and passing
- [ ] Integration tests passing (if applicable)
- [ ] Test coverage >= 80%
- [ ] Edge cases considered and tested

## Code Quality

- [ ] Type checking passes (MyPy)
- [ ] No security vulnerabilities introduced
- [ ] No hardcoded secrets or credentials
- [ ] Code is DRY (no unnecessary duplication)

## Documentation

- [ ] Code comments for complex logic
- [ ] API documentation updated (if applicable)
- [ ] README updated (if applicable)
- [ ] Changelog entry added

## Review

- [ ] Pull request created
- [ ] Code review completed
- [ ] Review feedback addressed
- [ ] Approved by at least one reviewer

## Deployment

- [ ] CI/CD pipeline passes
- [ ] No breaking changes (or migration provided)
- [ ] Feature flags configured (if applicable)
- [ ] Rollback plan documented (for major changes)

## Verification

- [ ] Tested in development environment
- [ ] Product Owner acceptance (if required)
- [ ] Demo prepared for sprint review
```

### DoD Actions

#### Default - Show current DoD

1. Display current Definition of Done
2. Show last update date
3. List all criteria

#### `check {item-id}` - Check item against DoD

1. Load item details
2. Present DoD checklist
3. Prompt for each criterion
4. Calculate completion percentage
5. Report status

```
DoD Check: MONO-001 - Add FastAPI example
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Code Complete:
  ✓ All acceptance criteria met
  ✓ Code follows style guidelines
  ✓ No new warnings or errors
  ✓ Self-reviewed before PR

Testing:
  ✓ Unit tests written and passing
  ✓ Integration tests passing
  ✓ Test coverage >= 80%
  ✗ Edge cases considered

Code Quality:
  ✓ Type checking passes
  ✓ No security vulnerabilities
  ✓ No hardcoded secrets
  ✓ Code is DRY

Documentation:
  ✓ Code comments for complex logic
  ✗ API documentation updated
  ✓ README updated
  ✓ Changelog entry added

Review:
  ✓ Pull request created
  ✓ Code review completed
  ✓ Review feedback addressed
  ✓ Approved by reviewer

Deployment:
  ✓ CI/CD pipeline passes
  ✓ No breaking changes
  ○ Feature flags (N/A)
  ○ Rollback plan (N/A)

Verification:
  ✓ Tested in development
  ✗ Product Owner acceptance
  ✓ Demo prepared

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Status: 85% Complete (17/20 criteria)
Blockers: 3 items need attention

NOT DONE - Address blockers before marking complete
```

#### `update` - Update DoD criteria

1. Display current DoD
2. Prompt for changes
3. Add/remove/modify criteria
4. Update timestamp
5. Save changes

#### `add {criterion}` - Add new criterion

1. Add criterion to appropriate section
2. Update DoD file
3. Notify team of change

#### `remove {criterion}` - Remove criterion

1. Mark criterion for removal
2. Confirm removal
3. Update DoD file
4. Document reason

#### `history` - Show DoD change history

1. Display version history
2. Show what changed and when
3. Show who made changes

#### `report` - Sprint DoD compliance report

1. Check all completed items against DoD
2. Calculate compliance percentage
3. Identify common gaps
4. Generate improvement suggestions

```
Sprint {n} DoD Compliance Report
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Items Completed: 8

Compliance by Category:
  Code Complete:    100% ████████████████████
  Testing:           88% █████████████████░░░
  Code Quality:     100% ████████████████████
  Documentation:     75% ███████████████░░░░░
  Review:           100% ████████████████████
  Deployment:       100% ████████████████████
  Verification:      88% █████████████████░░░

Overall Compliance: 93%

Common Gaps:
  - API documentation not updated (2 items)
  - Edge cases not fully tested (1 item)

Recommendations:
  1. Add documentation checklist to PR template
  2. Include edge case review in code review process
```

### DoD Best Practices

- Keep DoD visible and accessible
- Review and update DoD each sprint
- All team members should understand DoD
- DoD should be realistic and achievable
- Add criteria incrementally as team matures
- Remove criteria that are always met automatically

## Arguments

- `$ARGUMENTS` - Optional: `check {item-id}`, `update`, `add {criterion}`, `remove {criterion}`, `history`, `report`

## Output

Display, manage, or verify Definition of Done criteria.
