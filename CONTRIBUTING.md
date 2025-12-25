# Contributing to BMT Python Monorepo Template

Thank you for your interest in contributing! This document provides guidelines for contributing to this project.

## Code of Conduct

Please read and follow our [Code of Conduct](CODE_OF_CONDUCT.md).

## Getting Started

1. Fork the repository
2. Clone your fork
3. Set up the development environment:

```bash
make init
```

## Development Workflow

### 1. Create a Branch

```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/issue-description
```

### 2. Make Changes

- Follow the coding style guidelines
- Write tests for new functionality
- Update documentation as needed

### 3. Run Quality Checks

```bash
# Run all quality checks
make zero-qa

# Or individually:
make lint          # Check linting
make type-check    # Check types
make test          # Run tests
```

### 4. Commit Your Changes

We use Conventional Commits. Use the helper:

```bash
make commit
```

Or manually follow this format:

```
type(scope): subject

body (optional)

footer (optional)
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Code style (formatting, semicolons, etc.)
- `refactor`: Code refactoring
- `perf`: Performance improvement
- `test`: Adding/updating tests
- `build`: Build system changes
- `ci`: CI/CD changes
- `chore`: Maintenance tasks

**Scopes:**
- `core`, `shared`, `config` (packages)
- `app`, `api` (applications)
- `deps`, `infra`, `docs`, `ci`

### 5. Push and Create PR

```bash
git push origin feature/your-feature-name
```

Then create a Pull Request on GitHub.

## Coding Guidelines

### Python Style

- Use type hints for all function parameters and returns
- Follow PEP 8 with Ruff configuration
- Use docstrings for public functions
- Keep functions focused and small

```python
# Good
def process_user(user_id: str, options: ProcessOptions) -> Result[User, ProcessError]:
    """Process a user with the given options.

    Args:
        user_id: The unique identifier of the user.
        options: Processing options.

    Returns:
        Result containing the processed user or an error.
    """
    ...

# Bad
def process_user(user_id, options):  # No type hints
    ...
```

### Testing

- Write tests for all new functionality
- Follow the existing test structure
- Use descriptive test names
- Aim for 80%+ coverage on changed code

```python
class TestUserProcessor:
    def test_should_process_valid_user(self):
        # Arrange
        user_id = "user_123"
        options = ProcessOptions(validate=True)

        # Act
        result = process_user(user_id, options)

        # Assert
        assert result.is_success
        assert result.value.id == user_id

    def test_should_return_error_for_invalid_user(self):
        # Arrange
        invalid_id = ""

        # Act
        result = process_user(invalid_id, ProcessOptions())

        # Assert
        assert result.is_failure
        assert isinstance(result.error, ValidationError)
```

### Documentation

- Update README.md for new features
- Add docstrings to public APIs
- Update CHANGELOG.md for notable changes

## Pull Request Guidelines

### Before Submitting

- [ ] All tests pass (`make test`)
- [ ] No linting errors (`make lint`)
- [ ] No type errors (`make type-check`)
- [ ] Documentation updated
- [ ] Commit messages follow conventions

### PR Description

- Clearly describe the changes
- Reference related issues
- Include testing instructions
- Add screenshots for UI changes

## Package Development

### Creating a New Package

1. Create the package directory:

```bash
mkdir -p packages/my-package/src/monorepo_my_package
```

2. Create `pyproject.toml`:

```toml
[project]
name = "monorepo-my-package"
version = "0.1.0"
dependencies = ["monorepo-shared"]

[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"
```

3. Create `__init__.py` with exports

4. Add to root `pyproject.toml`:

```toml
[tool.uv.workspace]
members = [
    # ...existing
    "packages/my-package",
]
```

5. Sync dependencies:

```bash
uv sync
```

## Getting Help

- Open an issue for bugs or feature requests
- Join discussions in GitHub Discussions
- Contact maintainers for security issues

## Recognition

Contributors will be recognized in:
- CHANGELOG.md for significant contributions
- README.md contributors section
- Release notes

Thank you for contributing!
