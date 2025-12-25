"""Common error classes for the monorepo."""

from typing import Any


class BaseError(Exception):
    """Base error class for all custom errors.

    Attributes:
        message: Human-readable error message.
        code: Error code for programmatic handling.
        details: Additional error details.
    """

    def __init__(
        self,
        message: str,
        code: str = "INTERNAL_ERROR",
        details: dict[str, Any] | None = None,
    ) -> None:
        super().__init__(message)
        self.message = message
        self.code = code
        self.details = details or {}

    def to_dict(self) -> dict[str, Any]:
        """Convert error to dictionary for serialization."""
        return {
            "error": {
                "code": self.code,
                "message": self.message,
                "details": self.details,
            }
        }

    def __str__(self) -> str:
        return f"[{self.code}] {self.message}"


class NotFoundError(BaseError):
    """Error raised when a resource is not found."""

    def __init__(
        self,
        resource: str,
        identifier: str | None = None,
        details: dict[str, Any] | None = None,
    ) -> None:
        message = f"{resource} not found"
        if identifier:
            message = f"{resource} with id '{identifier}' not found"

        super().__init__(
            message=message,
            code="NOT_FOUND",
            details={"resource": resource, "identifier": identifier, **(details or {})},
        )


class ValidationError(BaseError):
    """Error raised when validation fails."""

    def __init__(
        self,
        message: str = "Validation failed",
        field: str | None = None,
        details: dict[str, Any] | None = None,
    ) -> None:
        super().__init__(
            message=message,
            code="VALIDATION_ERROR",
            details={"field": field, **(details or {})},
        )


class AuthenticationError(BaseError):
    """Error raised when authentication fails."""

    def __init__(
        self,
        message: str = "Authentication required",
        details: dict[str, Any] | None = None,
    ) -> None:
        super().__init__(
            message=message,
            code="AUTHENTICATION_ERROR",
            details=details,
        )


class AuthorizationError(BaseError):
    """Error raised when authorization fails."""

    def __init__(
        self,
        message: str = "Access denied",
        required_permission: str | None = None,
        details: dict[str, Any] | None = None,
    ) -> None:
        super().__init__(
            message=message,
            code="AUTHORIZATION_ERROR",
            details={"required_permission": required_permission, **(details or {})},
        )


class ConflictError(BaseError):
    """Error raised when there is a resource conflict."""

    def __init__(
        self,
        resource: str,
        message: str | None = None,
        details: dict[str, Any] | None = None,
    ) -> None:
        super().__init__(
            message=message or f"{resource} already exists",
            code="CONFLICT",
            details={"resource": resource, **(details or {})},
        )
