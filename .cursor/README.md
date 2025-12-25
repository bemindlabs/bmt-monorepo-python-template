# Cursor Configuration

This directory contains Cursor AI IDE configuration.

## Files

- `settings.json` - Cursor workspace settings
- Project rules are in `.cursorrules` at project root

## Features

### AI Context

Cursor will automatically include:
- `pyproject.toml` - Project configuration
- `CLAUDE.md` - Repository guidelines
- `.cursorrules` - AI coding rules
- `workspace.yaml` - Workspace configuration

### Excluded from Context

Large/generated files are excluded:
- `__pycache__/`
- `.venv/`
- `dist/`, `build/`
- Cache directories
- Lock files

## Usage

### Code Completion

Cursor understands the monorepo structure and will:
- Suggest imports from workspace packages
- Follow type hints strictly
- Match existing code patterns

### Commands

Use Cursor's command palette for:
- Running tests
- Formatting code
- Type checking

### Tips

1. Reference `.cursorrules` for coding standards
2. Use `CLAUDE.md` for project context
3. Run `make zero-qa` before committing
