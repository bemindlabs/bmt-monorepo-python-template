# @monorepo/shared

Shared types, utilities, and constants for the Python monorepo.

## Features

- **Error Classes**: Standardized error handling across packages
- **Type Definitions**: Common types like `Result`, `Paginated`, etc.
- **Constants**: Environment enums, log levels, and common values

## Installation

```bash
uv add monorepo-shared
```

## Usage

### Error Handling

```python
from monorepo_shared import (
    NotFoundError,
    ValidationError,
    AuthenticationError,
)

# Raise specific errors
raise NotFoundError("User", identifier="123")
# [NOT_FOUND] User with id '123' not found

raise ValidationError("Email format is invalid", field="email")
# [VALIDATION_ERROR] Email format is invalid

# Convert errors to dict for API responses
try:
    ...
except BaseError as e:
    return e.to_dict()
```

### Result Type (Functional Error Handling)

```python
from monorepo_shared import Result, Success, Failure

def divide(a: float, b: float) -> Result[float, ValueError]:
    if b == 0:
        return Failure(ValueError("Division by zero"))
    return Success(a / b)

result = divide(10, 2)
if result.is_success:
    print(result.value)  # 5.0
```

### Pagination

```python
from monorepo_shared import PaginationParams, Paginated

# Parse pagination params
params = PaginationParams(page=2, page_size=10)
offset = params.offset  # 10

# Create paginated response
users = fetch_users(offset=params.offset, limit=params.page_size)
total = count_users()
response = Paginated.create(items=users, total=total, params=params)
```

### Constants

```python
from monorepo_shared import Environment, LogLevel

if Environment.PRODUCTION:
    log_level = LogLevel.ERROR
else:
    log_level = LogLevel.DEBUG
```

## License

MIT
