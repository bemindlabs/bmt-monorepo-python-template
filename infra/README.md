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
