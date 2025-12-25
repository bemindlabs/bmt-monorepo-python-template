# ==============================================================================
# GCP Deployment
# ==============================================================================

GCLOUD := gcloud
TF := terraform

# Configuration (override with environment variables)
GCP_PROJECT ?= $(shell $(GCLOUD) config get-value project)
GCP_REGION ?= asia-southeast1

# Cloud Run
gcp-build: ## Build container image for Cloud Run
	$(GCLOUD) builds submit --tag gcr.io/$(GCP_PROJECT)/monorepo-api

gcp-push: ## Push to Container Registry
	docker push gcr.io/$(GCP_PROJECT)/monorepo-api:latest

gcp-run-deploy: ## Deploy to Cloud Run
	$(GCLOUD) run deploy monorepo-api \
		--image gcr.io/$(GCP_PROJECT)/monorepo-api:latest \
		--platform managed \
		--region $(GCP_REGION) \
		--allow-unauthenticated

gcp-run-deploy-yaml: ## Deploy Cloud Run from YAML
	$(GCLOUD) run services replace infra/gcp/cloud-run/service.yaml \
		--region $(GCP_REGION)

gcp-run-logs: ## View Cloud Run logs
	$(GCLOUD) run services logs read monorepo-api --region $(GCP_REGION) --limit 100

gcp-run-logs-follow: ## Follow Cloud Run logs
	$(GCLOUD) alpha run services logs tail monorepo-api --region $(GCP_REGION)

gcp-run-describe: ## Describe Cloud Run service
	$(GCLOUD) run services describe monorepo-api --region $(GCP_REGION)

gcp-run-revisions: ## List Cloud Run revisions
	$(GCLOUD) run revisions list --service monorepo-api --region $(GCP_REGION)

gcp-run-traffic: ## Update traffic (usage: make gcp-run-traffic REVISION=rev-001 PERCENT=50)
	$(GCLOUD) run services update-traffic monorepo-api \
		--region $(GCP_REGION) \
		--to-revisions $(REVISION)=$(PERCENT)

# Cloud Functions
gcp-functions-deploy: ## Deploy Cloud Function
	$(GCLOUD) functions deploy monorepo-api \
		--gen2 \
		--runtime python312 \
		--region $(GCP_REGION) \
		--source apps/api/src \
		--entry-point handler \
		--trigger-http \
		--allow-unauthenticated

gcp-functions-logs: ## View Cloud Function logs
	$(GCLOUD) functions logs read monorepo-api --region $(GCP_REGION) --limit 100

gcp-functions-describe: ## Describe Cloud Function
	$(GCLOUD) functions describe monorepo-api --region $(GCP_REGION)

gcp-functions-delete: ## Delete Cloud Function
	$(GCLOUD) functions delete monorepo-api --region $(GCP_REGION) --quiet

# Terraform
gcp-tf-init: ## Initialize GCP Terraform
	cd infra/gcp/terraform && $(TF) init

gcp-tf-plan: ## Plan GCP Terraform changes
	cd infra/gcp/terraform && $(TF) plan -var="project_id=$(GCP_PROJECT)" -var="region=$(GCP_REGION)"

gcp-tf-apply: ## Apply GCP Terraform changes
	cd infra/gcp/terraform && $(TF) apply -auto-approve -var="project_id=$(GCP_PROJECT)" -var="region=$(GCP_REGION)"

gcp-tf-destroy: ## Destroy GCP Terraform resources
	cd infra/gcp/terraform && $(TF) destroy -auto-approve -var="project_id=$(GCP_PROJECT)" -var="region=$(GCP_REGION)"

gcp-tf-output: ## Show Terraform outputs
	cd infra/gcp/terraform && $(TF) output

# App Engine
gcp-appengine-deploy: ## Deploy to App Engine
	$(GCLOUD) app deploy infra/gcp/app-engine/app.yaml --quiet

gcp-appengine-logs: ## View App Engine logs
	$(GCLOUD) app logs tail -s default

gcp-appengine-browse: ## Open App Engine in browser
	$(GCLOUD) app browse

gcp-appengine-versions: ## List App Engine versions
	$(GCLOUD) app versions list

# Artifact Registry
gcp-ar-create: ## Create Artifact Registry repository
	$(GCLOUD) artifacts repositories create monorepo \
		--repository-format docker \
		--location $(GCP_REGION)

gcp-ar-login: ## Configure Docker for Artifact Registry
	$(GCLOUD) auth configure-docker $(GCP_REGION)-docker.pkg.dev

gcp-ar-push: ## Build and push to Artifact Registry
	docker build -t $(GCP_REGION)-docker.pkg.dev/$(GCP_PROJECT)/monorepo/api:latest -f infra/docker/Dockerfile .
	docker push $(GCP_REGION)-docker.pkg.dev/$(GCP_PROJECT)/monorepo/api:latest

# Secret Manager
gcp-secret-create: ## Create secret (usage: make gcp-secret-create NAME=SECRET_KEY VALUE=xxx)
	echo -n "$(VALUE)" | $(GCLOUD) secrets create $(NAME) --data-file=-

gcp-secret-list: ## List secrets
	$(GCLOUD) secrets list

gcp-secret-get: ## Get secret value (usage: make gcp-secret-get NAME=SECRET_KEY)
	$(GCLOUD) secrets versions access latest --secret=$(NAME)

# Pub/Sub
gcp-pubsub-create-topic: ## Create Pub/Sub topic (usage: make gcp-pubsub-create-topic TOPIC=events)
	$(GCLOUD) pubsub topics create $(TOPIC)

gcp-pubsub-create-sub: ## Create subscription (usage: make gcp-pubsub-create-sub TOPIC=events SUB=api-sub)
	$(GCLOUD) pubsub subscriptions create $(SUB) --topic $(TOPIC)

gcp-pubsub-publish: ## Publish message (usage: make gcp-pubsub-publish TOPIC=events MSG="hello")
	$(GCLOUD) pubsub topics publish $(TOPIC) --message="$(MSG)"

# Cloud SQL
gcp-sql-connect: ## Connect to Cloud SQL (usage: make gcp-sql-connect INSTANCE=db-instance)
	$(GCLOUD) sql connect $(INSTANCE) --user=postgres

gcp-sql-proxy: ## Start Cloud SQL Proxy (usage: make gcp-sql-proxy INSTANCE=db-instance)
	cloud-sql-proxy $(GCP_PROJECT):$(GCP_REGION):$(INSTANCE) --port 5432

# Utilities
gcp-whoami: ## Show current GCP identity
	$(GCLOUD) auth list
	$(GCLOUD) config list project

gcp-regions: ## List GCP regions
	$(GCLOUD) compute regions list

gcp-set-project: ## Set GCP project (usage: make gcp-set-project PROJECT=my-project)
	$(GCLOUD) config set project $(PROJECT)

gcp-costs: ## View GCP billing
	$(GCLOUD) billing accounts list

gcp-quota: ## Check compute quota
	$(GCLOUD) compute project-info describe --format="table(quotas)"

