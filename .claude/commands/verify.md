# Verify

Quick verification of code quality before commit or push.

## Instructions

Run a fast verification pipeline to catch common issues:

### 1. Sync Dependencies

```bash
uv sync --frozen
```

### 2. Lint Check

```bash
uv run ruff check .
```

If errors found, auto-fix:
```bash
uv run ruff check . --fix
```

### 3. Format Check

```bash
uv run ruff format . --check
```

If not formatted, apply:
```bash
uv run ruff format .
```

### 4. Type Check

```bash
uv run mypy packages apps
```

### 5. Run Tests

```bash
uv run pytest -x --tb=short
```

The `-x` flag stops on first failure for fast feedback.

## Verification Summary

Report results in this format:

```
Verification Results
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✓ Dependencies ........ OK
✓ Lint ................ OK (0 errors)
✓ Format .............. OK
✓ Types ............... OK (0 errors)
✓ Tests ............... OK (X passed)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Status: VERIFIED - Ready to commit
```

Or if issues found:

```
Verification Results
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✓ Dependencies ........ OK
✗ Lint ................ FAILED (3 errors)
✓ Format .............. OK
✗ Types ............... FAILED (1 error)
- Tests ............... SKIPPED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Status: FAILED - Fix issues before commit
```

## Arguments

- `$ARGUMENTS` - Optional flags:
  - `--fix` - Auto-fix lint and format issues
  - `--no-tests` - Skip test execution
  - `--verbose` - Show detailed output

## Quick Reference

| Check | Command | Auto-fix |
|-------|---------|----------|
| Lint | `ruff check .` | `--fix` |
| Format | `ruff format . --check` | `ruff format .` |
| Types | `mypy packages apps` | Manual |
| Tests | `pytest -x` | Manual |

## When to Use

- Before committing changes
- Before pushing to remote
- After rebasing or merging
- Quick sanity check during development

For full quality gate validation, use `/zero-qa-gate` instead.
