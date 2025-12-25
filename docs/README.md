# Documentation

This directory contains project documentation.

## Structure

```
docs/
├── architecture/     # Architecture decision records (ADRs)
├── api/              # API documentation
├── guides/           # User and developer guides
└── images/           # Documentation images
```

## Building Documentation

```bash
# Build documentation
make docs

# Serve locally
make docs-serve

# Deploy to GitHub Pages
make docs-deploy
```

## Documentation Standards

1. **Architecture Decisions**: Use ADR format for significant decisions
2. **API Documentation**: Auto-generated from docstrings
3. **Guides**: Step-by-step tutorials for common tasks
4. **Code Examples**: Include runnable examples

## Contributing to Documentation

1. Write in Markdown
2. Use clear, concise language
3. Include code examples
4. Add screenshots for UI features
5. Keep documentation up to date with code changes
