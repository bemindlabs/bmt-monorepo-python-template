# ==============================================================================
# Development
# ==============================================================================

dev: ## Start development environment
	@echo "$(GREEN)Starting development environment...$(RESET)"
	@echo "$(YELLOW)Run specific app with: make dev-app APP=app-name$(RESET)"

dev-app: ## Run specific app (usage: make dev-app APP=api)
	$(UV) run python -m apps.$(APP)

shell: ## Open Python shell with project loaded
	$(UV) run python

ipython: ## Open IPython shell (if installed)
	$(UV) run ipython

repl: shell ## Alias for shell

watch: ## Run with auto-reload (usage: make watch APP=api)
	$(UV) run watchfiles "python -m apps.$(APP)" apps/$(APP)

serve: ## Serve API application (default)
	$(UV) run uvicorn apps.api.main:app --reload --host 0.0.0.0 --port 8000

jupyter: ## Start Jupyter notebook
	$(UV) run jupyter notebook

lab: ## Start Jupyter Lab
	$(UV) run jupyter lab
