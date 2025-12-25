# ==============================================================================
# Building
# ==============================================================================

build: ## Build all packages
	@echo "$(GREEN)Building all packages...$(RESET)"
	$(UV) build

build-package: ## Build specific package (usage: make build-package PKG=core)
	$(UV) build --package monorepo-$(PKG)

build-all: build ## Build all packages

build-wheel: ## Build wheel distribution
	$(UV) build --wheel

build-sdist: ## Build source distribution
	$(UV) build --sdist

compile-deps: ## Compile dependencies to requirements.txt
	$(UV) pip compile pyproject.toml -o requirements.txt

compile-dev-deps: ## Compile dev dependencies
	$(UV) pip compile pyproject.toml --extra dev -o requirements-dev.txt

lock: ## Update lock file
	$(UV) lock

sync: ## Sync dependencies with lock file
	$(UV) sync
