"""Common constants and enums for the monorepo."""

from enum import StrEnum


class Environment(StrEnum):
    """Application environment types."""

    DEVELOPMENT = "development"
    STAGING = "staging"
    PRODUCTION = "production"
    TEST = "test"


class LogLevel(StrEnum):
    """Log level options."""

    DEBUG = "DEBUG"
    INFO = "INFO"
    WARNING = "WARNING"
    ERROR = "ERROR"
    CRITICAL = "CRITICAL"


class HttpStatus(StrEnum):
    """Common HTTP status descriptions."""

    OK = "200"
    CREATED = "201"
    NO_CONTENT = "204"
    BAD_REQUEST = "400"
    UNAUTHORIZED = "401"
    FORBIDDEN = "403"
    NOT_FOUND = "404"
    CONFLICT = "409"
    UNPROCESSABLE_ENTITY = "422"
    INTERNAL_SERVER_ERROR = "500"
    SERVICE_UNAVAILABLE = "503"


# Default configuration values
DEFAULT_PAGE_SIZE = 20
MAX_PAGE_SIZE = 100
DEFAULT_TIMEOUT_SECONDS = 30
DEFAULT_RETRY_ATTEMPTS = 3

# Common regex patterns
PATTERNS = {
    "email": r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    "uuid": r"^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$",
    "slug": r"^[a-z0-9]+(?:-[a-z0-9]+)*$",
    "phone": r"^\+?[1-9]\d{1,14}$",
}
