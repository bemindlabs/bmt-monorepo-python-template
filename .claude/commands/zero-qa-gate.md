# Zero-QA Gate Validation

Validate code against quality gates before merge/release.

## Instructions

### Gate Validation Process

1. **Load Gate Configuration**
   - Read `.zero-qa/config.json`
   - Get thresholds for each gate

2. **Run All Gates**

```bash
# Lint Gate
uv run ruff check . --output-format=json > /tmp/lint-report.json

# Format Gate
uv run ruff format . --check

# Type Gate
uv run mypy packages apps --no-error-summary

# Test Gate
uv run pytest --cov=packages --cov=apps --cov-report=json

# Security Gate
uv run bandit -r packages apps -ll -f json
```

3. **Evaluate Results**

Compare against thresholds:

| Gate | Threshold | Result | Status |
|------|-----------|--------|--------|
| Lint Errors | 0 | {count} | PASS/FAIL |
| Type Errors | 0 | {count} | PASS/FAIL |
| Test Coverage | 80% | {pct}% | PASS/FAIL |
| Test Failures | 0 | {count} | PASS/FAIL |
| Security High | 0 | {count} | PASS/FAIL |
| Security Medium | 0 | {count} | PASS/FAIL |

### Gate Status

```
Zero-QA Gate Status
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✓ Lint Gate ............ PASS (0 errors)
✓ Format Gate .......... PASS (formatted)
✓ Type Gate ............ PASS (0 errors)
✓ Test Gate ............ PASS (85% coverage)
✓ Security Gate ........ PASS (0 issues)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Overall: PASS - Ready to merge
```

### Failure Handling

If any gate fails:
1. List specific failures
2. Provide fix recommendations
3. Block merge/release

## Arguments

- `$ARGUMENTS` - Optional: `--strict` for zero tolerance mode

## Output

Gate validation report with pass/fail status for each gate.
