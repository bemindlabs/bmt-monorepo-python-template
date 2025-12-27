# BMT Python Monorepo Template

Welcome to the BMT Python Monorepo Template wiki!

## Overview

A production-ready Python monorepo template with multi-language support, modern tooling, and AI-assisted development workflows.

## Quick Links

- [Getting Started](Getting-Started.md)
- [Architecture](Architecture.md)
- [Branching Workflow](Branching-Workflow.md)
- [Development Guide](Development/Setup.md)
- [Package Documentation](Packages/README.md)
- [Deployment Guide](Deployment/README.md)

## Features

- **UV Package Manager** - Fast, reliable Python package management
- **Modern Tooling** - Ruff, MyPy, Pytest
- **Multi-Language Ready** - Extensible for JS, Go, Rust
- **AI-Assisted** - Claude, Cursor, VS Code configs
- **Infrastructure Ready** - Docker, Kubernetes

## Quick Start

```bash
# Clone and setup
git clone https://github.com/bemindlabs/bmt-monorepo-python-template.git
cd bmt-monorepo-python-template
make init

# Development
make dev
make test
make zero-qa
```

## Project Structure

```
├── apps/           # Applications
├── packages/       # Shared packages
│   ├── core/       # Framework utilities
│   ├── shared/     # Types, errors, constants
│   └── config/     # Configuration management
├── tools/          # CLI tools
├── tests/          # Test suites
├── infra/          # Infrastructure
└── docs/           # Documentation
```

## Support

- [GitHub Issues](https://github.com/bemindlabs/bmt-monorepo-python-template/issues)
- [Contributing Guide](../CONTRIBUTING.md)
