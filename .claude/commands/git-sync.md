# Sync

Synchronize the monorepo - dependencies, packages, and workspace state.

## Instructions

Perform a complete sync of the monorepo workspace:

### 1. Git Sync

```bash
# Fetch latest from remote
git fetch --all --prune

# Check current status
git status

# Pull latest changes (if on a branch that tracks remote)
git pull origin $(git branch --show-current) --rebase
```

### 2. Dependency Sync

```bash
# Update lock file and sync dependencies
uv lock
uv sync

# Verify installation
uv pip list
```

### 3. Package Sync

Ensure all workspace packages are properly linked:

```bash
# Reinstall workspace packages in editable mode
uv sync --reinstall-package monorepo-core
uv sync --reinstall-package monorepo-shared
uv sync --reinstall-package monorepo-config
```

### 4. Pre-commit Sync

```bash
# Update pre-commit hooks
uv run pre-commit autoupdate

# Install/reinstall hooks
uv run pre-commit install
uv run pre-commit install --hook-type commit-msg
```

### 5. Cache Cleanup

```bash
# Clear Python caches
find . -type d -name '__pycache__' -exec rm -rf {} + 2>/dev/null || true
find . -type d -name '.pytest_cache' -exec rm -rf {} + 2>/dev/null || true
find . -type d -name '.mypy_cache' -exec rm -rf {} + 2>/dev/null || true
find . -type d -name '.ruff_cache' -exec rm -rf {} + 2>/dev/null || true
```

### 6. Validation

```bash
# Verify packages import correctly
uv run python -c "from monorepo_core import generate_id; print('core:', generate_id())"
uv run python -c "from monorepo_shared import NotFoundError; print('shared: OK')"
uv run python -c "from monorepo_config import get_settings; print('config: OK')"

# Quick quality check
uv run ruff check . --fix
uv run ruff format .
```

## Quick Sync (Makefile)

```bash
make sync        # Just dependency sync
make reset       # Full reset (clean + sync)
make update      # Update all dependencies
```

## Checklist

- [ ] Git repository synced
- [ ] Dependencies updated and locked
- [ ] Workspace packages linked
- [ ] Pre-commit hooks updated
- [ ] Caches cleared
- [ ] Packages validated
