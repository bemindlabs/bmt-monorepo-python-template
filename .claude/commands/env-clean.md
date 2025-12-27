---
description: Clean environment artifacts and caches
allowed-tools: Bash(rm:*), Bash(find:*), Bash(make:*), Read
argument-hint: [level]
---

# Clean Environment

Remove build artifacts, caches, and temporary files.

## Arguments

- `$1` - Clean level: `cache`, `build`, `all`, `deep` (default: `cache`)

## Current State

Check disk usage of common artifacts:

!`du -sh .mypy_cache .pytest_cache .ruff_cache __pycache__ .venv dist build 2>/dev/null | sort -hr`

## Instructions

Based on the clean level, remove the following:

### `cache` - Remove Caches Only

```bash
# Python bytecode
find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null
find . -type f -name "*.pyc" -delete 2>/dev/null
find . -type f -name "*.pyo" -delete 2>/dev/null

# Tool caches
rm -rf .mypy_cache
rm -rf .pytest_cache
rm -rf .ruff_cache
rm -rf .coverage
rm -rf htmlcov
```

### `build` - Remove Build Artifacts

```bash
# Distribution files
rm -rf dist
rm -rf build
rm -rf *.egg-info
find . -type d -name "*.egg-info" -exec rm -rf {} + 2>/dev/null

# Package builds
find packages -type d -name "dist" -exec rm -rf {} + 2>/dev/null
find apps -type d -name "dist" -exec rm -rf {} + 2>/dev/null
```

### `all` - Cache + Build

Run both `cache` and `build` cleanup.

### `deep` - Complete Clean (Destructive)

**WARNING**: This removes the virtual environment!

```bash
# All of the above plus:
rm -rf .venv
rm -rf node_modules  # If JS exists
rm -rf .uv           # UV cache

# After deep clean, remind user to run:
# uv sync
```

## Output

Report what was removed and disk space freed.

## Safety

- NEVER delete `.env` files
- NEVER delete source code
- NEVER delete git history
- Always confirm before `deep` clean

## Example

```bash
# Quick cache clean
/env-clean cache

# Full cleanup before release
/env-clean all

# Nuclear option (requires confirmation)
/env-clean deep
```
