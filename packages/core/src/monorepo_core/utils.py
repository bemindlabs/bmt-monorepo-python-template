"""Core utility functions."""

import re
import uuid
from typing import Any


def generate_id(prefix: str = "") -> str:
    """Generate a unique identifier.

    Args:
        prefix: Optional prefix for the ID.

    Returns:
        A unique identifier string.
    """
    unique_id = uuid.uuid4().hex[:12]
    return f"{prefix}{unique_id}" if prefix else unique_id


def slugify(text: str) -> str:
    """Convert text to URL-friendly slug.

    Args:
        text: Text to convert.

    Returns:
        URL-friendly slug.
    """
    # Convert to lowercase and replace spaces with hyphens
    slug = text.lower().strip()
    slug = re.sub(r"\s+", "-", slug)
    # Remove non-alphanumeric characters (except hyphens)
    slug = re.sub(r"[^a-z0-9-]", "", slug)
    # Remove consecutive hyphens
    slug = re.sub(r"-+", "-", slug)
    # Remove leading/trailing hyphens
    return slug.strip("-")


def deep_merge(base: dict[str, Any], override: dict[str, Any]) -> dict[str, Any]:
    """Deep merge two dictionaries.

    Args:
        base: Base dictionary.
        override: Dictionary to merge on top.

    Returns:
        Merged dictionary.
    """
    result = base.copy()

    for key, value in override.items():
        if key in result and isinstance(result[key], dict) and isinstance(value, dict):
            result[key] = deep_merge(result[key], value)
        else:
            result[key] = value

    return result


def chunk_list(items: list[Any], chunk_size: int) -> list[list[Any]]:
    """Split a list into chunks of specified size.

    Args:
        items: List to split.
        chunk_size: Size of each chunk.

    Returns:
        List of chunks.
    """
    return [items[i : i + chunk_size] for i in range(0, len(items), chunk_size)]


def flatten_dict(
    d: dict[str, Any],
    parent_key: str = "",
    separator: str = ".",
) -> dict[str, Any]:
    """Flatten a nested dictionary.

    Args:
        d: Dictionary to flatten.
        parent_key: Key prefix for nested items.
        separator: Separator between keys.

    Returns:
        Flattened dictionary.
    """
    items: list[tuple[str, Any]] = []

    for key, value in d.items():
        new_key = f"{parent_key}{separator}{key}" if parent_key else key
        if isinstance(value, dict):
            items.extend(flatten_dict(value, new_key, separator).items())
        else:
            items.append((new_key, value))

    return dict(items)
