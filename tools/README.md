# Tools

This directory contains CLI tools and development utilities.

## Structure

```
tools/
├── cli/          # Command-line interface tools
├── scripts/      # Build and automation scripts
└── generators/   # Code generators
```

## Creating a New Tool

1. Create a new directory:
```bash
mkdir -p tools/my-tool/src/my_tool
```

2. Add `pyproject.toml` with CLI entry point:
```toml
[project]
name = "my-tool"
version = "0.1.0"
dependencies = [
    "click>=8.0.0",
    "monorepo-shared",
]

[project.scripts]
my-tool = "my_tool.cli:main"

[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"
```

3. Create CLI:
```python
# tools/my-tool/src/my_tool/cli.py
import click

@click.group()
def main():
    """My Tool CLI."""
    pass

@main.command()
@click.argument("name")
def greet(name: str):
    """Greet someone."""
    click.echo(f"Hello, {name}!")

if __name__ == "__main__":
    main()
```

4. Install and run:
```bash
uv sync
my-tool greet World
```
