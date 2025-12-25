"""Common decorators for the framework."""

import asyncio
import functools
import time
from collections.abc import Callable
from typing import Any, ParamSpec, TypeVar

P = ParamSpec("P")
R = TypeVar("R")


def retry(
    max_attempts: int = 3,
    delay: float = 1.0,
    backoff: float = 2.0,
    exceptions: tuple[type[Exception], ...] = (Exception,),
) -> Callable[[Callable[P, R]], Callable[P, R]]:
    """Decorator that retries a function on failure.

    Args:
        max_attempts: Maximum number of retry attempts.
        delay: Initial delay between retries in seconds.
        backoff: Multiplier for delay after each retry.
        exceptions: Tuple of exceptions to catch and retry.

    Returns:
        Decorated function.
    """

    def decorator(func: Callable[P, R]) -> Callable[P, R]:
        @functools.wraps(func)
        async def async_wrapper(*args: P.args, **kwargs: P.kwargs) -> R:
            current_delay = delay
            last_exception: Exception | None = None

            for attempt in range(max_attempts):
                try:
                    return await func(*args, **kwargs)  # type: ignore[misc]
                except exceptions as e:
                    last_exception = e
                    if attempt < max_attempts - 1:
                        await asyncio.sleep(current_delay)
                        current_delay *= backoff

            raise last_exception  # type: ignore[misc]

        @functools.wraps(func)
        def sync_wrapper(*args: P.args, **kwargs: P.kwargs) -> R:
            current_delay = delay
            last_exception: Exception | None = None

            for attempt in range(max_attempts):
                try:
                    return func(*args, **kwargs)
                except exceptions as e:
                    last_exception = e
                    if attempt < max_attempts - 1:
                        time.sleep(current_delay)
                        current_delay *= backoff

            raise last_exception  # type: ignore[misc]

        if asyncio.iscoroutinefunction(func):
            return async_wrapper  # type: ignore[return-value]
        return sync_wrapper

    return decorator


def cached(ttl_seconds: float = 300.0) -> Callable[[Callable[P, R]], Callable[P, R]]:
    """Simple in-memory cache decorator with TTL.

    Args:
        ttl_seconds: Time-to-live for cached values in seconds.

    Returns:
        Decorated function.
    """
    cache: dict[str, tuple[float, Any]] = {}

    def decorator(func: Callable[P, R]) -> Callable[P, R]:
        @functools.wraps(func)
        def wrapper(*args: P.args, **kwargs: P.kwargs) -> R:
            key = str((args, tuple(sorted(kwargs.items()))))
            now = time.time()

            if key in cache:
                cached_time, cached_value = cache[key]
                if now - cached_time < ttl_seconds:
                    return cached_value  # type: ignore[return-value]

            result = func(*args, **kwargs)
            cache[key] = (now, result)
            return result

        return wrapper

    return decorator


def timed(func: Callable[P, R]) -> Callable[P, R]:
    """Decorator that logs the execution time of a function.

    Args:
        func: Function to decorate.

    Returns:
        Decorated function.
    """

    @functools.wraps(func)
    async def async_wrapper(*args: P.args, **kwargs: P.kwargs) -> R:
        start = time.perf_counter()
        try:
            return await func(*args, **kwargs)  # type: ignore[misc]
        finally:
            elapsed = time.perf_counter() - start
            print(f"{func.__name__} executed in {elapsed:.4f}s")

    @functools.wraps(func)
    def sync_wrapper(*args: P.args, **kwargs: P.kwargs) -> R:
        start = time.perf_counter()
        try:
            return func(*args, **kwargs)
        finally:
            elapsed = time.perf_counter() - start
            print(f"{func.__name__} executed in {elapsed:.4f}s")

    if asyncio.iscoroutinefunction(func):
        return async_wrapper  # type: ignore[return-value]
    return sync_wrapper
