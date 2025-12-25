# @monorepo/config

Configuration and environment utilities for the Python monorepo.

## Features

- **Settings Management**: Pydantic-based settings with validation
- **Environment Loading**: Automatic .env file detection and loading
- **Environment Helpers**: Functions to check current environment

## Installation

```bash
uv add monorepo-config
```

## Usage

### Settings

```python
from monorepo_config import Settings, get_settings

# Get cached settings
settings = get_settings()

# Access configuration
print(settings.app_name)
print(settings.database_url)
print(settings.is_production)

# Create custom settings
class MySettings(Settings):
    custom_api_key: str
    feature_enabled: bool = False
```

### Environment Loading

```python
from monorepo_config import load_env, get_env, is_dev, is_prod

# Load .env file
load_env()

# Check environment
if is_dev():
    print("Development mode")
elif is_prod():
    print("Production mode")

# Get environment name
env = get_env()  # "development" | "staging" | "production" | "test"
```

### Environment Variable Helpers

```python
from monorepo_config.env import (
    require_env,
    get_bool_env,
    get_int_env,
    get_list_env,
)

# Required variable (raises if not set)
api_key = require_env("API_KEY")

# Boolean variables
debug = get_bool_env("DEBUG", default=False)  # True, 1, yes, on

# Integer variables
port = get_int_env("PORT", default=8000)

# List variables
origins = get_list_env("CORS_ORIGINS", separator=",")
```

## Environment Variables

| Variable | Type | Default | Description |
|----------|------|---------|-------------|
| `ENVIRONMENT` | string | development | Application environment |
| `DEBUG` | boolean | false | Enable debug mode |
| `LOG_LEVEL` | string | INFO | Logging level |
| `APP_NAME` | string | Monorepo App | Application name |
| `HOST` | string | 0.0.0.0 | Server host |
| `PORT` | integer | 8000 | Server port |
| `DATABASE_URL` | string | - | Database connection URL |
| `REDIS_URL` | string | - | Redis connection URL |
| `SECRET_KEY` | string | - | Application secret key |
| `CORS_ORIGINS` | list | localhost:3000 | Allowed CORS origins |

## License

MIT
