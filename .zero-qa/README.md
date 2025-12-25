# Zero-QA Configuration

Quality Assurance configuration for the monorepo.

## Overview

Zero-QA enforces quality gates at different stages:
- **Pre-commit**: Fast checks (lint, format)
- **Pre-push**: Full checks (lint, format, type-check, test)
- **CI**: All checks including security

## Quality Gates

| Gate | Tool | Threshold |
|------|------|-----------|
| Lint | Ruff | 0 errors |
| Format | Ruff | All formatted |
| Type Check | MyPy | 0 errors |
| Test | Pytest | 80% coverage |
| Security | Bandit | 0 high/medium |

## Commands

```bash
# Quick check (lint + type-check + test)
make zero-qa

# Full check (includes e2e and security)
make zero-qa-full

# Individual gates
make lint
make format
make type-check
make test
make security
```

## Configuration

Edit `config.json` to customize:
- Enable/disable gates
- Adjust thresholds
- Configure tools

## Integration

### Pre-commit

```yaml
# .pre-commit-config.yaml
- repo: local
  hooks:
    - id: zero-qa
      name: Zero-QA Check
      entry: make zero-qa
      language: system
```

### CI/CD

```yaml
# .github/workflows/ci.yml
- name: Zero-QA
  run: make zero-qa-full
```
