# Vercel Configuration

Vercel deployment configuration for serverless Python applications.

## Structure

```
vercel/
├── vercel.json       # Main Vercel configuration
└── README.md         # This file
```

## Setup

### 1. Install Vercel CLI

```bash
npm install -g vercel
```

### 2. Login

```bash
vercel login
```

### 3. Link Project

```bash
vercel link
```

### 4. Deploy

```bash
# Preview deployment
vercel

# Production deployment
vercel --prod
```

## Configuration

### vercel.json

```json
{
  "version": 2,
  "builds": [
    {
      "src": "apps/api/src/api/main.py",
      "use": "@vercel/python"
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "apps/api/src/api/main.py"
    }
  ]
}
```

### Environment Variables

Set in Vercel Dashboard or via CLI:

```bash
# Set environment variable
vercel env add ENVIRONMENT production

# List variables
vercel env ls

# Pull to local
vercel env pull .env.local
```

### Required Variables

| Variable | Description |
|----------|-------------|
| `ENVIRONMENT` | production/staging |
| `LOG_LEVEL` | INFO/WARNING |
| `SECRET_KEY` | Application secret |
| `DATABASE_URL` | Database connection (if used) |

## FastAPI Adapter

For FastAPI applications, create an adapter:

```python
# apps/api/src/api/main.py
from fastapi import FastAPI
from mangum import Mangum

app = FastAPI()

@app.get("/")
async def root():
    return {"message": "Hello from Vercel"}

@app.get("/health")
async def health():
    return {"status": "healthy"}

# Vercel adapter
handler = Mangum(app)
```

### Dependencies

Add to `apps/api/pyproject.toml`:

```toml
dependencies = [
    "fastapi>=0.115.0",
    "mangum>=0.17.0",  # AWS Lambda/Vercel adapter
]
```

## Monorepo Deployment

### Deploy Specific App

```bash
# Deploy API only
vercel --cwd apps/api

# With custom config
vercel --cwd apps/api -c infra/vercel/vercel.json
```

### Multiple Apps

Create separate `vercel.json` for each app:

```
infra/vercel/
├── api.vercel.json
├── web.vercel.json
└── README.md
```

## Commands

```bash
# Preview deploy
make vercel-preview

# Production deploy
make vercel-prod

# View logs
vercel logs

# List deployments
vercel ls
```

## Makefile Targets

Add to `make/vercel.mk`:

```makefile
vercel-preview: ## Deploy to Vercel preview
	vercel

vercel-prod: ## Deploy to Vercel production
	vercel --prod

vercel-logs: ## View Vercel logs
	vercel logs

vercel-env: ## Pull Vercel env vars
	vercel env pull .env.vercel
```

## Regions

Available regions:
- `sin1` - Singapore
- `hnd1` - Tokyo
- `sfo1` - San Francisco
- `iad1` - Washington DC
- `cdg1` - Paris
- `lhr1` - London

## Troubleshooting

### Build Failures

1. Check Python version compatibility
2. Verify dependencies in requirements.txt
3. Check function size limits (50MB)

### Cold Starts

- Use smaller dependencies
- Consider edge functions
- Enable function warming

### Logs

```bash
# Real-time logs
vercel logs --follow

# Filter by function
vercel logs apps/api/src/api/main.py
```
