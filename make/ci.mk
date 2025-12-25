# ==============================================================================
# CI/CD Helpers
# ==============================================================================

ci-install: ## CI: Install dependencies
	$(UV) sync --frozen

ci-lint: ## CI: Run linting
	$(UV) run ruff check . --output-format=github

ci-format: ## CI: Check formatting
	$(UV) run ruff format . --check

ci-type-check: ## CI: Run type checking
	$(UV) run mypy packages apps --no-error-summary

ci-test: ## CI: Run tests with coverage
	$(UV) run pytest --cov=packages --cov=apps --cov-report=xml --cov-report=term-missing

ci-security: ## CI: Run security checks
	$(UV) run bandit -r packages apps -ll -f json -o bandit-report.json || true
	$(UV) run pip-audit --format json --output pip-audit-report.json || true

ci-all: ci-install ci-lint ci-format ci-type-check ci-test ## CI: Run all checks

zero-qa: lint type-check test ## Zero-QA: Quick quality check

zero-qa-full: zero-qa test-e2e security ## Zero-QA: Full quality check

pre-push: check test ## Pre-push validation
	@echo "$(GREEN)All checks passed! Ready to push.$(RESET)"

validate: ## Validate project configuration
	$(UV) run python -c "import tomllib; tomllib.load(open('pyproject.toml', 'rb'))" && echo "$(GREEN)✓$(RESET) pyproject.toml is valid"
	@test -f .env.example && echo "$(GREEN)✓$(RESET) .env.example exists" || echo "$(YELLOW)!$(RESET) .env.example missing"
