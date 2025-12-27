---
description: Sync environment and dependencies
allowed-tools: Bash(uv:*), Bash(make:*), Bash(git:*), Read
argument-hint: [mode]
---

# Sync Environment

Synchronize dependencies and ensure environment is up-to-date.

## Arguments

- `$1` - Sync mode: `deps`, `lock`, `upgrade`, `dev`, `prod` (default: `deps`)

## Current State

!`git status pyproject.toml uv.lock 2>/dev/null`

## Instructions

### `deps` - Standard Dependency Sync

```bash
# Sync all dependencies from lock file
uv sync

# Verify sync
uv pip check
```

### `lock` - Update Lock File

```bash
# Regenerate lock file from pyproject.toml
uv lock

# Then sync
uv sync
```

### `upgrade` - Upgrade All Dependencies

```bash
# Upgrade all packages to latest compatible versions
uv lock --upgrade

# Sync upgraded dependencies
uv sync

# Run tests to verify
make test
```

### `dev` - Development Environment

```bash
# Sync with all development dependencies
uv sync --all-extras

# Install pre-commit hooks
uv run pre-commit install
```

### `prod` - Production Environment

```bash
# Sync production dependencies only (no dev deps)
uv sync --no-dev

# Verify minimal installation
uv pip list
```

## Post-Sync Checks

After syncing, automatically run:

1. Type check: `uv run mypy packages apps --ignore-missing-imports`
2. Import check: `uv run python -c "import monorepo_core; import monorepo_shared; import monorepo_config"`

## Output

Report sync results:
- Packages added/removed/updated
- Any conflicts or warnings
- Post-sync verification status

## Example

```bash
# Standard sync
/env-sync deps

# Upgrade all packages
/env-sync upgrade

# Setup dev environment
/env-sync dev
```
