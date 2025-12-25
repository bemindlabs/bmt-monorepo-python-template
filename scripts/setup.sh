#!/bin/bash
# ==============================================================================
# BMT Python Monorepo - Setup Script
# ==============================================================================
# First-time setup script for the monorepo.
# Usage: ./scripts/setup.sh
# ==============================================================================

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}BMT Python Monorepo Setup${NC}"
echo "=================================="

# Check Python version
echo -e "\n${YELLOW}Checking Python version...${NC}"
python_version=$(python3 --version 2>&1 | cut -d' ' -f2)
required_version="3.12"

if [ "$(printf '%s\n' "$required_version" "$python_version" | sort -V | head -n1)" != "$required_version" ]; then
    echo -e "${RED}Error: Python $required_version or higher is required. Found: $python_version${NC}"
    exit 1
fi
echo -e "${GREEN}✓${NC} Python $python_version"

# Check/Install UV
echo -e "\n${YELLOW}Checking UV...${NC}"
if ! command -v uv &> /dev/null; then
    echo "Installing UV..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    export PATH="$HOME/.cargo/bin:$PATH"
fi
echo -e "${GREEN}✓${NC} UV $(uv --version)"

# Sync dependencies
echo -e "\n${YELLOW}Syncing dependencies...${NC}"
uv sync
echo -e "${GREEN}✓${NC} Dependencies synced"

# Install pre-commit hooks
echo -e "\n${YELLOW}Installing pre-commit hooks...${NC}"
uv run pre-commit install
uv run pre-commit install --hook-type commit-msg
echo -e "${GREEN}✓${NC} Pre-commit hooks installed"

# Create .env if not exists
if [ ! -f .env ]; then
    echo -e "\n${YELLOW}Creating .env from .env.example...${NC}"
    cp .env.example .env
    echo -e "${GREEN}✓${NC} .env created (please update with your settings)"
fi

# Verify packages
echo -e "\n${YELLOW}Verifying packages...${NC}"
uv run python -c "from monorepo_core import generate_id; print('  ✓ monorepo-core')"
uv run python -c "from monorepo_shared import NotFoundError; print('  ✓ monorepo-shared')"
uv run python -c "from monorepo_config import get_settings; print('  ✓ monorepo-config')"

echo -e "\n${GREEN}Setup complete!${NC}"
echo ""
echo "Next steps:"
echo "  1. Edit .env with your configuration"
echo "  2. Run 'make dev' to start development"
echo "  3. Run 'make test' to run tests"
echo "  4. Run 'make help' to see all commands"
