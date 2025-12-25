# ==============================================================================
# BMT Python Monorepo - Production Dockerfile
# ==============================================================================
# Multi-stage build for optimized production image
# ==============================================================================

# ------------------------------------------------------------------------------
# Stage 1: Build
# ------------------------------------------------------------------------------
FROM python:3.12-slim as builder

WORKDIR /app

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

# Copy dependency files
COPY pyproject.toml uv.lock ./
COPY packages ./packages/

# Install dependencies
RUN uv sync --frozen --no-dev --no-editable

# ------------------------------------------------------------------------------
# Stage 2: Runtime
# ------------------------------------------------------------------------------
FROM python:3.12-slim as runtime

WORKDIR /app

# Create non-root user
RUN groupadd --gid 1000 appgroup && \
    useradd --uid 1000 --gid appgroup --shell /bin/bash --create-home appuser

# Copy virtual environment from builder
COPY --from=builder /app/.venv /app/.venv

# Copy application code
COPY apps ./apps/
COPY packages ./packages/

# Set environment variables
ENV PATH="/app/.venv/bin:$PATH"
ENV PYTHONPATH="/app"
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Switch to non-root user
USER appuser

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8000/health')" || exit 1

# Expose port
EXPOSE 8000

# Run the application
CMD ["python", "-m", "uvicorn", "apps.api.main:app", "--host", "0.0.0.0", "--port", "8000"]
