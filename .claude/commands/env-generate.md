---
description: Generate environment files from templates
allowed-tools: Read, Write, Bash(cp:*), Bash(ls:*), Glob
argument-hint: [environment]
---

# Generate Environment Files

Generate `.env` files from `.env.example` templates for the specified environment.

## Arguments

- `$1` - Environment name: `dev`, `staging`, `production`, or `all` (default: `dev`)

## Current State

Check existing environment files:

!`ls -la .env* 2>/dev/null || echo "No .env files found"`

Check for templates:

!`ls -la .env.example* 2>/dev/null || echo "No .env.example files found"`

## Instructions

1. **Find Templates**: Search for `.env.example` files in the project root and package directories

2. **Determine Target**: Based on the argument:
   - `dev` → Generate `.env` and `.env.development`
   - `staging` → Generate `.env.staging`
   - `production` → Generate `.env.production`
   - `all` → Generate all environment files

3. **Generate Files**:
   - Copy template to target file
   - Replace placeholder values with environment-specific defaults
   - DO NOT include actual secrets - use placeholders like `<your-api-key>`

4. **Validate**:
   - Check all required variables are present
   - Warn about missing or placeholder values

5. **Security Rules**:
   - NEVER generate actual secret values
   - NEVER read existing `.env` files with real secrets
   - Always use `.env.example` as the source template

## Output

Report generated files and any warnings about missing values.

## Example

```bash
# Generate dev environment
/env-generate dev

# Generate all environments
/env-generate all
```
