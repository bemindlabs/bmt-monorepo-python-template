# Generate Documentation

Generate API documentation from code.

## Instructions

### Documentation Generation

1. **API Documentation (pdoc)**
```bash
# Generate HTML docs
uv run pdoc --html --output-dir docs/api packages

# Serve locally
uv run pdoc --http : packages
```

2. **Type Stubs**
```bash
# Generate type stubs
uv run stubgen packages -o stubs
```

3. **Docstring Coverage**
```bash
# Check coverage
uv run interrogate -v packages apps

# Generate badge
uv run interrogate --generate-badge docs/images/docstring.svg
```

### Documentation Types

#### `api` - API Reference
- Generate from docstrings
- Include type annotations
- Cross-reference modules

#### `readme` - Package READMEs
- Update package README files
- Include usage examples
- Document public API

#### `wiki` - Wiki Pages
- Sync to wiki/ directory
- Update architecture docs
- Generate guides

### MkDocs (if configured)

```bash
# Build documentation
uv run mkdocs build

# Serve locally
uv run mkdocs serve

# Deploy to GitHub Pages
uv run mkdocs gh-deploy
```

### Output Structure

```
docs/
├── api/                  # Generated API docs
│   ├── monorepo_core/
│   ├── monorepo_shared/
│   └── monorepo_config/
├── guides/               # User guides
├── architecture/         # Architecture docs
└── images/               # Badges and diagrams
```

## Arguments

- `$ARGUMENTS` - Type: `api`, `readme`, `wiki`, `all`

## Output

Generated documentation in specified format.
