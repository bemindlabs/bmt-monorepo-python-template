# Applications

This directory contains application packages that can be deployed independently.

## Structure

```
apps/
├── api/          # REST API service (example)
├── web/          # Web application (example)
└── cli/          # CLI tools (example)
```

## Creating a New Application

1. Create a new directory:
```bash
mkdir -p apps/my-app/src/my_app
```

2. Add `pyproject.toml`:
```toml
[project]
name = "my-app"
version = "0.1.0"
dependencies = [
    "monorepo-core",
    "monorepo-shared",
    "monorepo-config",
]

[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"
```

3. Create entry point:
```python
# apps/my-app/src/my_app/__init__.py
"""My Application."""

# apps/my-app/src/my_app/main.py
from monorepo_config import get_settings

def main():
    settings = get_settings()
    print(f"Starting {settings.app_name}")

if __name__ == "__main__":
    main()
```

4. Sync dependencies:
```bash
uv sync
```

5. Run the application:
```bash
make dev-app APP=my-app
```
