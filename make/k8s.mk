# ==============================================================================
# Kubernetes
# ==============================================================================

K8S_NAMESPACE ?= default
KUSTOMIZE := kustomize

k8s-dev: ## Deploy to development environment
	kubectl apply -k infra/k8s/overlays/development

k8s-staging: ## Deploy to staging environment
	kubectl apply -k infra/k8s/overlays/staging

k8s-prod: ## Deploy to production environment
	kubectl apply -k infra/k8s/overlays/production

k8s-delete-dev: ## Delete development deployment
	kubectl delete -k infra/k8s/overlays/development

k8s-delete-staging: ## Delete staging deployment
	kubectl delete -k infra/k8s/overlays/staging

k8s-delete-prod: ## Delete production deployment
	kubectl delete -k infra/k8s/overlays/production

k8s-status: ## Show Kubernetes deployment status
	kubectl get pods,svc,deployments -n $(K8S_NAMESPACE)

k8s-logs: ## View Kubernetes pod logs (usage: make k8s-logs POD=pod-name)
	kubectl logs -f $(POD) -n $(K8S_NAMESPACE)

k8s-exec: ## Exec into pod (usage: make k8s-exec POD=pod-name)
	kubectl exec -it $(POD) -n $(K8S_NAMESPACE) -- /bin/sh

k8s-port-forward: ## Port forward (usage: make k8s-port-forward SVC=svc-name PORT=8000)
	kubectl port-forward svc/$(SVC) $(PORT):$(PORT) -n $(K8S_NAMESPACE)

k8s-build-manifests: ## Build Kustomize manifests
	$(KUSTOMIZE) build infra/k8s/overlays/$(ENV)

k8s-context: ## Show current Kubernetes context
	kubectl config current-context

k8s-switch-context: ## Switch Kubernetes context (usage: make k8s-switch-context CTX=context-name)
	kubectl config use-context $(CTX)
