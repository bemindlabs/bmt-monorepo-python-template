---
description: Check environment health and status
allowed-tools: Bash(uv:*), Bash(python:*), Bash(make:*), Bash(which:*), Read, Glob
argument-hint: [component]
---

# Check Environment Health

Verify environment setup, dependencies, and tool availability.

## Arguments

- `$1` - Component to check: `tools`, `deps`, `config`, `all` (default: `all`)

## Instructions

### `tools` - Check Required Tools

Verify all required tools are installed and accessible:

```bash
# Python
python --version
which python

# UV Package Manager
uv --version
which uv

# Git
git --version

# Optional tools
ruff --version 2>/dev/null || echo "Ruff: Not found (run: uv tool install ruff)"
mypy --version 2>/dev/null || echo "MyPy: Not found"
pytest --version 2>/dev/null || echo "Pytest: Not found"
```

### `deps` - Check Dependencies

```bash
# Check UV sync status
uv sync --dry-run

# List installed packages
uv pip list

# Check for outdated packages
uv pip list --outdated 2>/dev/null || echo "Check manually"
```

### `config` - Check Configuration Files

Verify required configuration files exist:

1. `pyproject.toml` - Root project config
2. `.python-version` - Python version
3. `uv.lock` - Dependency lock file
4. `.env.example` - Environment template
5. `Makefile` - Build commands

Check for issues:
- Missing required files
- Syntax errors in TOML/YAML
- Version mismatches

### `all` - Complete Health Check

Run all checks and provide a summary:

```
Environment Health Report
========================

Tools:
  [OK] Python 3.12.x
  [OK] UV 0.x.x
  [OK] Git 2.x.x
  [OK] Ruff
  [OK] MyPy
  [OK] Pytest

Dependencies:
  [OK] All packages synced
  [WARN] 3 packages outdated

Configuration:
  [OK] pyproject.toml
  [OK] uv.lock
  [MISSING] .env (run: /env-generate dev)

Overall: HEALTHY (1 warning)
```

## Output

Provide a clear health report with:
- Status icons: `[OK]`, `[WARN]`, `[ERROR]`, `[MISSING]`
- Actionable fixes for any issues
- Overall health summary

## Example

```bash
# Full health check
/env-check all

# Check only tools
/env-check tools

# Check dependencies
/env-check deps
```
