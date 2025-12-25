"""Base classes for services and repositories."""

from abc import ABC, abstractmethod
from typing import Any, Generic, TypeVar

T = TypeVar("T")
ID = TypeVar("ID")


class BaseService(ABC):
    """Abstract base class for services.

    Provides a common interface for business logic services.
    """

    @abstractmethod
    async def initialize(self) -> None:
        """Initialize the service."""
        ...

    @abstractmethod
    async def shutdown(self) -> None:
        """Shutdown the service gracefully."""
        ...


class BaseRepository(ABC, Generic[T, ID]):
    """Abstract base class for repositories.

    Provides a common interface for data access operations.
    """

    @abstractmethod
    async def get(self, id: ID) -> T | None:
        """Get an entity by ID."""
        ...

    @abstractmethod
    async def get_all(self) -> list[T]:
        """Get all entities."""
        ...

    @abstractmethod
    async def create(self, entity: T) -> T:
        """Create a new entity."""
        ...

    @abstractmethod
    async def update(self, id: ID, entity: T) -> T | None:
        """Update an existing entity."""
        ...

    @abstractmethod
    async def delete(self, id: ID) -> bool:
        """Delete an entity by ID."""
        ...

    @abstractmethod
    async def exists(self, id: ID) -> bool:
        """Check if an entity exists."""
        ...


class BaseEntity:
    """Base class for domain entities."""

    def __init__(self, id: Any | None = None) -> None:
        self._id = id

    @property
    def id(self) -> Any | None:
        """Get the entity ID."""
        return self._id

    def __eq__(self, other: object) -> bool:
        if not isinstance(other, BaseEntity):
            return False
        return self._id == other._id

    def __hash__(self) -> int:
        return hash(self._id)
