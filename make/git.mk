# ==============================================================================
# Git & Version Control
# ==============================================================================

git-status: ## Show git status
	git status

git-log: ## Show recent commits
	git log --oneline -20

git-branch: ## List branches
	git branch -a

git-sync: ## Sync with remote
	git fetch --all --prune
	git pull origin $(shell git branch --show-current)

git-clean-branches: ## Clean merged branches
	git branch --merged | grep -v '\*\|main\|master\|develop' | xargs -n 1 git branch -d

commit: ## Create a conventional commit (interactive)
	$(UV) run cz commit

commit-all: ## Add all and commit (interactive)
	git add -A
	$(UV) run cz commit

amend: ## Amend last commit
	git commit --amend

rebase-main: ## Rebase current branch on main
	git fetch origin main
	git rebase origin/main

stash: ## Stash changes
	git stash

stash-pop: ## Pop stashed changes
	git stash pop

changelog: ## Generate changelog
	$(UV) run cz changelog

bump: ## Bump version (usage: make bump PART=patch|minor|major)
	$(UV) run cz bump --$(PART)

bump-patch: ## Bump patch version
	$(UV) run cz bump --increment patch

bump-minor: ## Bump minor version
	$(UV) run cz bump --increment minor

bump-major: ## Bump major version
	$(UV) run cz bump --increment major
