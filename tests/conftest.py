"""Pytest configuration and fixtures."""

import os
from collections.abc import Generator
from typing import Any

import pytest


@pytest.fixture(scope="session", autouse=True)
def setup_test_environment() -> Generator[None, None, None]:
    """Set up test environment variables."""
    os.environ["ENVIRONMENT"] = "test"
    os.environ["DEBUG"] = "false"
    os.environ["LOG_LEVEL"] = "WARNING"
    yield


@pytest.fixture
def sample_config() -> dict[str, Any]:
    """Provide sample configuration for tests."""
    return {
        "app_name": "Test App",
        "version": "0.1.0",
        "debug": True,
    }


@pytest.fixture
def sample_user_data() -> dict[str, Any]:
    """Provide sample user data for tests."""
    return {
        "id": "user_123456789",
        "name": "Test User",
        "email": "test@example.com",
    }
