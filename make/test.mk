# ==============================================================================
# Testing
# ==============================================================================

test: ## Run all tests
	$(UV) run pytest

test-v: ## Run tests with verbose output
	$(UV) run pytest -v

test-vv: ## Run tests with very verbose output
	$(UV) run pytest -vv

test-watch: ## Run tests in watch mode
	$(UV) run pytest-watch

test-coverage: ## Run tests with coverage report
	$(UV) run pytest --cov=packages --cov=apps --cov-report=html --cov-report=xml

test-unit: ## Run unit tests only
	$(UV) run pytest tests/unit -m unit

test-integration: ## Run integration tests only
	$(UV) run pytest tests/integration -m integration

test-e2e: ## Run end-to-end tests only
	$(UV) run pytest tests/e2e -m e2e

test-fast: ## Run tests excluding slow ones
	$(UV) run pytest -m "not slow"

test-parallel: ## Run tests in parallel
	$(UV) run pytest -n auto

test-failed: ## Re-run only failed tests
	$(UV) run pytest --lf

test-new: ## Run only new/modified tests
	$(UV) run pytest --nf

test-ci: check test ## Run CI test suite (lint + type-check + tests)

test-package: ## Run tests for specific package (usage: make test-package PKG=core)
	$(UV) run pytest packages/$(PKG)/tests

coverage-report: ## Generate HTML coverage report
	$(UV) run coverage html
	@echo "$(GREEN)Coverage report generated at coverage/html/index.html$(RESET)"

coverage-show: ## Open coverage report in browser
	open coverage/html/index.html
