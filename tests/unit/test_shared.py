"""Unit tests for monorepo-shared package."""

import pytest

from monorepo_shared import (
    BaseError,
    Failure,
    NotFoundError,
    Paginated,
    PaginationParams,
    Success,
    ValidationError,
)


class TestBaseError:
    """Tests for BaseError class."""

    def test_creates_error_with_defaults(self) -> None:
        """Should create error with default values."""
        error = BaseError("Something went wrong")
        assert error.message == "Something went wrong"
        assert error.code == "INTERNAL_ERROR"
        assert error.details == {}

    def test_creates_error_with_custom_code(self) -> None:
        """Should create error with custom code."""
        error = BaseError("Error", code="CUSTOM_ERROR")
        assert error.code == "CUSTOM_ERROR"

    def test_creates_error_with_details(self) -> None:
        """Should create error with details."""
        error = BaseError("Error", details={"field": "email"})
        assert error.details == {"field": "email"}

    def test_to_dict_returns_correct_structure(self) -> None:
        """Should return correct dictionary structure."""
        error = BaseError("Error", code="TEST", details={"key": "value"})
        result = error.to_dict()
        assert result == {
            "error": {
                "code": "TEST",
                "message": "Error",
                "details": {"key": "value"},
            }
        }

    def test_str_returns_formatted_message(self) -> None:
        """Should return formatted string."""
        error = BaseError("Something went wrong", code="TEST_ERROR")
        assert str(error) == "[TEST_ERROR] Something went wrong"


class TestNotFoundError:
    """Tests for NotFoundError class."""

    def test_creates_error_without_identifier(self) -> None:
        """Should create error without identifier."""
        error = NotFoundError("User")
        assert error.message == "User not found"
        assert error.code == "NOT_FOUND"

    def test_creates_error_with_identifier(self) -> None:
        """Should create error with identifier."""
        error = NotFoundError("User", identifier="123")
        assert error.message == "User with id '123' not found"


class TestValidationError:
    """Tests for ValidationError class."""

    def test_creates_error_with_field(self) -> None:
        """Should create error with field."""
        error = ValidationError("Invalid email", field="email")
        assert error.message == "Invalid email"
        assert error.code == "VALIDATION_ERROR"
        assert error.details["field"] == "email"


class TestResult:
    """Tests for Result type."""

    def test_success_is_success(self) -> None:
        """Should identify Success correctly."""
        result = Success(42)
        assert result.is_success is True
        assert result.is_failure is False
        assert result.value == 42

    def test_failure_is_failure(self) -> None:
        """Should identify Failure correctly."""
        error = ValueError("error")
        result = Failure(error)
        assert result.is_success is False
        assert result.is_failure is True
        assert result.error == error


class TestPaginationParams:
    """Tests for PaginationParams class."""

    def test_default_values(self) -> None:
        """Should have correct default values."""
        params = PaginationParams()
        assert params.page == 1
        assert params.page_size == 20
        assert params.sort_by is None
        assert params.sort_order == "asc"

    def test_calculates_offset_correctly(self) -> None:
        """Should calculate offset correctly."""
        params = PaginationParams(page=3, page_size=10)
        assert params.offset == 20

    def test_validates_page_minimum(self) -> None:
        """Should validate page minimum."""
        with pytest.raises(ValueError):
            PaginationParams(page=0)

    def test_validates_page_size_maximum(self) -> None:
        """Should validate page_size maximum."""
        with pytest.raises(ValueError):
            PaginationParams(page_size=101)


class TestPaginated:
    """Tests for Paginated class."""

    def test_create_from_params(self) -> None:
        """Should create paginated response from params."""
        items = [1, 2, 3]
        params = PaginationParams(page=1, page_size=10)
        result = Paginated.create(items=items, total=25, params=params)

        assert result.items == items
        assert result.total == 25
        assert result.page == 1
        assert result.page_size == 10
        assert result.total_pages == 3

    def test_has_next(self) -> None:
        """Should correctly identify if has next page."""
        params = PaginationParams(page=1, page_size=10)
        result = Paginated.create(items=[], total=25, params=params)
        assert result.has_next is True

        params = PaginationParams(page=3, page_size=10)
        result = Paginated.create(items=[], total=25, params=params)
        assert result.has_next is False

    def test_has_previous(self) -> None:
        """Should correctly identify if has previous page."""
        params = PaginationParams(page=1, page_size=10)
        result = Paginated.create(items=[], total=25, params=params)
        assert result.has_previous is False

        params = PaginationParams(page=2, page_size=10)
        result = Paginated.create(items=[], total=25, params=params)
        assert result.has_previous is True
