"""
Monorepo Core - Core framework utilities.

This package provides core functionality including:
- Base classes and utilities
- Common patterns and abstractions
- Framework-level helpers
"""

from monorepo_core.base import BaseRepository, BaseService
from monorepo_core.decorators import cached, retry, timed
from monorepo_core.utils import deep_merge, generate_id, slugify

__version__ = "0.1.0"
__all__ = [
    "BaseRepository",
    "BaseService",
    "cached",
    "deep_merge",
    "generate_id",
    "retry",
    "slugify",
    "timed",
]
