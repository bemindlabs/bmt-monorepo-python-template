# Review

Perform a comprehensive code review of recent changes.

## Instructions

### 1. Identify Changes

```bash
# Show recent commits
git log --oneline -10

# Show changes since last review/merge
git diff main...HEAD --stat

# Show detailed changes
git diff main...HEAD
```

### 2. Review Checklist

#### Code Quality
- [ ] Code follows project style guidelines (Ruff)
- [ ] No unnecessary complexity
- [ ] Functions are focused and small
- [ ] Meaningful variable/function names
- [ ] No code duplication

#### Type Safety
- [ ] All functions have type hints
- [ ] No `Any` types (unless justified)
- [ ] Return types are explicit
- [ ] MyPy passes without errors

#### Testing
- [ ] New code has tests
- [ ] Tests cover edge cases
- [ ] Tests are readable and maintainable
- [ ] Coverage meets threshold (80%+)

#### Security
- [ ] No hardcoded secrets
- [ ] Input validation present
- [ ] No SQL injection vulnerabilities
- [ ] No command injection risks
- [ ] Proper error handling (no stack traces in responses)

#### Documentation
- [ ] Public APIs have docstrings
- [ ] Complex logic is commented
- [ ] README updated if needed
- [ ] CHANGELOG updated if needed

#### Architecture
- [ ] Changes align with project structure
- [ ] Dependencies are appropriate
- [ ] No circular imports
- [ ] Separation of concerns maintained

### 3. Run Automated Checks

```bash
# Linting
uv run ruff check .

# Type checking
uv run mypy packages apps

# Tests with coverage
uv run pytest --cov

# Security scan
uv run bandit -r packages apps -ll
```

### 4. Review Output Format

```markdown
## Code Review Summary

### Files Reviewed
- `path/to/file1.py`
- `path/to/file2.py`

### Findings

#### Critical
- None / List issues

#### Major
- None / List issues

#### Minor
- None / List suggestions

#### Positive
- List good practices observed

### Recommendations
1. First recommendation
2. Second recommendation

### Approval Status
- [ ] Approved
- [ ] Approved with minor changes
- [ ] Changes requested
```

### 5. Common Issues to Check

| Category | Check For |
|----------|-----------|
| **Imports** | Unused imports, wrong order |
| **Types** | Missing hints, incorrect types |
| **Errors** | Bare except, swallowed errors |
| **Logging** | Print statements, missing logs |
| **Tests** | Missing tests, flaky tests |
| **Security** | Hardcoded values, unsafe operations |
