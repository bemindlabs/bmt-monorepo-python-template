# ==============================================================================
# Vercel Deployment
# ==============================================================================

VERCEL := vercel

vercel-login: ## Login to Vercel
	$(VERCEL) login

vercel-link: ## Link project to Vercel
	$(VERCEL) link

vercel-preview: ## Deploy to Vercel preview
	$(VERCEL)

vercel-prod: ## Deploy to Vercel production
	$(VERCEL) --prod

vercel-logs: ## View Vercel deployment logs
	$(VERCEL) logs

vercel-logs-follow: ## Follow Vercel logs in real-time
	$(VERCEL) logs --follow

vercel-ls: ## List Vercel deployments
	$(VERCEL) ls

vercel-env-pull: ## Pull Vercel environment variables
	$(VERCEL) env pull .env.vercel

vercel-env-add: ## Add Vercel environment variable (usage: make vercel-env-add KEY=value)
	$(VERCEL) env add $(KEY)

vercel-inspect: ## Inspect latest deployment
	$(VERCEL) inspect

vercel-rm: ## Remove deployment (usage: make vercel-rm URL=deployment-url)
	$(VERCEL) rm $(URL)

vercel-domains: ## List Vercel domains
	$(VERCEL) domains ls

vercel-alias: ## Create alias (usage: make vercel-alias ALIAS=custom.domain.com)
	$(VERCEL) alias $(ALIAS)
