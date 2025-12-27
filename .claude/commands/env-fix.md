---
description: Fix environment and dependency issues
allowed-tools: Bash(uv:*), Bash(make:*), Bash(rm:*), Bash(pip:*), Read, Glob
argument-hint: [issue-type]
---

# Fix Environment Issues

Diagnose and fix common environment problems.

## Arguments

- `$1` - Issue type: `deps`, `cache`, `venv`, `types`, `all` (default: `all`)

## Current State

Check environment health:

!`uv --version 2>/dev/null || echo "UV not installed"`

!`python --version 2>/dev/null || echo "Python not found"`

## Instructions

Based on the issue type, perform the following fixes:

### `deps` - Dependency Issues

1. Clear UV cache: `uv cache clean`
2. Remove lock file if corrupted
3. Re-sync dependencies: `uv sync`
4. Verify installation: `uv pip list`

### `cache` - Cache Issues

1. Remove Python cache:
   ```bash
   find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null
   find . -type f -name "*.pyc" -delete 2>/dev/null
   ```
2. Remove MyPy cache: `rm -rf .mypy_cache`
3. Remove Pytest cache: `rm -rf .pytest_cache`
4. Remove Ruff cache: `rm -rf .ruff_cache`

### `venv` - Virtual Environment Issues

1. Remove existing venv: `rm -rf .venv`
2. Recreate venv: `uv venv`
3. Sync dependencies: `uv sync`

### `types` - Type Checking Issues

1. Remove MyPy cache: `rm -rf .mypy_cache`
2. Run type check: `uv run mypy packages apps --ignore-missing-imports`
3. Report any remaining issues

### `all` - Complete Fix

Run all fixes in order: cache → venv → deps → types

## Output

Report what was fixed and current environment status.

## Example

```bash
# Fix all issues
/env-fix all

# Fix only dependency issues
/env-fix deps

# Clear all caches
/env-fix cache
```
