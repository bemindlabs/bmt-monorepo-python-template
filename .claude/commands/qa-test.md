# Test

Run tests with various configurations.

## Instructions

### 1. Run All Tests

```bash
uv run pytest
```

### 2. Test Options

#### By Type
```bash
# Unit tests only
uv run pytest tests/unit -m unit

# Integration tests
uv run pytest tests/integration -m integration

# E2E tests
uv run pytest tests/e2e -m e2e
```

#### By Package
```bash
# Test specific package
uv run pytest packages/core/tests
uv run pytest packages/shared/tests
uv run pytest packages/config/tests
```

#### By File/Function
```bash
# Specific file
uv run pytest tests/unit/test_core.py

# Specific test
uv run pytest tests/unit/test_core.py::TestSlugify::test_converts_to_lowercase

# Pattern matching
uv run pytest -k "test_slug"
```

### 3. With Coverage

```bash
# Coverage report
uv run pytest --cov=packages --cov=apps --cov-report=term-missing

# HTML report
uv run pytest --cov=packages --cov=apps --cov-report=html
open coverage/html/index.html

# Fail if below threshold
uv run pytest --cov=packages --cov=apps --cov-fail-under=80
```

### 4. Debugging

```bash
# Verbose output
uv run pytest -v

# Very verbose
uv run pytest -vv

# Show print statements
uv run pytest -s

# Stop on first failure
uv run pytest -x

# Debug on failure
uv run pytest --pdb

# Last failed tests only
uv run pytest --lf
```

### 5. Parallel Execution

```bash
# Run tests in parallel
uv run pytest -n auto

# Specific number of workers
uv run pytest -n 4
```

### 6. Watch Mode

```bash
# Re-run on file changes
uv run pytest-watch
# or
make test-watch
```

### 7. Quick Commands

```bash
make test             # All tests
make test-v           # Verbose
make test-coverage    # With coverage
make test-unit        # Unit only
make test-fast        # Skip slow tests
make test-failed      # Last failed only
```

### 8. Writing Tests

```python
import pytest
from monorepo_core import generate_id

class TestGenerateId:
    """Tests for generate_id function."""

    def test_generates_unique_ids(self) -> None:
        """Should generate unique IDs."""
        id1 = generate_id()
        id2 = generate_id()
        assert id1 != id2

    def test_with_prefix(self) -> None:
        """Should include prefix."""
        result = generate_id("user_")
        assert result.startswith("user_")

    @pytest.mark.parametrize("prefix", ["", "a_", "test_"])
    def test_various_prefixes(self, prefix: str) -> None:
        """Should work with various prefixes."""
        result = generate_id(prefix)
        assert result.startswith(prefix)
```

### 9. Test Markers

```python
@pytest.mark.unit
def test_unit_example():
    pass

@pytest.mark.integration
def test_integration_example():
    pass

@pytest.mark.slow
def test_slow_example():
    pass
```
