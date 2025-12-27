# Monorepo Template - Claude Rules

> **Version**: 0.2.0
> **Project**: Python Monorepo Template with Multi-Language Support

## Core Principles

1. **Modularity First**: Each package should be self-contained and reusable
2. **Type Safety**: Use strict type hints, no `Any` types
3. **Test Coverage**: Maintain 80%+ coverage on changed code
4. **Clean Architecture**: Separate concerns between packages, apps, and tools
5. **Branching Discipline**: Follow the defined branching workflow

## Branching Workflow

```
feature/* ──┬──> dev ──> staging ──> production
hotfix/*  ──┘
```

### Branch Hierarchy

| Branch | Purpose | Protection |
|--------|---------|------------|
| `production` | Production-ready code | Highest - 2 approvals, all checks |
| `staging` | Pre-production testing | High - 1 approval, CI pass |
| `dev` | Integration branch | Medium - 1 approval, PR review |
| `feature/*` | Feature development | None |
| `hotfix/*` | Urgent fixes | None |

### Workflow Rules

1. **Features**: Create from `dev`, merge back via PR
2. **Staging**: Merge from `dev` after integration testing
3. **Production**: Merge from `staging` only when:
   - All tests pass (`make zero-qa`)
   - Coverage >= 80%
   - Code review approved

### Branch Naming

- `feature/<ticket-id>-<description>`
- `hotfix/<ticket-id>-<description>`
- `release/v<major>.<minor>.<patch>`

## Pre-Development Checklist

Before making ANY code changes:

```bash
# 1. Check current state
git checkout dev
git pull origin dev

# 2. Validate environment
uv sync                    # Sync dependencies
uv run ruff check .        # Check code quality
uv run mypy packages apps  # Check types

# 3. Create feature branch from dev
git checkout -b feature/<descriptive-name>
```

## Project Structure

```
monorepo-template/
├── apps/             # Applications
├── packages/         # Shared packages
│   ├── core/         # Core framework utilities
│   ├── shared/       # Shared types and utilities
│   └── config/       # Configuration utilities
├── tools/            # CLI tools and utilities
├── docs/             # Documentation
├── tests/            # Test suites
│   ├── unit/
│   ├── integration/
│   └── e2e/
└── infra/            # Infrastructure configs
```

## Package Development Rules

### Package Structure

```
packages/<package-name>/
├── src/
│   └── monorepo_<name>/
│       ├── __init__.py   # Entry point
│       └── ...
├── tests/
├── pyproject.toml
└── README.md
```

### Rules

- Use `monorepo-shared` for common types
- Define clear input/output types with type hints
- Implement proper error handling
- Add logging for debugging
- Write tests for critical paths
- Document package capabilities

## Shared Packages

### monorepo-core

Core framework providing:

- Base classes (BaseService, BaseRepository)
- Decorators (retry, cached, timed)
- Helper functions

### monorepo-shared

Shared across all packages:

- Error classes
- Common types (Result, Paginated)
- Constants and enums

### monorepo-config

Environment and configuration:

- Settings management (Pydantic)
- Environment detection
- dotenv integration

## Code Quality

### Before Committing

```bash
uv run ruff check .        # No linting errors
uv run ruff format .       # Format code
uv run mypy packages apps  # No type errors
uv run pytest              # All tests pass
```

### Commit Guidelines

**Format**: Conventional Commits

```bash
feat(core): add new utility function
fix(shared): correct type definition
docs(readme): update installation guide
test(config): add validation tests
```

## Security Rules

**CRITICAL**: Never commit sensitive data

**Protected Patterns** (auto-blocked):

- `*.env` (except `.env.example`)
- `*.key`, `*.pem`, `*.p12`, `*.pfx`
- `*credentials*.json`
- `*secrets*.json`

**Rules**:

- Use `.env.example` for documentation
- Load secrets from environment variables
- Never log API keys
- Validate all external inputs

## Testing Requirements

- Unit tests for core functions
- Integration tests for workflows
- Mock external API calls
- Test error handling paths
- Coverage: 80%+ on changed files

## Code Style

### Python

```python
# Good - explicit types
def create_service(config: Config) -> Service:
    """Create a new service instance."""
    return Service(config)

def process(data: UserData) -> Result[ProcessedData]:
    """Process user data with explicit types."""
    return Result.ok(transform(data))

# Bad - missing types or using Any
def create_service(config):  # Missing type hints
    return Service(config)

from typing import Any
def process(data: Any):  # Avoid Any - use concrete types
    pass
```

### Type Hints

- Always use type hints for function parameters and returns
- Use `|` for union types instead of `Union`
- Use `list[T]` instead of `List[T]`
- Use `dict[K, V]` instead of `Dict[K, V]`

## Common Issues & Solutions

### "Module not found" errors

```bash
uv sync
# Or rebuild all packages
uv pip install -e packages/core
```

### Type errors after package update

```bash
uv sync
rm -rf .mypy_cache
# Restart your IDE
```

## Review Checklist

Before submitting PR:

- [ ] Code follows project patterns
- [ ] All tests pass (`uv run pytest`)
- [ ] No lint errors (`uv run ruff check .`)
- [ ] No type errors (`uv run mypy packages apps`)
- [ ] Security reviewed (no secrets)
- [ ] Documentation updated
- [ ] Conventional commit messages

---

**Remember**: Type safety first, test thoroughly, maintain modularity.
