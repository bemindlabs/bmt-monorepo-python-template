# ==============================================================================
# Release & Publishing
# ==============================================================================

release-patch: ## Create patch release
	@echo "$(GREEN)Creating patch release...$(RESET)"
	$(UV) run cz bump --increment patch
	git push origin $(shell git branch --show-current) --tags

release-minor: ## Create minor release
	@echo "$(GREEN)Creating minor release...$(RESET)"
	$(UV) run cz bump --increment minor
	git push origin $(shell git branch --show-current) --tags

release-major: ## Create major release
	@echo "$(GREEN)Creating major release...$(RESET)"
	$(UV) run cz bump --increment major
	git push origin $(shell git branch --show-current) --tags

publish: ## Publish packages to PyPI
	$(UV) publish

publish-test: ## Publish packages to Test PyPI
	$(UV) publish --repository testpypi

tag: ## Create git tag (usage: make tag TAG=v1.0.0)
	git tag -a $(TAG) -m "Release $(TAG)"
	git push origin $(TAG)

tag-list: ## List all tags
	git tag -l --sort=-version:refname

tag-delete: ## Delete tag (usage: make tag-delete TAG=v1.0.0)
	git tag -d $(TAG)
	git push origin --delete $(TAG)

version: ## Show current version
	$(UV) run cz version

version-project: ## Show project version
	@grep -m1 'version = ' pyproject.toml | cut -d'"' -f2
