"""
Monorepo Shared - Shared types, utilities, and constants.

This package provides common components used across the monorepo:
- Type definitions and models
- Error classes
- Constants and enums
- Utility functions
"""

from monorepo_shared.constants import Environment, LogLevel
from monorepo_shared.errors import (
    AuthenticationError,
    AuthorizationError,
    BaseError,
    ConflictError,
    NotFoundError,
    ValidationError,
)
from monorepo_shared.types import (
    Failure,
    Paginated,
    PaginationParams,
    Result,
    Success,
)

__version__ = "0.1.0"
__all__ = [
    "AuthenticationError",
    "AuthorizationError",
    "BaseError",
    "ConflictError",
    "Environment",
    "Failure",
    "LogLevel",
    "NotFoundError",
    "Paginated",
    "PaginationParams",
    "Result",
    "Success",
    "ValidationError",
]
