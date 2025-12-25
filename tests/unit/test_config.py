"""Unit tests for monorepo-config package."""

import os
from unittest.mock import patch

import pytest

from monorepo_config.env import (
    get_env,
    is_dev,
    is_prod,
    is_staging,
    is_test,
    require_env,
    get_bool_env,
    get_int_env,
    get_list_env,
)


class TestGetEnv:
    """Tests for get_env function."""

    def test_returns_development_by_default(self) -> None:
        """Should return development by default."""
        with patch.dict(os.environ, {}, clear=True):
            assert get_env() == "development"

    def test_returns_environment_from_env_var(self) -> None:
        """Should return environment from env var."""
        with patch.dict(os.environ, {"ENVIRONMENT": "production"}):
            assert get_env() == "production"

    def test_returns_development_for_invalid_env(self) -> None:
        """Should return development for invalid env."""
        with patch.dict(os.environ, {"ENVIRONMENT": "invalid"}):
            assert get_env() == "development"


class TestEnvironmentChecks:
    """Tests for environment check functions."""

    def test_is_dev_returns_true_for_development(self) -> None:
        """Should return true for development."""
        with patch.dict(os.environ, {"ENVIRONMENT": "development"}):
            assert is_dev() is True
            assert is_prod() is False

    def test_is_prod_returns_true_for_production(self) -> None:
        """Should return true for production."""
        with patch.dict(os.environ, {"ENVIRONMENT": "production"}):
            assert is_prod() is True
            assert is_dev() is False

    def test_is_staging_returns_true_for_staging(self) -> None:
        """Should return true for staging."""
        with patch.dict(os.environ, {"ENVIRONMENT": "staging"}):
            assert is_staging() is True

    def test_is_test_returns_true_for_test(self) -> None:
        """Should return true for test."""
        with patch.dict(os.environ, {"ENVIRONMENT": "test"}):
            assert is_test() is True


class TestRequireEnv:
    """Tests for require_env function."""

    def test_returns_value_when_set(self) -> None:
        """Should return value when set."""
        with patch.dict(os.environ, {"MY_VAR": "my_value"}):
            assert require_env("MY_VAR") == "my_value"

    def test_returns_default_when_not_set(self) -> None:
        """Should return default when not set."""
        with patch.dict(os.environ, {}, clear=True):
            assert require_env("MISSING_VAR", "default") == "default"

    def test_raises_when_required_and_not_set(self) -> None:
        """Should raise when required and not set."""
        with patch.dict(os.environ, {}, clear=True):
            with pytest.raises(ValueError, match="Required environment variable"):
                require_env("MISSING_VAR")


class TestGetBoolEnv:
    """Tests for get_bool_env function."""

    @pytest.mark.parametrize("value", ["true", "1", "yes", "on", "TRUE", "Yes", "ON"])
    def test_returns_true_for_truthy_values(self, value: str) -> None:
        """Should return True for truthy values."""
        with patch.dict(os.environ, {"BOOL_VAR": value}):
            assert get_bool_env("BOOL_VAR") is True

    @pytest.mark.parametrize("value", ["false", "0", "no", "off", "anything"])
    def test_returns_false_for_falsy_values(self, value: str) -> None:
        """Should return False for falsy values."""
        with patch.dict(os.environ, {"BOOL_VAR": value}):
            assert get_bool_env("BOOL_VAR") is False

    def test_returns_default_when_not_set(self) -> None:
        """Should return default when not set."""
        with patch.dict(os.environ, {}, clear=True):
            assert get_bool_env("MISSING", default=True) is True
            assert get_bool_env("MISSING", default=False) is False


class TestGetIntEnv:
    """Tests for get_int_env function."""

    def test_returns_integer_value(self) -> None:
        """Should return integer value."""
        with patch.dict(os.environ, {"INT_VAR": "42"}):
            assert get_int_env("INT_VAR") == 42

    def test_returns_default_for_non_integer(self) -> None:
        """Should return default for non-integer."""
        with patch.dict(os.environ, {"INT_VAR": "not-a-number"}):
            assert get_int_env("INT_VAR", default=10) == 10

    def test_returns_default_when_not_set(self) -> None:
        """Should return default when not set."""
        with patch.dict(os.environ, {}, clear=True):
            assert get_int_env("MISSING", default=100) == 100


class TestGetListEnv:
    """Tests for get_list_env function."""

    def test_returns_list_from_comma_separated(self) -> None:
        """Should return list from comma-separated string."""
        with patch.dict(os.environ, {"LIST_VAR": "a,b,c"}):
            assert get_list_env("LIST_VAR") == ["a", "b", "c"]

    def test_strips_whitespace(self) -> None:
        """Should strip whitespace from items."""
        with patch.dict(os.environ, {"LIST_VAR": "a, b , c"}):
            assert get_list_env("LIST_VAR") == ["a", "b", "c"]

    def test_uses_custom_separator(self) -> None:
        """Should use custom separator."""
        with patch.dict(os.environ, {"LIST_VAR": "a;b;c"}):
            assert get_list_env("LIST_VAR", separator=";") == ["a", "b", "c"]

    def test_returns_default_when_not_set(self) -> None:
        """Should return default when not set."""
        with patch.dict(os.environ, {}, clear=True):
            assert get_list_env("MISSING", default=["x"]) == ["x"]
            assert get_list_env("MISSING") == []
