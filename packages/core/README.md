# @monorepo/core

Core framework utilities for the Python monorepo.

## Features

- **Base Classes**: Abstract base classes for services and repositories
- **Decorators**: Common decorators like `@retry`, `@cached`, `@timed`
- **Utilities**: Helper functions for ID generation, string manipulation, and more

## Installation

```bash
uv add monorepo-core
```

## Usage

### Base Classes

```python
from monorepo_core import BaseService, BaseRepository

class UserService(BaseService):
    async def initialize(self) -> None:
        # Initialize service
        pass

    async def shutdown(self) -> None:
        # Cleanup resources
        pass

class UserRepository(BaseRepository[User, str]):
    async def get(self, id: str) -> User | None:
        # Fetch user from database
        pass
```

### Decorators

```python
from monorepo_core import retry, cached, timed

@retry(max_attempts=3, delay=1.0)
async def fetch_data():
    # This will retry up to 3 times on failure
    pass

@cached(ttl_seconds=300)
def expensive_computation(x: int) -> int:
    # Result is cached for 5 minutes
    return x ** 2

@timed
def process_data():
    # Execution time will be logged
    pass
```

### Utilities

```python
from monorepo_core import generate_id, slugify, deep_merge

# Generate unique IDs
user_id = generate_id("user_")  # "user_a1b2c3d4e5f6"

# Create URL-friendly slugs
slug = slugify("Hello World!")  # "hello-world"

# Deep merge dictionaries
config = deep_merge(defaults, overrides)
```

## License

MIT
