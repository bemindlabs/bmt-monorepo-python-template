"""Unit tests for monorepo-core package."""

import pytest

from monorepo_core.utils import generate_id, slugify, deep_merge, chunk_list, flatten_dict


class TestGenerateId:
    """Tests for generate_id function."""

    def test_generates_unique_ids(self) -> None:
        """Should generate unique IDs."""
        id1 = generate_id()
        id2 = generate_id()
        assert id1 != id2

    def test_generates_id_with_prefix(self) -> None:
        """Should generate ID with prefix."""
        result = generate_id("user_")
        assert result.startswith("user_")

    def test_generates_id_of_correct_length(self) -> None:
        """Should generate ID of expected length."""
        result = generate_id()
        assert len(result) == 12

    def test_generates_prefixed_id_of_correct_length(self) -> None:
        """Should generate prefixed ID of correct length."""
        prefix = "test_"
        result = generate_id(prefix)
        assert len(result) == len(prefix) + 12


class TestSlugify:
    """Tests for slugify function."""

    def test_converts_to_lowercase(self) -> None:
        """Should convert text to lowercase."""
        assert slugify("Hello World") == "hello-world"

    def test_replaces_spaces_with_hyphens(self) -> None:
        """Should replace spaces with hyphens."""
        assert slugify("hello world") == "hello-world"

    def test_removes_special_characters(self) -> None:
        """Should remove special characters."""
        assert slugify("Hello, World!") == "hello-world"

    def test_handles_multiple_spaces(self) -> None:
        """Should handle multiple spaces."""
        assert slugify("hello   world") == "hello-world"

    def test_handles_empty_string(self) -> None:
        """Should handle empty string."""
        assert slugify("") == ""

    def test_removes_leading_trailing_hyphens(self) -> None:
        """Should remove leading and trailing hyphens."""
        assert slugify("  hello world  ") == "hello-world"


class TestDeepMerge:
    """Tests for deep_merge function."""

    def test_merges_flat_dicts(self) -> None:
        """Should merge flat dictionaries."""
        base = {"a": 1, "b": 2}
        override = {"b": 3, "c": 4}
        result = deep_merge(base, override)
        assert result == {"a": 1, "b": 3, "c": 4}

    def test_merges_nested_dicts(self) -> None:
        """Should merge nested dictionaries."""
        base = {"a": {"x": 1, "y": 2}}
        override = {"a": {"y": 3, "z": 4}}
        result = deep_merge(base, override)
        assert result == {"a": {"x": 1, "y": 3, "z": 4}}

    def test_does_not_modify_original(self) -> None:
        """Should not modify original dictionaries."""
        base = {"a": 1}
        override = {"b": 2}
        deep_merge(base, override)
        assert base == {"a": 1}
        assert override == {"b": 2}


class TestChunkList:
    """Tests for chunk_list function."""

    def test_chunks_list_evenly(self) -> None:
        """Should chunk list evenly."""
        items = [1, 2, 3, 4, 5, 6]
        result = chunk_list(items, 2)
        assert result == [[1, 2], [3, 4], [5, 6]]

    def test_handles_remainder(self) -> None:
        """Should handle remainder in last chunk."""
        items = [1, 2, 3, 4, 5]
        result = chunk_list(items, 2)
        assert result == [[1, 2], [3, 4], [5]]

    def test_handles_empty_list(self) -> None:
        """Should handle empty list."""
        result = chunk_list([], 2)
        assert result == []


class TestFlattenDict:
    """Tests for flatten_dict function."""

    def test_flattens_nested_dict(self) -> None:
        """Should flatten nested dictionary."""
        nested = {"a": {"b": {"c": 1}}}
        result = flatten_dict(nested)
        assert result == {"a.b.c": 1}

    def test_handles_flat_dict(self) -> None:
        """Should handle already flat dictionary."""
        flat = {"a": 1, "b": 2}
        result = flatten_dict(flat)
        assert result == {"a": 1, "b": 2}

    def test_uses_custom_separator(self) -> None:
        """Should use custom separator."""
        nested = {"a": {"b": 1}}
        result = flatten_dict(nested, separator="/")
        assert result == {"a/b": 1}
