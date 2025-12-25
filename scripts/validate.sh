#!/bin/bash
# ==============================================================================
# BMT Python Monorepo - Validation Script
# ==============================================================================
# Validates the project structure and configuration.
# Usage: ./scripts/validate.sh
# ==============================================================================

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}BMT Python Monorepo Validation${NC}"
echo "=================================="

errors=0

# Check required files
echo -e "\n${YELLOW}Checking required files...${NC}"
required_files=(
    "pyproject.toml"
    "Makefile"
    ".gitignore"
    ".env.example"
    "README.md"
    ".pre-commit-config.yaml"
)

for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo -e "${GREEN}✓${NC} $file"
    else
        echo -e "${RED}✗${NC} $file (missing)"
        ((errors++))
    fi
done

# Check required directories
echo -e "\n${YELLOW}Checking required directories...${NC}"
required_dirs=(
    "apps"
    "packages"
    "packages/core"
    "packages/shared"
    "packages/config"
    "tests"
    "infra"
    "docs"
)

for dir in "${required_dirs[@]}"; do
    if [ -d "$dir" ]; then
        echo -e "${GREEN}✓${NC} $dir/"
    else
        echo -e "${RED}✗${NC} $dir/ (missing)"
        ((errors++))
    fi
done

# Check package structure
echo -e "\n${YELLOW}Checking package structure...${NC}"
packages=("core" "shared" "config")

for pkg in "${packages[@]}"; do
    pkg_path="packages/$pkg"
    if [ -f "$pkg_path/pyproject.toml" ]; then
        echo -e "${GREEN}✓${NC} $pkg_path/pyproject.toml"
    else
        echo -e "${RED}✗${NC} $pkg_path/pyproject.toml (missing)"
        ((errors++))
    fi
done

# Validate pyproject.toml
echo -e "\n${YELLOW}Validating pyproject.toml...${NC}"
if uv run python -c "import tomllib; tomllib.load(open('pyproject.toml', 'rb'))" 2>/dev/null; then
    echo -e "${GREEN}✓${NC} pyproject.toml is valid TOML"
else
    echo -e "${RED}✗${NC} pyproject.toml is invalid"
    ((errors++))
fi

# Check imports
echo -e "\n${YELLOW}Checking package imports...${NC}"
if uv run python -c "from monorepo_core import generate_id" 2>/dev/null; then
    echo -e "${GREEN}✓${NC} monorepo-core imports"
else
    echo -e "${RED}✗${NC} monorepo-core import failed"
    ((errors++))
fi

if uv run python -c "from monorepo_shared import NotFoundError" 2>/dev/null; then
    echo -e "${GREEN}✓${NC} monorepo-shared imports"
else
    echo -e "${RED}✗${NC} monorepo-shared import failed"
    ((errors++))
fi

if uv run python -c "from monorepo_config import get_settings" 2>/dev/null; then
    echo -e "${GREEN}✓${NC} monorepo-config imports"
else
    echo -e "${RED}✗${NC} monorepo-config import failed"
    ((errors++))
fi

# Summary
echo ""
echo "=================================="
if [ $errors -eq 0 ]; then
    echo -e "${GREEN}All validations passed!${NC}"
    exit 0
else
    echo -e "${RED}$errors validation(s) failed${NC}"
    exit 1
fi
