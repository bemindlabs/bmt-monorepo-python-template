# ==============================================================================
# Code Quality
# ==============================================================================

lint: ## Run Ruff linter on all packages
	$(UV) run ruff check .

lint-fix: ## Run Ruff linter and fix issues
	$(UV) run ruff check . --fix

format: ## Format code with Ruff
	$(UV) run ruff format .

format-check: ## Check code formatting
	$(UV) run ruff format . --check

type-check: ## Run MyPy type checking
	$(UV) run mypy packages apps

type-check-strict: ## Run strict MyPy type checking
	$(UV) run mypy packages apps --strict

check: lint type-check format-check ## Run all code quality checks

fix: lint-fix format ## Fix all auto-fixable issues

pre-commit: ## Run pre-commit on all files
	$(UV) run pre-commit run --all-files

pre-commit-update: ## Update pre-commit hooks
	$(UV) run pre-commit autoupdate

security: ## Run security checks
	$(UV) run bandit -r packages apps -ll

security-full: ## Run comprehensive security scan
	$(UV) run bandit -r packages apps -ll -ii
	$(UV) run pip-audit
