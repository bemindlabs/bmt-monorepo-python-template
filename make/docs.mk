# ==============================================================================
# Documentation
# ==============================================================================

docs: ## Build documentation
	$(UV) run mkdocs build

docs-serve: ## Serve documentation locally
	$(UV) run mkdocs serve

docs-deploy: ## Deploy documentation to GitHub Pages
	$(UV) run mkdocs gh-deploy

docs-clean: ## Clean documentation build
	rm -rf site/

api-docs: ## Generate API documentation
	$(UV) run pdoc --html --output-dir docs/api packages

api-docs-serve: ## Serve API documentation
	$(UV) run pdoc --http : packages

docstrings-check: ## Check docstring coverage
	$(UV) run interrogate -v packages apps

docstrings-badge: ## Generate docstring coverage badge
	$(UV) run interrogate --generate-badge docs/images/interrogate_badge.svg packages apps
