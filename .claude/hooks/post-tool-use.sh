#!/bin/bash
# ==============================================================================
# Post-Tool Hook: Post-Edit Actions
# ==============================================================================
# This hook runs after file modifications to perform cleanup or validation.
# ==============================================================================

# Get the file path from the tool input
FILE_PATH="${TOOL_INPUT_FILE_PATH:-$1}"

# Exit early if no file path
if [ -z "$FILE_PATH" ]; then
    exit 0
fi

# Check if it's a Python file and run quick format check
if echo "$FILE_PATH" | grep -qE "\.py$"; then
    # Optionally run ruff format on the file (uncomment if desired)
    # uv run ruff format "$FILE_PATH" 2>/dev/null
    :
fi

exit 0
