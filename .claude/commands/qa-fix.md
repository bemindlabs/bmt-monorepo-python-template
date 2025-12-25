# Fix

Auto-fix common code issues.

## Instructions

### 1. Run All Auto-Fixes

```bash
# Fix linting issues
uv run ruff check . --fix

# Format code
uv run ruff format .

# Combined
make fix
```

### 2. Specific Fixes

#### Linting Issues
```bash
# Show what would be fixed
uv run ruff check . --diff

# Fix specific rules
uv run ruff check . --fix --select I  # Import sorting
uv run ruff check . --fix --select F  # Pyflakes
uv run ruff check . --fix --select UP # Pyupgrade
```

#### Import Issues
```bash
# Sort and organize imports
uv run ruff check . --fix --select I

# Remove unused imports
uv run ruff check . --fix --select F401
```

#### Formatting
```bash
# Check formatting
uv run ruff format . --check

# Apply formatting
uv run ruff format .

# Format specific file
uv run ruff format path/to/file.py
```

### 3. Common Issue Fixes

#### Unused Imports (F401)
```bash
uv run ruff check . --fix --select F401
```

#### Unused Variables (F841)
```python
# Before
result = some_function()  # F841: unused

# After (if intentionally unused)
_ = some_function()
```

#### Type Annotation Issues
```bash
# Check type errors
uv run mypy packages apps

# Common fixes:
# - Add missing type hints
# - Import from typing module
# - Use | instead of Union
```

#### Line Too Long (E501)
```bash
# Formatter handles this
uv run ruff format .
```

### 4. Pre-Commit Fixes

```bash
# Run all pre-commit hooks
uv run pre-commit run --all-files

# Run specific hook
uv run pre-commit run ruff --all-files
uv run pre-commit run ruff-format --all-files
```

### 5. Quick Fix Workflow

```bash
# 1. Run fixes
make fix

# 2. Check remaining issues
make lint
make type-check

# 3. Run tests
make test

# 4. If all good, commit
make commit
```

### 6. Fix Summary Table

| Issue | Command |
|-------|---------|
| All auto-fixable | `make fix` |
| Linting | `uv run ruff check . --fix` |
| Formatting | `uv run ruff format .` |
| Import sorting | `uv run ruff check . --fix --select I` |
| Unused imports | `uv run ruff check . --fix --select F401` |
| Pre-commit all | `uv run pre-commit run --all-files` |

### 7. Manual Fixes Needed

Some issues require manual intervention:
- Type errors (add proper type hints)
- Logic errors (review and fix)
- Missing tests (write new tests)
- Security issues (review and remediate)
