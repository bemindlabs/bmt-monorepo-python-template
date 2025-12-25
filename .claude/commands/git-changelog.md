# Generate Changelog

Generate or update CHANGELOG.md from git history.

## Instructions

### Changelog Generation

1. **Analyze Commits**
```bash
# Get commits since last tag
git log $(git describe --tags --abbrev=0)..HEAD --oneline

# Or since specific version
git log v0.1.0..HEAD --format="%s|%h|%an|%ad"
```

2. **Parse Conventional Commits**

Group by type:
- `feat:` → Features
- `fix:` → Bug Fixes
- `docs:` → Documentation
- `perf:` → Performance
- `refactor:` → Code Refactoring
- `test:` → Tests
- `build:` → Build System
- `ci:` → CI/CD

3. **Generate Entry**

```markdown
## [Unreleased]

### Features

- **core**: add retry decorator ([abc1234](commit-url))
- **shared**: add Result type ([def5678](commit-url))

### Bug Fixes

- **config**: fix env loading ([ghi9012](commit-url))

### Documentation

- update README ([jkl3456](commit-url))
```

4. **Update CHANGELOG.md**
```bash
# Prepend new entry to CHANGELOG.md
```

### Using Commitizen

```bash
# Generate changelog
uv run cz changelog

# Generate for specific version
uv run cz changelog --start-rev v0.1.0
```

### Changelog Format

```markdown
# Changelog

All notable changes documented here.

## [Unreleased]

## [0.2.0] - YYYY-MM-DD

### Features
- ...

### Bug Fixes
- ...

## [0.1.0] - YYYY-MM-DD
- Initial release
```

## Arguments

- `$ARGUMENTS` - Optional: `--from {tag}`, `--to {tag}`, `--unreleased`

## Output

Updated CHANGELOG.md with new entries.
