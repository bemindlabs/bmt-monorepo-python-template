# ==============================================================================
# Cleanup
# ==============================================================================

clean: ## Clean build artifacts
	@echo "$(YELLOW)Cleaning build artifacts...$(RESET)"
	rm -rf dist/
	rm -rf build/
	rm -rf *.egg-info
	find . -type d -name '__pycache__' -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name '*.pyc' -delete 2>/dev/null || true
	find . -type f -name '*.pyo' -delete 2>/dev/null || true
	@echo "$(GREEN)Clean complete!$(RESET)"

clean-cache: ## Clean Python cache files
	find . -type d -name '__pycache__' -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name '.pytest_cache' -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name '.mypy_cache' -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name '.ruff_cache' -exec rm -rf {} + 2>/dev/null || true

clean-coverage: ## Clean coverage files
	rm -rf coverage/
	rm -rf .coverage
	rm -rf htmlcov/

clean-dist: ## Clean distribution files
	rm -rf dist/
	rm -rf build/
	find . -type d -name '*.egg-info' -exec rm -rf {} + 2>/dev/null || true

clean-venv: ## Remove virtual environment
	rm -rf .venv

clean-all: clean clean-cache clean-coverage clean-dist ## Clean everything

reset: clean-all ## Full reset (clean + reinstall)
	$(UV) sync
	@echo "$(GREEN)Reset complete!$(RESET)"

pristine: clean-all clean-venv ## Pristine clean (removes venv too)
	@echo "$(YELLOW)All cleaned. Run 'make init' to set up again.$(RESET)"
