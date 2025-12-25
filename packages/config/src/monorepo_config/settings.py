"""Settings configuration using Pydantic."""

from functools import lru_cache
from typing import Literal

from pydantic import Field
from pydantic_settings import BaseSettings as PydanticBaseSettings
from pydantic_settings import SettingsConfigDict


class BaseSettings(PydanticBaseSettings):
    """Base settings class with common configuration."""

    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        extra="ignore",
        case_sensitive=False,
    )


class Settings(BaseSettings):
    """Application settings loaded from environment variables.

    Attributes:
        environment: Application environment (development, staging, production, test).
        debug: Enable debug mode.
        log_level: Logging level.
        app_name: Application name.
        app_version: Application version.
        host: Server host.
        port: Server port.
        database_url: Database connection URL.
        redis_url: Redis connection URL.
        secret_key: Application secret key.
        cors_origins: Allowed CORS origins.
    """

    # Environment
    environment: Literal["development", "staging", "production", "test"] = Field(
        default="development",
        description="Application environment",
    )
    debug: bool = Field(default=False, description="Enable debug mode")
    log_level: str = Field(default="INFO", description="Logging level")

    # Application
    app_name: str = Field(default="Monorepo App", description="Application name")
    app_version: str = Field(default="0.1.0", description="Application version")

    # Server
    host: str = Field(default="0.0.0.0", description="Server host")
    port: int = Field(default=8000, ge=1, le=65535, description="Server port")

    # Database
    database_url: str | None = Field(
        default=None,
        description="Database connection URL",
    )

    # Redis
    redis_url: str | None = Field(
        default=None,
        description="Redis connection URL",
    )

    # Security
    secret_key: str = Field(
        default="change-me-in-production",
        min_length=32,
        description="Application secret key",
    )

    # CORS
    cors_origins: list[str] = Field(
        default=["http://localhost:3000"],
        description="Allowed CORS origins",
    )

    @property
    def is_development(self) -> bool:
        """Check if running in development environment."""
        return self.environment == "development"

    @property
    def is_production(self) -> bool:
        """Check if running in production environment."""
        return self.environment == "production"

    @property
    def is_test(self) -> bool:
        """Check if running in test environment."""
        return self.environment == "test"

    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        extra="ignore",
        case_sensitive=False,
        env_prefix="",
    )


@lru_cache
def get_settings() -> Settings:
    """Get cached application settings.

    Returns:
        Application settings instance.
    """
    return Settings()
