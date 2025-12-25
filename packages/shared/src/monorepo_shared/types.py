"""Common type definitions for the monorepo."""

from dataclasses import dataclass
from typing import Generic, TypeVar

from pydantic import BaseModel, Field

T = TypeVar("T")
E = TypeVar("E", bound=Exception)


@dataclass(frozen=True)
class Success(Generic[T]):
    """Represents a successful result."""

    value: T

    @property
    def is_success(self) -> bool:
        return True

    @property
    def is_failure(self) -> bool:
        return False


@dataclass(frozen=True)
class Failure(Generic[E]):
    """Represents a failed result."""

    error: E

    @property
    def is_success(self) -> bool:
        return False

    @property
    def is_failure(self) -> bool:
        return True


# Result type alias for functional error handling
Result = Success[T] | Failure[E]


class PaginationParams(BaseModel):
    """Parameters for pagination."""

    page: int = Field(default=1, ge=1, description="Page number (1-indexed)")
    page_size: int = Field(default=20, ge=1, le=100, description="Number of items per page")
    sort_by: str | None = Field(default=None, description="Field to sort by")
    sort_order: str = Field(default="asc", pattern="^(asc|desc)$", description="Sort order")

    @property
    def offset(self) -> int:
        """Calculate offset for database queries."""
        return (self.page - 1) * self.page_size


class Paginated(BaseModel, Generic[T]):
    """Paginated response wrapper."""

    items: list[T]
    total: int = Field(description="Total number of items")
    page: int = Field(description="Current page number")
    page_size: int = Field(description="Items per page")
    total_pages: int = Field(description="Total number of pages")

    @classmethod
    def create(
        cls,
        items: list[T],
        total: int,
        params: PaginationParams,
    ) -> "Paginated[T]":
        """Create a paginated response from items and parameters."""
        total_pages = (total + params.page_size - 1) // params.page_size
        return cls(
            items=items,
            total=total,
            page=params.page,
            page_size=params.page_size,
            total_pages=total_pages,
        )

    @property
    def has_next(self) -> bool:
        """Check if there is a next page."""
        return self.page < self.total_pages

    @property
    def has_previous(self) -> bool:
        """Check if there is a previous page."""
        return self.page > 1
