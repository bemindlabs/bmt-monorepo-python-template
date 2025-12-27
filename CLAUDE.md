# Repository Guidelines

## Project Structure & Module Organization

This Python monorepo uses UV for package management with workspaces defined in `pyproject.toml`. Apps live in `apps/`, reusable packages in `packages/` (`core` framework utilities, `shared` types/errors, `config` environment management), and CLI tools in `tools/`. Infrastructure definitions are in `infra/` (Docker, Kubernetes). Centralized tests sit in `tests/` with `unit`, `integration`, `e2e`, and shared `fixtures/`.

Each package uses the `monorepo_<name>` namespace and has its own `pyproject.toml`. Remember to register new packages in the root `pyproject.toml` under `[tool.uv.workspace]`.

## Build, Test, and Development Commands

- `make install` – installs workspace deps with UV
- `make dev` – starts development environment
- `make serve` – runs API with uvicorn (auto-reload)
- `make build` – builds all packages
- `make lint` / `make lint-fix` – run Ruff linter
- `make format` – format code with Ruff
- `make type-check` – run MyPy type checking
- `make test` – run all tests with pytest
- `make test-coverage` – tests with coverage report
- `make docker-up` / `make docker-down` – orchestrate Docker services
- `make zero-qa` – full quality check (lint + type-check + test)

## Coding Style & Naming Conventions

Python strict mode is mandatory; avoid `Any` and always use type hints for function parameters and returns. Source files use 4-space indentation, double quotes for strings, and 100-character line length—Ruff handles formatting. Classes use PascalCase, functions/variables use snake_case, modules/files use snake_case. Keep imports sorted via Ruff's isort integration.

## Testing Guidelines

Pytest drives all suites; test folders mirror runtime modules (`tests/unit/core`, `tests/integration/shared`). Name test files `test_*.py`, use `describe`-style tests with `pytest-describe` or simple `test_` functions. Use `tests/fixtures` for shared test data. Target 80%+ coverage before pushing.

## Commit & Pull Request Guidelines

Commitizen enforces Conventional Commits with types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`. Scopes include: `core`, `shared`, `config`, `app`, `cli`, `infra`, `docs`. Subjects stay lower-case and ≤100 chars, e.g., `feat(core): add auth session guard`. Run lint, type-check, and tests before committing. PRs should summarize intent, link issues, and note commands executed.

## Branching Workflow

This repository uses a structured branching strategy with protected branches:

```
feature/* ──┬──> dev ──> staging ──> production
hotfix/*  ──┘
```

### Branch Hierarchy

| Branch | Purpose | Protection Level |
|--------|---------|------------------|
| `production` | Production-ready code | Highest - requires all checks |
| `staging` | Pre-production testing | High - requires CI pass |
| `dev` | Integration branch | Medium - requires PR review |
| `feature/*` | Feature development | None |
| `hotfix/*` | Urgent production fixes | None |

### Workflow Rules

1. **Feature Development**: Create `feature/<name>` from `dev`, merge back to `dev` via PR
2. **Staging Promotion**: Merge `dev` to `staging` after integration testing
3. **Production Release**: Merge `staging` to `production` only when:
   - All tests pass (`make zero-qa`)
   - Coverage ≥ 80%
   - Code review approved
   - No blocking issues

### Branch Naming

- Features: `feature/<ticket-id>-short-description`
- Hotfixes: `hotfix/<ticket-id>-short-description`
- Releases: `release/v<major>.<minor>.<patch>`

## Backlog Management

This repository supports dual backlog tracking—local files for offline/fast access and GitHub Issues for collaboration and visibility.

### Local Backlog

Local backlogs are stored in `.scrum/backlog/` as YAML files:

```
.scrum/
├── backlog/
│   ├── product-backlog.yaml    # Full product backlog
│   ├── sprint-backlog.yaml     # Current sprint items
│   └── archive/                # Completed sprints
├── sprints/
│   └── sprint-{n}.yaml         # Sprint definitions
└── config.yaml                 # Scrum configuration
```

**Backlog Item Format:**
```yaml
items:
  - id: "ITEM-001"
    title: "Implement user authentication"
    description: "Add OAuth2 authentication flow"
    type: "feature"           # feature | bug | task | spike
    priority: "high"          # critical | high | medium | low
    status: "todo"            # todo | in-progress | review | done
    story_points: 5
    labels: ["auth", "security"]
    assignee: null
    github_issue: null        # Linked GitHub issue number
    created_at: "2025-01-15"
    updated_at: "2025-01-15"
```

### GitHub Issues Integration

Use GitHub Issues for external visibility and collaboration. Issues should follow the same structure:

**Labels:** Match local types and priorities:
- Types: `type:feature`, `type:bug`, `type:task`, `type:spike`
- Priority: `priority:critical`, `priority:high`, `priority:medium`, `priority:low`
- Status: `status:todo`, `status:in-progress`, `status:review`

**Issue Template Fields:**
- Title matches backlog item title
- Body contains description and acceptance criteria
- Labels reflect type, priority, and component
- Milestone links to sprint

### Syncing Local Backlog to GitHub Issues

The `/scrum-backlog` command manages synchronization between local and GitHub:

**Sync Operations:**
1. **Push to GitHub** (`/scrum-backlog sync --push`):
   - Creates GitHub issues for new local items without `github_issue`
   - Updates existing issues when local items change
   - Adds `github_issue` reference back to local file

2. **Pull from GitHub** (`/scrum-backlog sync --pull`):
   - Imports new GitHub issues to local backlog
   - Updates local items when GitHub issues change
   - Syncs status, labels, and assignees

3. **Two-way sync** (`/scrum-backlog sync`):
   - Performs both push and pull
   - Resolves conflicts using last-updated timestamp

**Sync Rules:**
- Local `id` maps to GitHub issue via `github_issue` field
- Status changes sync bidirectionally
- Labels are normalized between local types and GitHub labels
- Closing a GitHub issue marks local item as `done`
- Local items marked `done` close linked GitHub issues

**Commands:**
```bash
# View backlog
/scrum-backlog list
/scrum-backlog list --status=todo --priority=high

# Add items
/scrum-backlog add --title="..." --type=feature --priority=high

# Sync with GitHub
/scrum-backlog sync              # Two-way sync
/scrum-backlog sync --push       # Local → GitHub
/scrum-backlog sync --pull       # GitHub → Local
/scrum-backlog sync --dry-run    # Preview changes

# Link existing issue
/scrum-backlog link ITEM-001 --issue=42
```

### Best Practices

1. **Single Source of Truth**: Use local backlog as primary, sync to GitHub for visibility
2. **Regular Syncs**: Run sync before sprint planning and after daily standups
3. **Conflict Resolution**: When in doubt, GitHub issue state wins for external items
4. **Sprint Boundaries**: Archive completed sprint backlogs locally, close GitHub milestones

## Multi-Language Support

This template is designed to support additional languages. Configuration lives in `workspace.yaml`. To add a new language:

1. Add language config to `workspace.yaml`
2. Create appropriate workspace paths
3. Update `make` targets for the language
4. Add CI workflow steps

Supported patterns:
- **Python**: Primary (UV + Ruff + MyPy + Pytest)
- **JavaScript/TypeScript**: Optional (pnpm + ESLint + Prettier + Vitest)
- **Go**: Optional (go mod + golangci-lint)
- **Rust**: Optional (Cargo + Clippy)

## AI Assistant Guidelines

### When Making Changes

1. **Understand the monorepo structure** – Know which package/app you're working in
2. **Maintain type safety** – Always use proper type hints
3. **Follow existing patterns** – Match the code style and structure
4. **Update tests** – Add or update tests for new features
5. **Check workspace dependencies** – Ensure proper package references
6. **Run type checks** – Verify MyPy passes before suggesting changes

### Common Tasks

- **Adding a feature**: Create in appropriate package, export from `__init__.py`, add tests
- **Fixing a bug**: Identify root cause, fix with proper types, add regression test
- **Refactoring**: Maintain API compatibility, update all usages, run full test suite
- **Adding a package**: Follow package template, update workspace configs, add to docs

### Code Review Focus

- Type safety and strict typing
- Proper error handling
- Test coverage
- Performance considerations
- Security best practices
- Monorepo structure compliance
