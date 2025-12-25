"""
Monorepo Shared - Shared types, utilities, and constants.

This package provides common components used across the monorepo:
- Type definitions and models
- Error classes
- Constants and enums
- Utility functions
"""

from monorepo_shared.errors import (
    BaseError,
    NotFoundError,
    ValidationError,
    AuthenticationError,
    AuthorizationError,
    ConflictError,
)
from monorepo_shared.types import (
    Result,
    Success,
    Failure,
    Paginated,
    PaginationParams,
)
from monorepo_shared.constants import Environment, LogLevel

__version__ = "0.1.0"
__all__ = [
    # Errors
    "BaseError",
    "NotFoundError",
    "ValidationError",
    "AuthenticationError",
    "AuthorizationError",
    "ConflictError",
    # Types
    "Result",
    "Success",
    "Failure",
    "Paginated",
    "PaginationParams",
    # Constants
    "Environment",
    "LogLevel",
]
