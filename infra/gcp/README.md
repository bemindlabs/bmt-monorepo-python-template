# GCP Infrastructure

Google Cloud Platform deployment configuration for Python applications.

## Structure

```
gcp/
├── cloud-run/          # Cloud Run configurations
│   └── service.yaml
├── cloud-functions/    # Cloud Functions configs
│   └── main.py
├── terraform/          # Terraform configurations
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── app-engine/         # App Engine configs
│   └── app.yaml
└── README.md
```

## Prerequisites

- Google Cloud SDK (gcloud) installed and configured
- Terraform installed (for Terraform deployments)
- Docker installed (for Cloud Run)

## Setup

### Google Cloud SDK

```bash
# Install gcloud CLI
brew install google-cloud-sdk

# Initialize
gcloud init

# Login
gcloud auth login

# Set project
gcloud config set project PROJECT_ID

# Verify
gcloud config list
```

### Application Default Credentials

```bash
# For local development
gcloud auth application-default login
```

## Cloud Run Deployment

### Service Configuration

```yaml
# infra/gcp/cloud-run/service.yaml
apiVersion: serving.knative.dev/v1
kind: Service
metadata:
  name: monorepo-api
spec:
  template:
    spec:
      containers:
        - image: gcr.io/PROJECT_ID/monorepo-api:latest
          ports:
            - containerPort: 8080
          resources:
            limits:
              memory: 1Gi
              cpu: "1"
          env:
            - name: ENVIRONMENT
              value: production
            - name: LOG_LEVEL
              value: INFO
```

### Deploy

```bash
# Build and push image
make gcp-build

# Deploy to Cloud Run
make gcp-run-deploy

# Deploy with traffic split
gcloud run services update-traffic api --to-revisions=LATEST=100
```

## Cloud Functions

### Function Configuration

```python
# infra/gcp/cloud-functions/main.py
import functions_framework
from flask import jsonify

@functions_framework.http
def hello_http(request):
    """HTTP Cloud Function."""
    return jsonify({"message": "Hello from Cloud Functions"})

@functions_framework.cloud_event
def hello_pubsub(cloud_event):
    """Pub/Sub triggered function."""
    import base64
    data = base64.b64decode(cloud_event.data["message"]["data"])
    print(f"Received message: {data}")
```

### Deploy

```bash
# Deploy HTTP function
make gcp-functions-deploy

# Deploy with env vars
gcloud functions deploy api \
  --runtime python312 \
  --trigger-http \
  --set-env-vars ENVIRONMENT=production
```

## Terraform

### Configuration

```hcl
# infra/gcp/terraform/main.tf
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }

  backend "gcs" {
    bucket = "terraform-state-bucket"
    prefix = "monorepo"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_cloud_run_service" "api" {
  name     = "monorepo-api"
  location = var.region

  template {
    spec {
      containers {
        image = "gcr.io/${var.project_id}/monorepo-api:latest"

        resources {
          limits = {
            memory = "1Gi"
            cpu    = "1"
          }
        }

        env {
          name  = "ENVIRONMENT"
          value = var.environment
        }
      }
    }
  }
}

resource "google_cloud_run_service_iam_member" "public" {
  service  = google_cloud_run_service.api.name
  location = google_cloud_run_service.api.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}
```

### Deploy

```bash
# Initialize
make gcp-tf-init

# Plan
make gcp-tf-plan

# Apply
make gcp-tf-apply

# Destroy
make gcp-tf-destroy
```

## App Engine

### Configuration

```yaml
# infra/gcp/app-engine/app.yaml
runtime: python312

instance_class: F2

env_variables:
  ENVIRONMENT: production
  LOG_LEVEL: INFO

automatic_scaling:
  min_instances: 1
  max_instances: 10
  target_cpu_utilization: 0.65

handlers:
  - url: /.*
    script: auto
```

### Deploy

```bash
# Deploy to App Engine
make gcp-appengine-deploy

# View logs
gcloud app logs tail -s default
```

## Environment Variables

Set using Secret Manager or directly:

| Variable | Description | Storage |
|----------|-------------|---------|
| `ENVIRONMENT` | production/staging | Env var |
| `LOG_LEVEL` | INFO/WARNING | Env var |
| `SECRET_KEY` | Application secret | Secret Manager |
| `DATABASE_URL` | Database connection | Secret Manager |

### Secret Manager

```bash
# Create secret
echo -n "secret-value" | gcloud secrets create SECRET_KEY --data-file=-

# Grant access
gcloud secrets add-iam-policy-binding SECRET_KEY \
  --member="serviceAccount:SA@PROJECT.iam.gserviceaccount.com" \
  --role="roles/secretmanager.secretAccessor"
```

## Regions

Recommended regions:
- `asia-southeast1` - Singapore
- `asia-northeast1` - Tokyo
- `us-central1` - Iowa
- `europe-west1` - Belgium

## Makefile Targets

```bash
# Cloud Run
make gcp-build          # Build container image
make gcp-push           # Push to Container Registry
make gcp-run-deploy     # Deploy to Cloud Run
make gcp-run-logs       # View Cloud Run logs

# Cloud Functions
make gcp-functions-deploy  # Deploy Cloud Function
make gcp-functions-logs    # View function logs

# Terraform
make gcp-tf-init        # Initialize Terraform
make gcp-tf-plan        # Plan Terraform changes
make gcp-tf-apply       # Apply Terraform changes
make gcp-tf-destroy     # Destroy Terraform resources

# App Engine
make gcp-appengine-deploy  # Deploy to App Engine
make gcp-appengine-logs    # View App Engine logs
```

## Artifact Registry

Modern alternative to Container Registry:

```bash
# Create repository
gcloud artifacts repositories create monorepo \
  --repository-format=docker \
  --location=asia-southeast1

# Configure Docker
gcloud auth configure-docker asia-southeast1-docker.pkg.dev

# Build and push
docker build -t asia-southeast1-docker.pkg.dev/PROJECT/monorepo/api:latest .
docker push asia-southeast1-docker.pkg.dev/PROJECT/monorepo/api:latest
```

## Cost Optimization

- Use Cloud Run with minimum instances = 0
- Enable Cloud Run CPU allocation only during request processing
- Use Committed Use Discounts for sustained workloads
- Set up Budget Alerts

## Security Best Practices

- Use Workload Identity for service accounts
- Enable VPC Service Controls
- Use Secret Manager for sensitive data
- Enable Cloud Audit Logs
- Use Cloud Armor for protection

## Troubleshooting

### Cloud Run Issues

```bash
# View logs
gcloud run services logs read api --limit=100

# Describe service
gcloud run services describe api

# Check IAM
gcloud run services get-iam-policy api
```

### Permission Issues

```bash
# List active account
gcloud auth list

# Check project
gcloud config get-value project

# Grant Cloud Run invoker
gcloud run services add-iam-policy-binding api \
  --member="user:email@example.com" \
  --role="roles/run.invoker"
```
