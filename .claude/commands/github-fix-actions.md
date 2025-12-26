# Fix GitHub Actions

Fetch GitHub Actions workflow runs, identify failures, and fix them.

## Instructions

### 1. Check Workflow Status

```bash
gh run list --limit 20 --json status,conclusion,name,headBranch,databaseId,createdAt
```

### 2. Actions Processing Workflow

For failed workflows:

1. **Identify the failure**
   ```bash
   gh run view {run-id} --log-failed
   ```

2. **Analyze error logs**
   - Parse error messages
   - Identify failing step
   - Determine root cause

3. **Implement the fix**
   - Fix code issues
   - Update workflow file if needed
   - Fix dependency issues

4. **Verify locally**
   ```bash
   make lint
   make type-check
   make test
   ```

5. **Push and re-run**
   ```bash
   git push
   gh run rerun {run-id}
   ```

### 3. Actions

#### Default - List and fix failed actions

1. Fetch recent workflow runs
2. Filter to failed/error status
3. Analyze each failure
4. Implement fixes
5. Re-run workflows

#### `list` - List workflow runs

```bash
gh run list --limit 30
```

Display format:
```
GitHub Actions Status
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✓ #456789 CI Pipeline          main       2m ago   success
✗ #456788 CI Pipeline          feature/x  15m ago  failure
✓ #456787 Deploy              main       1h ago   success
✗ #456786 Tests               pr-123     2h ago   failure
○ #456785 CI Pipeline          feature/y  2h ago   in_progress

Failed: 2 | Success: 2 | Running: 1
```

#### `failed` - Show only failed runs

```bash
gh run list --status failure --limit 10
```

#### `fix {run-id}` - Fix specific failed run

1. Fetch run details and logs
   ```bash
   gh run view {run-id}
   gh run view {run-id} --log-failed
   ```

2. Parse failure reason
3. Identify affected files
4. Implement fix
5. Commit and push
6. Re-run workflow

#### `logs {run-id}` - View failure logs

```bash
gh run view {run-id} --log-failed
```

#### `rerun {run-id}` - Re-run failed workflow

```bash
gh run rerun {run-id}
```

#### `rerun-failed` - Re-run all failed workflows

```bash
gh run list --status failure --json databaseId --jq '.[].databaseId' | xargs -I {} gh run rerun {}
```

### 4. Common Failure Types

| Failure Type | Indicator | Fix Approach |
|--------------|-----------|--------------|
| Lint errors | `ruff check failed` | Run `make lint-fix` |
| Type errors | `mypy found errors` | Fix type annotations |
| Test failures | `pytest failed` | Debug and fix tests |
| Build errors | `build failed` | Check dependencies |
| Timeout | `exceeded time limit` | Optimize or increase timeout |
| Network | `connection failed` | Retry or fix URLs |

### 5. Workflow Analysis

For each failed workflow:

```
Workflow Analysis: CI Pipeline (#456788)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Branch: feature/auth-update
Trigger: push
Started: 2024-01-15 10:30:00
Duration: 3m 45s
Status: FAILED

Failed Step: Run tests
━━━━━━━━━━━━━━━━━━━━━━━
Error: AssertionError in test_auth.py:45
  Expected: 200
  Actual: 401

Root Cause: Auth token validation logic changed
Affected Files:
  - src/auth/validator.py
  - tests/test_auth.py

Suggested Fix:
  1. Update auth validator to handle new token format
  2. Fix test expectations
```

### 6. Fix Verification

Before pushing fixes:

- [ ] Error understood and root cause identified
- [ ] Fix implemented
- [ ] Local checks pass
- [ ] Related tests pass
- [ ] No new issues introduced

### 7. Workflow File Fixes

If issue is in workflow file (`.github/workflows/`):

```yaml
# Common fixes:

# Fix: Update action version
- uses: actions/setup-python@v4  # was v3

# Fix: Add missing env variable
env:
  MY_VAR: ${{ secrets.MY_VAR }}

# Fix: Increase timeout
timeout-minutes: 30  # was 10

# Fix: Add retry for flaky steps
uses: nick-fields/retry@v2
with:
  max_attempts: 3
  command: make test
```

### 8. Progress Tracking

```
Actions Fix Progress
━━━━━━━━━━━━━━━━━━━━━

✓ #456788 CI Pipeline - Fixed (lint errors)
✓ #456786 Tests - Fixed (assertion update)
◐ #456790 Deploy - Investigating
○ #456791 Build - Pending

Fixed: 2/4 | Re-runs triggered: 2
```

## Arguments

- `$ARGUMENTS` - Optional: `list`, `failed`, `fix {run-id}`, `logs {run-id}`, `rerun {run-id}`, `rerun-failed`

## Output

List workflow status and/or fix failed GitHub Actions.
