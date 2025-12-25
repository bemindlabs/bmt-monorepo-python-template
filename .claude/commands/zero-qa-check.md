# Run Zero-QA Quality Checks

Run comprehensive quality checks to validate code meets Zero-QA standards.

## Usage

```
/zero-qa-check [scope]
```

**Scopes:**

- `all` (default) - Run all checks
- `quick` - Lint and type-check only
- `tests` - Run test suites only
- `security` - Security-focused checks

## Process

### 1. Static Analysis

```bash
# Lint check
uv run ruff check .

# Format check
uv run ruff format . --check

# Type check
uv run mypy packages apps
```

### 2. Test Execution

```bash
# Unit tests with coverage
uv run pytest --cov=packages --cov=apps --cov-report=term-missing

# Check coverage threshold
uv run pytest --cov-fail-under=80
```

### 3. Security Checks

```bash
# Bandit security scan
uv run bandit -r packages apps -ll

# Dependency audit
uv run pip-audit
```

### 4. Code Quality Metrics

- Function complexity
- File length
- Duplicate code detection

## Commands to Execute

```bash
# Quick check
make zero-qa

# Full check
make zero-qa-full

# Individual checks
make lint
make type-check
make test
make security
```

## Output Format

```markdown
# Zero-QA Check Report

## Summary

- **Status**: PASS/FAIL
- **Date**: [timestamp]
- **Scope**: [scope]

## Results

| Check    | Status | Details                 |
|----------|--------|-------------------------|
| Lint     | PASS   | 0 errors, 0 warnings    |
| Format   | PASS   | All files formatted     |
| Types    | PASS   | 0 errors                |
| Tests    | PASS   | 45/45 passed, 85% cov   |
| Security | PASS   | 0 vulnerabilities       |

## Quality Gates

| Gate       | Threshold | Actual | Status |
|------------|-----------|--------|--------|
| Coverage   | 80%       | 85%    | PASS   |
| Lint Errors| 0         | 0      | PASS   |
| Type Errors| 0         | 0      | PASS   |
| Security   | 0 high    | 0      | PASS   |
```

## Arguments

- `$ARGUMENTS` - Optional scope: `all`, `quick`, `tests`, `security`
