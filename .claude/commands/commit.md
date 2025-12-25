# Commit

Create a conventional commit with proper formatting.

## Instructions

### 1. Check Status

```bash
git status
git diff --stat
```

### 2. Review Changes

Analyze the changes to determine:
- **Type**: What kind of change is this?
- **Scope**: What package/area is affected?
- **Description**: What does this change do?

### 3. Commit Types

| Type | Description |
|------|-------------|
| `feat` | New feature |
| `fix` | Bug fix |
| `docs` | Documentation only |
| `style` | Code style (formatting, semicolons) |
| `refactor` | Code refactoring (no feature/fix) |
| `perf` | Performance improvement |
| `test` | Adding/updating tests |
| `build` | Build system changes |
| `ci` | CI/CD changes |
| `chore` | Maintenance tasks |
| `revert` | Revert previous commit |

### 4. Scopes

| Scope | Description |
|-------|-------------|
| `core` | monorepo-core package |
| `shared` | monorepo-shared package |
| `config` | monorepo-config package |
| `app` | Application code |
| `api` | API-specific changes |
| `cli` | CLI-specific changes |
| `deps` | Dependency updates |
| `infra` | Infrastructure (Docker, K8s) |
| `docs` | Documentation |
| `ci` | CI/CD configuration |

### 5. Format

```
type(scope): subject

[optional body]

[optional footer]
```

**Rules:**
- Subject: lowercase, no period, max 100 chars
- Body: wrap at 72 chars
- Footer: references, breaking changes

### 6. Examples

```bash
# Feature
git commit -m "feat(core): add retry decorator with exponential backoff"

# Bug fix
git commit -m "fix(shared): correct pagination offset calculation"

# Documentation
git commit -m "docs(readme): update installation instructions"

# Breaking change
git commit -m "feat(api)!: change authentication endpoint

BREAKING CHANGE: /auth/login now requires email instead of username"
```

### 7. Commit Command

```bash
# Stage changes
git add <files>
# or
git add -A

# Commit with message
git commit -m "$(cat <<'EOF'
type(scope): subject

Body explaining the change in detail.

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>
EOF
)"
```

### 8. Using Commitizen

```bash
# Interactive commit
uv run cz commit

# Or use make command
make commit
```

## Pre-Commit Checklist

- [ ] Changes are staged
- [ ] Tests pass (`make test`)
- [ ] Linting passes (`make lint`)
- [ ] Type check passes (`make type-check`)
- [ ] Commit message follows convention
