# BMT Python Monorepo Template

A production-ready Python monorepo template with multi-language support, modern tooling, and AI-assisted development workflows.

## Features

- **UV Package Manager** - Fast, reliable Python package management with workspace support
- **Modern Tooling** - Ruff for linting/formatting, MyPy for type checking, Pytest for testing
- **Multi-Language Ready** - Extensible structure for Python, JavaScript, Go, Rust, and more
- **AI-Assisted Development** - Pre-configured for Claude, Cursor, and other AI tools
- **Infrastructure Ready** - Docker, Kubernetes, and CI/CD configurations included
- **Quality Gates** - Pre-commit hooks, conventional commits, and automated testing

## Quick Start

### Prerequisites

- Python 3.12+
- [UV](https://docs.astral.sh/uv/) - Python package manager
- Docker (optional, for containerization)

### Installation

```bash
# Clone the repository
git clone https://github.com/bemindlabs/bmt-monorepo-python-template.git
cd bmt-monorepo-python-template

# Initialize the project
make init

# Or manually:
uv sync
uv run pre-commit install
```

### Development

```bash
# Start development
make dev

# Run API server
make serve

# Run tests
make test

# Check code quality
make zero-qa
```

## Project Structure

```
bmt-monorepo-python-template/
├── apps/                    # Applications
│   └── api/                 # Example: REST API
├── packages/                # Shared packages
│   ├── core/                # Core framework utilities
│   ├── shared/              # Shared types, errors, constants
│   └── config/              # Configuration management
├── tools/                   # CLI tools and utilities
├── tests/                   # Centralized test suites
│   ├── unit/
│   ├── integration/
│   └── e2e/
├── infra/                   # Infrastructure
│   ├── docker/              # Docker configurations
│   └── k8s/                 # Kubernetes manifests
├── docs/                    # Documentation
├── make/                    # Makefile modules
├── .claude/                 # Claude AI configuration
├── .github/                 # GitHub workflows
└── pyproject.toml           # Root project configuration
```

## Packages

| Package | Description |
|---------|-------------|
| `monorepo-core` | Core framework utilities, base classes, decorators |
| `monorepo-shared` | Shared types, error classes, constants |
| `monorepo-config` | Configuration and environment management |

## Commands

### Development

```bash
make install          # Install dependencies
make dev              # Start development environment
make serve            # Run API server with hot reload
make shell            # Open Python shell
```

### Code Quality

```bash
make lint             # Run Ruff linter
make lint-fix         # Fix linting issues
make format           # Format code
make type-check       # Run MyPy
make check            # Run all quality checks
```

### Testing

```bash
make test             # Run all tests
make test-coverage    # Run with coverage report
make test-unit        # Run unit tests only
make test-integration # Run integration tests
```

### Docker

```bash
make docker-up        # Start containers
make docker-down      # Stop containers
make docker-build     # Build images
make docker-logs      # View logs
```

### Git & Release

```bash
make commit           # Create conventional commit
make bump-patch       # Bump patch version
make bump-minor       # Bump minor version
make release-patch    # Create patch release
```

## Multi-Language Support

This template supports additional programming languages. Configure in `workspace.yaml`:

```yaml
# Enable JavaScript/TypeScript
javascript:
  version: ">=22.0.0"
  package_manager: "pnpm"
  paths:
    apps: "apps/web/*"
    packages: "packages/js/*"

# Enable Go
go:
  version: ">=1.22"
  paths:
    apps: "apps/go/*"
```

## AI-Assisted Development

### Claude Code

The `.claude/` directory contains:
- `settings.json` - Hook configurations
- `rules.md` - Project-specific rules
- `hooks/` - Pre/post tool use hooks

### Cursor

See `.cursorrules` for Cursor-specific configurations.

## Quality Gates

| Gate | Threshold |
|------|-----------|
| Test Coverage | 80% |
| Lint Errors | 0 |
| Type Errors | 0 |
| Security Vulnerabilities | 0 |

Run all checks:

```bash
make zero-qa      # Quick check
make zero-qa-full # Full check with e2e and security
```

## Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/my-feature`
3. Make your changes
4. Run quality checks: `make zero-qa`
5. Commit using conventional commits: `make commit`
6. Push and create a Pull Request

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

## License

MIT License - see [LICENSE](LICENSE) for details.

## Author

**BEMIND TECHNOLOGY CO., LTD.**
- Website: [https://www.bemind.tech](https://www.bemind.tech)
- Email: info@bemind.tech
