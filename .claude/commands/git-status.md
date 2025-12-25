# Git Status Overview

Show comprehensive git repository status.

## Instructions

### Status Information

1. **Repository Status**
```bash
git status
```

2. **Branch Information**
```bash
# Current branch
git branch --show-current

# Branch tracking
git branch -vv

# Recent commits
git log --oneline -10
```

3. **Changes Summary**
```bash
# Staged changes
git diff --cached --stat

# Unstaged changes
git diff --stat

# Untracked files
git status --porcelain | grep "^??"
```

4. **Remote Status**
```bash
# Fetch latest
git fetch --all --prune

# Ahead/behind
git rev-list --left-right --count HEAD...origin/$(git branch --show-current)
```

### Output Format

```
Git Status Report
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Branch: feature/my-feature
Tracking: origin/feature/my-feature

Status: 2 ahead, 0 behind origin

Changes:
  Staged:     3 files (+45, -12)
  Modified:   2 files
  Untracked:  1 file

Recent Commits:
  abc1234 feat(core): add new utility
  def5678 fix(shared): correct type
  ghi9012 docs: update README

Stash: 1 entry
```

### Quick Actions

Based on status, suggest:
- `git add .` if unstaged changes
- `git commit` if staged changes
- `git push` if ahead of origin
- `git pull` if behind origin

## Arguments

- `$ARGUMENTS` - Optional: `--short`, `--verbose`

## Output

Comprehensive git status with suggested actions.
