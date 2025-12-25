# Getting Started

## Prerequisites

- **Python 3.12+**
- **UV** - Python package manager ([install](https://docs.astral.sh/uv/))
- **Git**
- **Docker** (optional)

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/bemindlabs/bmt-monorepo-python-template.git
cd bmt-monorepo-python-template
```

### 2. Initialize the Project

```bash
make init
```

This will:
- Install UV if not present
- Sync all dependencies
- Install pre-commit hooks

### 3. Verify Installation

```bash
# Check tools
make check-tools

# Run tests
make test

# Run quality checks
make zero-qa
```

## First Steps

### Create Your First App

```bash
# Use Claude command
/new-app

# Or manually create in apps/ directory
```

### Run Development Server

```bash
make serve
```

### Run Tests

```bash
make test
make test-coverage
```

## Project Configuration

### Environment Variables

Copy `.env.example` to `.env`:

```bash
cp .env.example .env
```

Edit `.env` with your settings.

### IDE Setup

#### VS Code

Extensions are auto-recommended. Accept the prompts or install manually:
- Python
- Pylance
- Ruff

#### Cursor

Settings are pre-configured in `.cursorrules`.

## Next Steps

- [Architecture Overview](Architecture.md)
- [Development Guide](Development/Setup.md)
- [Creating Packages](Development/Packages.md)
