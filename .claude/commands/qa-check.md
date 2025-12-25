# Zero-QA

Run the Zero-QA quality gate to ensure code meets all quality standards.

## Instructions

Execute the complete quality assurance pipeline:

### 1. Pre-Flight Checks

```bash
# Ensure dependencies are synced
uv sync --frozen

# Check environment
uv run python --version
```

### 2. Linting (Ruff)

```bash
# Check for linting errors
uv run ruff check .

# Auto-fix issues
uv run ruff check . --fix
```

**Target: 0 errors**

### 3. Formatting (Ruff)

```bash
# Check formatting
uv run ruff format . --check

# Apply formatting
uv run ruff format .
```

**Target: All files formatted**

### 4. Type Checking (MyPy)

```bash
# Run strict type checking
uv run mypy packages apps
```

**Target: 0 type errors**

### 5. Testing (Pytest)

```bash
# Run all tests with coverage
uv run pytest --cov=packages --cov=apps --cov-report=term-missing

# Check coverage threshold
uv run pytest --cov=packages --cov=apps --cov-fail-under=80
```

**Target: 80%+ coverage, all tests pass**

### 6. Security (Bandit)

```bash
# Run security scan
uv run bandit -r packages apps -ll
```

**Target: 0 high/medium security issues**

## Quality Gates Summary

| Gate | Command | Target |
|------|---------|--------|
| Lint | `ruff check .` | 0 errors |
| Format | `ruff format . --check` | All pass |
| Types | `mypy packages apps` | 0 errors |
| Tests | `pytest --cov` | 80%+ coverage |
| Security | `bandit -r packages apps` | 0 issues |

## Quick Commands

```bash
# Quick check (lint + type-check + test)
make zero-qa

# Full check (includes e2e and security)
make zero-qa-full

# Pre-push validation
make pre-push
```

## Failure Resolution

### Lint Errors
```bash
uv run ruff check . --fix
```

### Format Errors
```bash
uv run ruff format .
```

### Type Errors
- Add missing type hints
- Fix incompatible types
- Use `# type: ignore` only as last resort

### Test Failures
- Run specific test: `uv run pytest tests/path/to/test.py -v`
- Debug with: `uv run pytest --pdb`

### Coverage Below Threshold
- Add tests for uncovered code
- Check coverage report: `make coverage-show`
