# Infrastructure

This directory contains infrastructure configurations and deployment manifests.

## Structure

```
infra/
├── docker/         # Docker configurations
│   ├── Dockerfile
│   └── docker-compose.yml
├── k8s/            # Kubernetes manifests
│   ├── base/       # Base configurations
│   └── overlays/   # Environment-specific overlays
│       ├── development/
│       ├── staging/
│       └── production/
├── vercel/         # Vercel serverless deployment
│   └── vercel.json
├── aws/            # AWS configurations
│   ├── cdk/        # AWS CDK stacks
│   ├── cloudformation/
│   ├── terraform/
│   └── lambda/
├── gcp/            # GCP configurations
│   ├── cloud-run/
│   ├── cloud-functions/
│   ├── terraform/
│   └── app-engine/
└── firebase/       # Firebase configurations (if used)
```

## Docker

### Development

```bash
# Start all services
make docker-up

# View logs
make docker-logs

# Stop services
make docker-down
```

### Production Build

```bash
# Build production image
make docker-build-prod

# Run production container
make docker-run-prod
```

## Kubernetes

### Prerequisites

- kubectl configured for your cluster
- Kustomize installed

### Deployment

```bash
# Deploy to development
make k8s-dev

# Deploy to staging
make k8s-staging

# Deploy to production
make k8s-prod
```

### Customization

Each environment overlay in `k8s/overlays/` can customize:
- Replica count
- Resource limits
- Environment variables
- ConfigMaps and Secrets

## Environment-Specific Configuration

| Environment | Replicas | Memory | Log Level |
|-------------|----------|--------|-----------|
| Development | 1 | 256Mi-512Mi | DEBUG |
| Staging | 2 | 256Mi-512Mi | INFO |
| Production | 3 | 512Mi-1Gi | WARNING |

## Vercel

Serverless deployment for Python applications.

### Setup

```bash
# Install Vercel CLI
npm install -g vercel

# Login and link
vercel login
vercel link
```

### Deployment

```bash
# Preview deployment
make vercel-preview

# Production deployment
make vercel-prod

# View logs
make vercel-logs
```

See [vercel/README.md](vercel/README.md) for detailed configuration.

## AWS

AWS deployment options: CDK, CloudFormation, Terraform, and Lambda.

### Prerequisites

```bash
# Install AWS CLI
pip install awscli

# Configure credentials
aws configure
```

### Deployment

```bash
# CDK
make aws-cdk-deploy

# CloudFormation
make aws-cfn-deploy ENV=production

# Terraform
make aws-tf-apply

# Lambda
make aws-lambda-deploy
```

See [aws/README.md](aws/README.md) for detailed configuration.

## GCP

GCP deployment options: Cloud Run, Cloud Functions, Terraform, and App Engine.

### Prerequisites

```bash
# Install gcloud CLI
brew install google-cloud-sdk

# Initialize
gcloud init
```

### Deployment

```bash
# Cloud Run
make gcp-run-deploy

# Cloud Functions
make gcp-functions-deploy

# Terraform
make gcp-tf-apply

# App Engine
make gcp-appengine-deploy
```

See [gcp/README.md](gcp/README.md) for detailed configuration.
