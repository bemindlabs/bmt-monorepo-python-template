# ==============================================================================
# Setup & Installation
# ==============================================================================

install: ## Install all dependencies with uv
	$(UV) sync

install-frozen: ## Install dependencies with frozen lockfile
	$(UV) sync --frozen

setup: install ## Full project setup (install + prepare)
	$(UV) run pre-commit install
	@echo "$(GREEN)Setup complete!$(RESET)"

init: ## Initialize project (first-time setup)
	@echo "$(GREEN)Initializing project...$(RESET)"
	@command -v uv >/dev/null 2>&1 || { echo "$(RED)uv not found. Installing...$(RESET)"; curl -LsSf https://astral.sh/uv/install.sh | sh; }
	$(UV) sync
	$(UV) run pre-commit install
	@echo "$(GREEN)Project initialized successfully!$(RESET)"

update: ## Update all dependencies
	$(UV) lock --upgrade
	$(UV) sync

add-dep: ## Add a dependency (usage: make add-dep PKG=package-name)
	$(UV) add $(PKG)

add-dev-dep: ## Add a dev dependency (usage: make add-dev-dep PKG=package-name)
	$(UV) add --dev $(PKG)

remove-dep: ## Remove a dependency (usage: make remove-dep PKG=package-name)
	$(UV) remove $(PKG)

show-deps: ## Show dependency tree
	$(UV) tree
