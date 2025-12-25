"""
Monorepo Core - Core framework utilities.

This package provides core functionality including:
- Base classes and utilities
- Common patterns and abstractions
- Framework-level helpers
"""

from monorepo_core.base import BaseService, BaseRepository
from monorepo_core.decorators import retry, cached, timed
from monorepo_core.utils import generate_id, slugify, deep_merge

__version__ = "0.1.0"
__all__ = [
    "BaseService",
    "BaseRepository",
    "retry",
    "cached",
    "timed",
    "generate_id",
    "slugify",
    "deep_merge",
]
