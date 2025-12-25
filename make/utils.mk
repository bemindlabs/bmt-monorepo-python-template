# ==============================================================================
# Utilities
# ==============================================================================

info: ## Show project info
	@echo ""
	@echo "$(CYAN)Project Info$(RESET)"
	@echo "  $(YELLOW)Python:$(RESET) $(shell python3 --version)"
	@echo "  $(YELLOW)UV:$(RESET) $(shell uv --version)"
	@echo "  $(YELLOW)Project:$(RESET) $(shell grep -m1 'name = ' pyproject.toml | cut -d'"' -f2)"
	@echo "  $(YELLOW)Version:$(RESET) $(shell grep -m1 'version = ' pyproject.toml | cut -d'"' -f2)"
	@echo ""

check-tools: ## Check if required tools are installed
	@echo "$(CYAN)Checking required tools...$(RESET)"
	@command -v python3 >/dev/null 2>&1 && echo "$(GREEN)✓$(RESET) python3" || echo "$(RED)✗$(RESET) python3"
	@command -v uv >/dev/null 2>&1 && echo "$(GREEN)✓$(RESET) uv" || echo "$(RED)✗$(RESET) uv"
	@command -v docker >/dev/null 2>&1 && echo "$(GREEN)✓$(RESET) docker" || echo "$(RED)✗$(RESET) docker"
	@command -v kubectl >/dev/null 2>&1 && echo "$(GREEN)✓$(RESET) kubectl" || echo "$(RED)✗$(RESET) kubectl"
	@command -v git >/dev/null 2>&1 && echo "$(GREEN)✓$(RESET) git" || echo "$(RED)✗$(RESET) git"
	@echo ""

env-check: ## Validate environment variables
	@echo "$(CYAN)Checking environment...$(RESET)"
	@test -f .env && echo "$(GREEN)✓$(RESET) .env file exists" || echo "$(YELLOW)!$(RESET) .env file missing (copy from .env.example)"

tree: ## Show project structure
	@command -v tree >/dev/null 2>&1 && tree -I '__pycache__|.git|.venv|node_modules|dist|build|*.egg-info|.pytest_cache|.mypy_cache|.ruff_cache' -L 3 || find . -type d -name '__pycache__' -prune -o -type d -name '.git' -prune -o -type d -name '.venv' -prune -o -type d -print | head -50

todo: ## Show TODOs in code
	@grep -rn "TODO\|FIXME\|XXX\|HACK" packages apps --include="*.py" 2>/dev/null || echo "No TODOs found"

outdated: ## Show outdated dependencies
	$(UV) pip list --outdated

size: ## Show package sizes
	@du -sh packages/* apps/* 2>/dev/null | sort -h

loc: ## Count lines of code
	@find packages apps -name "*.py" -exec wc -l {} + | tail -1

profile: ## Profile application (usage: make profile APP=api)
	$(UV) run python -m cProfile -o profile.stats -m apps.$(APP)
	$(UV) run snakeviz profile.stats
