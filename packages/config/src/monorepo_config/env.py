"""Environment utilities."""

import os
from pathlib import Path
from typing import Literal

from dotenv import load_dotenv

Environment = Literal["development", "staging", "production", "test"]


def load_env(
    env_file: str | Path | None = None,
    override: bool = False,
) -> bool:
    """Load environment variables from a .env file.

    Args:
        env_file: Path to the .env file. If None, searches for .env in current
            directory and parent directories.
        override: If True, override existing environment variables.

    Returns:
        True if a .env file was found and loaded, False otherwise.
    """
    if env_file:
        return load_dotenv(env_file, override=override)

    # Try loading from common locations
    env_files = [
        ".env.local",
        ".env",
        Path.cwd() / ".env.local",
        Path.cwd() / ".env",
    ]

    for file in env_files:
        if Path(file).exists():
            return load_dotenv(file, override=override)

    return False


def get_env() -> Environment:
    """Get the current environment.

    Returns:
        Current environment name.
    """
    env = os.getenv("ENVIRONMENT", "development").lower()
    if env in ("development", "staging", "production", "test"):
        return env  # type: ignore[return-value]
    return "development"


def is_dev() -> bool:
    """Check if running in development environment."""
    return get_env() == "development"


def is_prod() -> bool:
    """Check if running in production environment."""
    return get_env() == "production"


def is_staging() -> bool:
    """Check if running in staging environment."""
    return get_env() == "staging"


def is_test() -> bool:
    """Check if running in test environment."""
    return get_env() == "test"


def require_env(key: str, default: str | None = None) -> str:
    """Get a required environment variable.

    Args:
        key: Environment variable name.
        default: Default value if not set.

    Returns:
        Environment variable value.

    Raises:
        ValueError: If the variable is not set and no default provided.
    """
    value = os.getenv(key, default)
    if value is None:
        raise ValueError(f"Required environment variable '{key}' is not set")
    return value


def get_bool_env(key: str, default: bool = False) -> bool:
    """Get a boolean environment variable.

    Args:
        key: Environment variable name.
        default: Default value if not set.

    Returns:
        Boolean value.
    """
    value = os.getenv(key)
    if value is None:
        return default
    return value.lower() in ("true", "1", "yes", "on")


def get_int_env(key: str, default: int = 0) -> int:
    """Get an integer environment variable.

    Args:
        key: Environment variable name.
        default: Default value if not set.

    Returns:
        Integer value.
    """
    value = os.getenv(key)
    if value is None:
        return default
    try:
        return int(value)
    except ValueError:
        return default


def get_list_env(key: str, separator: str = ",", default: list[str] | None = None) -> list[str]:
    """Get a list environment variable.

    Args:
        key: Environment variable name.
        separator: String separator for list items.
        default: Default value if not set.

    Returns:
        List of strings.
    """
    value = os.getenv(key)
    if value is None:
        return default or []
    return [item.strip() for item in value.split(separator) if item.strip()]
