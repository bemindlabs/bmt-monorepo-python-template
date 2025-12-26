# Fix GitHub Issues

Fetch open GitHub issues and systematically fix them.

## Instructions

### 1. Fetch Open Issues

```bash
gh issue list --state open --limit 20 --json number,title,labels,body,assignees
```

### 2. Issue Processing Workflow

For each issue:

1. **Analyze the issue**
   - Read issue title and description
   - Check labels (bug, enhancement, feature, etc.)
   - Understand acceptance criteria

2. **Create feature branch**
   ```bash
   git checkout -b fix/issue-{number}-{slug}
   ```

3. **Implement the fix**
   - Follow existing code patterns
   - Maintain type safety
   - Add/update tests as needed

4. **Verify the fix**
   ```bash
   make lint
   make type-check
   make test
   ```

5. **Commit with issue reference**
   ```bash
   git commit -m "fix(scope): description

   Fixes #{number}"
   ```

6. **Create PR linking the issue**
   ```bash
   gh pr create --title "fix: description" --body "Fixes #{number}"
   ```

### 3. Actions

#### Default - List and fix issues

1. Fetch open issues from GitHub
2. Display issues sorted by priority/labels
3. For each issue (or selected issues):
   - Analyze requirements
   - Implement fix
   - Run quality checks
   - Commit and create PR

#### `list` - List open issues only

```bash
gh issue list --state open --limit 30
```

Display format:
```
Open Issues
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

#123 [bug]         Fix auth token refresh
#124 [enhancement] Add retry logic to API client
#125 [feature]     Implement user preferences
#126 [bug]         Handle null response in parser

Total: 4 open issues
```

#### `fix {number}` - Fix specific issue

1. Fetch issue details: `gh issue view {number} --json title,body,labels`
2. Create branch
3. Implement fix
4. Run checks
5. Commit and PR

#### `batch {numbers}` - Fix multiple issues

Process multiple issues: `/github-fix-issues batch 123,124,125`

1. Fetch all specified issues
2. Group by affected area
3. Fix sequentially or create combined PR

#### `triage` - Triage and prioritize

1. List all open issues
2. Categorize by type and severity
3. Suggest fix order
4. Estimate complexity

```
Issue Triage
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Critical (fix immediately):
  #123 [bug] Fix auth token refresh

High Priority:
  #126 [bug] Handle null response in parser

Medium Priority:
  #124 [enhancement] Add retry logic

Backlog:
  #125 [feature] Implement user preferences

Recommended: Start with #123 (critical bug)
```

### 4. Issue Labels Priority

| Label | Priority | Action |
|-------|----------|--------|
| `critical` | P0 | Fix immediately |
| `bug` | P1 | High priority |
| `security` | P1 | High priority |
| `enhancement` | P2 | Medium priority |
| `feature` | P3 | Normal priority |
| `good first issue` | P3 | Normal priority |
| `documentation` | P4 | Low priority |

### 5. Fix Verification Checklist

Before marking issue as fixed:

- [ ] Root cause identified
- [ ] Fix implemented correctly
- [ ] Tests added/updated
- [ ] All checks pass (lint, type, test)
- [ ] PR created with issue reference
- [ ] Regression tested

### 6. Closing Issues

Issues are auto-closed when PR is merged using keywords:
- `Fixes #123`
- `Closes #123`
- `Resolves #123`

### 7. Progress Tracking

Track fixing progress in session:

```
Issue Fixing Progress
━━━━━━━━━━━━━━━━━━━━━

✓ #123 - Fixed (PR #130)
✓ #124 - Fixed (PR #131)
◐ #125 - In progress
○ #126 - Pending

Completed: 2/4 (50%)
```

## Arguments

- `$ARGUMENTS` - Optional: `list`, `fix {number}`, `batch {numbers}`, `triage`

## Output

List issues and/or create fixes with proper commits and PRs.
