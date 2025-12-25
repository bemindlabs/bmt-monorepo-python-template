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
