"""
Monorepo Config - Configuration and environment utilities.

This package provides configuration management:
- Environment variable loading
- Settings validation with Pydantic
- Environment detection helpers
"""

from monorepo_config.settings import (
    BaseSettings,
    Settings,
    get_settings,
)
from monorepo_config.env import (
    load_env,
    is_dev,
    is_prod,
    is_staging,
    is_test,
    get_env,
)

__version__ = "0.1.0"
__all__ = [
    # Settings
    "BaseSettings",
    "Settings",
    "get_settings",
    # Environment
    "load_env",
    "is_dev",
    "is_prod",
    "is_staging",
    "is_test",
    "get_env",
]
