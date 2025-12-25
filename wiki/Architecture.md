# Architecture

## Overview

This monorepo follows a modular architecture with clear separation of concerns.

```
┌─────────────────────────────────────────────────────────────┐
│                        Applications                          │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐        │
│  │   API   │  │   Web   │  │  Worker │  │   CLI   │        │
│  └────┬────┘  └────┬────┘  └────┬────┘  └────┬────┘        │
└───────┼────────────┼────────────┼────────────┼──────────────┘
        │            │            │            │
        └────────────┴─────┬──────┴────────────┘
                           │
┌──────────────────────────┼──────────────────────────────────┐
│                      Packages                                │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐         │
│  │    Core     │  │   Shared    │  │   Config    │         │
│  │  Framework  │  │   Types &   │  │ Environment │         │
│  │  Utilities  │  │   Errors    │  │  Settings   │         │
│  └─────────────┘  └─────────────┘  └─────────────┘         │
└─────────────────────────────────────────────────────────────┘
```

## Package Hierarchy

### Core (`monorepo-core`)

Foundation layer providing:
- Base classes (BaseService, BaseRepository)
- Decorators (@retry, @cached, @timed)
- Utility functions

### Shared (`monorepo-shared`)

Cross-cutting concerns:
- Error classes (NotFoundError, ValidationError, etc.)
- Type definitions (Result, Paginated)
- Constants and enums

### Config (`monorepo-config`)

Configuration management:
- Pydantic settings
- Environment detection
- Variable helpers

## Dependency Flow

```
Apps → Core → Shared
  ↓      ↓
Config ←─┘
```

Rules:
- Apps can depend on any package
- Core depends on Shared
- Config depends on Shared
- Shared has no internal dependencies

## Directory Structure

```
bmt-monorepo-python-template/
├── apps/                 # Deployable applications
│   ├── api/              # REST API service
│   └── cli/              # Command-line tools
├── packages/             # Shared libraries
│   ├── core/             # Framework core
│   ├── shared/           # Shared utilities
│   └── config/           # Configuration
├── tools/                # Development tools
├── tests/                # Centralized tests
│   ├── unit/
│   ├── integration/
│   └── e2e/
├── infra/                # Infrastructure
│   ├── docker/
│   └── k8s/
└── docs/                 # Documentation
```

## Multi-Language Support

The template supports multiple languages via `workspace.yaml`:

```yaml
primary_language: python

# Optional language extensions
javascript:
  package_manager: "pnpm"
  paths:
    apps: "apps/web/*"

go:
  paths:
    apps: "apps/go/*"
```

## Quality Gates

| Gate | Tool | Threshold |
|------|------|-----------|
| Linting | Ruff | 0 errors |
| Types | MyPy | 0 errors |
| Tests | Pytest | 80% coverage |
| Security | Bandit | 0 high/medium |
