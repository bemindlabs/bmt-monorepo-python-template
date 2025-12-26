# Fix GitHub PR Review Issues

Fetch PR review comments and systematically address them.

## Instructions

### 1. Fetch PR Review Comments

```bash
# Get current PR number from branch
gh pr view --json number,title,reviews,comments,reviewDecision

# Get review comments with details
gh api repos/{owner}/{repo}/pulls/{pr_number}/comments --jq '.[] | {id, path, line, body, user: .user.login}'
```

### 2. Review Processing Workflow

For each review comment:

1. **Analyze the comment**
   - Read the feedback
   - Understand the requested change
   - Identify affected files and lines

2. **Categorize the feedback**
   - Code style/formatting
   - Logic/implementation issue
   - Security concern
   - Performance improvement
   - Documentation request
   - Question/clarification

3. **Implement the fix**
   - Follow existing code patterns
   - Maintain type safety
   - Address the specific concern

4. **Verify the fix**
   ```bash
   make lint
   make type-check
   make test
   ```

5. **Commit with reference**
   ```bash
   git commit -m "fix(scope): address review feedback

   Addresses PR review comments"
   ```

6. **Push and notify**
   ```bash
   git push
   ```

### 3. Actions

#### Default - List and fix PR review issues

1. Detect current PR from branch
2. Fetch all review comments
3. Display comments grouped by file
4. For each comment:
   - Analyze feedback
   - Implement fix
   - Run quality checks
   - Commit changes
5. Push all fixes

#### `list` - List review comments only

```bash
gh pr view --json reviews,comments
```

Display format:
```
PR Review Comments
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

PR #123: Add user authentication

Review Status: CHANGES_REQUESTED

Comments (4):

📁 src/auth/handler.py
  L45 @reviewer: "Consider using a constant for the timeout value"
  L78 @reviewer: "This should handle the null case"

📁 src/utils/validator.py
  L12 @reviewer: "Missing type hint for return value"

📁 tests/test_auth.py
  L30 @reviewer: "Add test for edge case when token is expired"

Pending: 4 | Resolved: 0
```

#### `fix {pr-number}` - Fix specific PR

1. Fetch PR details: `gh pr view {pr-number} --json ...`
2. Get review comments
3. Implement fixes
4. Run checks
5. Commit and push

#### `current` - Fix current branch's PR

Automatically detect PR from current branch and fix.

#### `comment {pr-number} {message}` - Reply to review

```bash
gh pr comment {pr-number} --body "{message}"
```

#### `resolve {comment-id}` - Mark comment as resolved

```bash
gh api graphql -f query='
  mutation {
    resolveReviewThread(input: {threadId: "{thread-id}"}) {
      thread { isResolved }
    }
  }'
```

### 4. Comment Priority

| Type | Priority | Action |
|------|----------|--------|
| Security | P0 | Fix immediately |
| Bug/Logic | P1 | High priority |
| Breaking change | P1 | High priority |
| Performance | P2 | Medium priority |
| Code style | P3 | Normal priority |
| Documentation | P4 | Low priority |
| Nitpick | P4 | Optional |

### 5. Review Comment Analysis

For each comment:

```
Comment Analysis
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

File: src/auth/handler.py
Line: 45
Reviewer: @senior-dev
Type: Code improvement

Comment:
  "Consider using a constant for the timeout value
   instead of a magic number"

Current Code:
  response = await client.get(url, timeout=30)

Suggested Fix:
  1. Add constant: AUTH_TIMEOUT_SECONDS = 30
  2. Replace: timeout=AUTH_TIMEOUT_SECONDS

Files to Modify:
  - src/auth/handler.py
  - src/auth/constants.py (if exists)
```

### 6. Fix Verification Checklist

Before pushing fixes:

- [ ] All comments addressed
- [ ] Changes match reviewer's intent
- [ ] No new issues introduced
- [ ] All checks pass (lint, type, test)
- [ ] Commit messages reference PR
- [ ] No unrelated changes included

### 7. Handling Different Review Types

#### Requested Changes
- Must be addressed before merge
- Fix all blocking comments
- Request re-review after fixes

#### Comments Only
- Address or respond with explanation
- Can merge with maintainer approval

#### Approved with Comments
- Nice-to-have improvements
- Address if time permits
- Can merge without changes

### 8. Review Response Templates

When clarification is needed:

```markdown
Thanks for the feedback! I've addressed this by [explanation].

The change is in commit [sha].
```

When disagreeing:

```markdown
I understand the concern. In this case, I chose [approach] because:
1. [Reason 1]
2. [Reason 2]

Would you prefer a different approach?
```

### 9. Progress Tracking

```
PR Review Fix Progress
━━━━━━━━━━━━━━━━━━━━━

PR #123: Add user authentication

✓ src/auth/handler.py:45 - Fixed (constant added)
✓ src/auth/handler.py:78 - Fixed (null check added)
◐ src/utils/validator.py:12 - In progress
○ tests/test_auth.py:30 - Pending

Completed: 2/4 (50%)

Latest commit: abc123f
Ready for re-review: No
```

### 10. Batch Operations

Fix all comments in one go:

```bash
# Fetch all, fix all, commit all
/github-fix-pr current

# Then push
git push

# Request re-review
gh pr edit --add-reviewer @original-reviewer
```

## Arguments

- `$ARGUMENTS` - Optional: `list`, `fix {pr-number}`, `current`, `comment {pr-number} {message}`, `resolve {comment-id}`

## Output

List PR review comments and/or implement fixes with proper commits.
