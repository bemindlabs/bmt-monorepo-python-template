# Collect Agent Results

Collect and consolidate results from completed agent work.

## Instructions

### Collection Process

1. **Scan Completed Work**
   - Check `.agents/completed/*.json`
   - List completed items

2. **For Each Completed Item**

   a. **Verify Branch**
   ```bash
   git fetch origin
   git log origin/feature/{item-id} --oneline -5
   ```

   b. **Check Quality**
   ```bash
   git checkout feature/{item-id}
   make zero-qa
   ```

   c. **Review Changes**
   ```bash
   git diff main...feature/{item-id} --stat
   ```

   d. **Create PR** (if quality passes)
   ```bash
   gh pr create --base main --head feature/{item-id} \
     --title "feat: {item-title}" \
     --body "Closes #{item-id}"
   ```

3. **Update Tracking**
   - Mark item as collected in `.agents/collected/`
   - Update backlog item status
   - Archive session data

### Collection Report

```
Agent Collection Report
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Collected Items: 3

| Item     | Agent   | Quality | PR        |
|----------|---------|---------|-----------|
| MONO-001 | agent-1 | PASS    | #12       |
| MONO-002 | agent-2 | PASS    | #13       |
| MONO-003 | agent-3 | FAIL    | -         |

Summary:
- PRs Created: 2
- Quality Failed: 1
- Pending Review: 2
```

### Failed Collection

If quality checks fail:
1. Log failure reason
2. Keep item in completed (not collected)
3. Report issues for manual review

## Arguments

- `$ARGUMENTS` - Optional: `all`, `{item-id}`, `--dry-run`

## Output

Collection report with created PRs and any failures.
