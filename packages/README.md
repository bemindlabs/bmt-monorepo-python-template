# Packages

This directory contains shared packages used across applications.

## Available Packages

| Package | Description |
|---------|-------------|
| `monorepo-core` | Core framework utilities, base classes, decorators |
| `monorepo-shared` | Shared types, error classes, constants |
| `monorepo-config` | Configuration and environment management |

## Package Structure

```
packages/
├── core/           # Framework core
│   ├── src/
│   │   └── monorepo_core/
│   ├── tests/
│   ├── pyproject.toml
│   └── README.md
├── shared/         # Shared utilities
│   ├── src/
│   │   └── monorepo_shared/
│   ├── tests/
│   ├── pyproject.toml
│   └── README.md
└── config/         # Configuration
    ├── src/
    │   └── monorepo_config/
    ├── tests/
    ├── pyproject.toml
    └── README.md
```

## Using Packages

In your application or another package:

```python
# Import from core
from monorepo_core import BaseService, retry, generate_id

# Import from shared
from monorepo_shared import NotFoundError, Success, Failure

# Import from config
from monorepo_config import get_settings, is_prod
```

## Creating a New Package

See the [CONTRIBUTING.md](../CONTRIBUTING.md) guide for detailed instructions on creating new packages.

## Building Packages

```bash
# Build all packages
make build

# Build specific package
make build-package PKG=core
```

## Testing Packages

```bash
# Test all packages
make test

# Test specific package
make test-package PKG=core
```
