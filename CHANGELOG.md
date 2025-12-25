# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Initial project structure with UV workspaces
- Core packages: `monorepo-core`, `monorepo-shared`, `monorepo-config`
- Makefile with comprehensive command shortcuts
- GitHub Actions CI/CD workflows
- Pre-commit hooks configuration
- AI assistant configurations (Claude, Cursor, VS Code)
- Multi-language support configuration
- Docker and Kubernetes infrastructure templates
- Documentation and contribution guidelines

### Package: monorepo-core

- Base classes: `BaseService`, `BaseRepository`, `BaseEntity`
- Decorators: `@retry`, `@cached`, `@timed`
- Utilities: `generate_id`, `slugify`, `deep_merge`

### Package: monorepo-shared

- Error classes: `BaseError`, `NotFoundError`, `ValidationError`, `AuthenticationError`, `AuthorizationError`, `ConflictError`
- Types: `Result`, `Success`, `Failure`, `Paginated`, `PaginationParams`
- Constants: `Environment`, `LogLevel`

### Package: monorepo-config

- Settings management with Pydantic
- Environment detection utilities
- Environment variable helpers

## [0.1.0] - 2024-12-25

### Added

- Initial release of the Python monorepo template
