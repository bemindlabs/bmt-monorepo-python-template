"""
Monorepo Config - Configuration and environment utilities.

This package provides configuration management:
- Environment variable loading
- Settings validation with Pydantic
- Environment detection helpers
"""

from monorepo_config.env import (
    get_env,
    is_dev,
    is_prod,
    is_staging,
    is_test,
    load_env,
)
from monorepo_config.settings import (
    BaseSettings,
    Settings,
    get_settings,
)

__version__ = "0.1.0"
__all__ = [
    "BaseSettings",
    "Settings",
    "get_env",
    "get_settings",
    "is_dev",
    "is_prod",
    "is_staging",
    "is_test",
    "load_env",
]
