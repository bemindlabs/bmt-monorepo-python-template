#!/bin/bash
# ==============================================================================
# Pre-Tool Hook: Check for Sensitive Files
# ==============================================================================
# This hook prevents modifications to sensitive files like .env, credentials,
# and other security-critical files.
# ==============================================================================

# Get the file path from the tool input
FILE_PATH="${TOOL_INPUT_FILE_PATH:-$1}"

# Exit early if no file path
if [ -z "$FILE_PATH" ]; then
    exit 0
fi

# List of sensitive file patterns
SENSITIVE_PATTERNS=(
    "\.env$"
    "\.env\.local$"
    "\.env\.[^.]+\.local$"
    "\.key$"
    "\.pem$"
    "\.p12$"
    "\.pfx$"
    "\.keystore$"
    "credentials.*\.json$"
    "secrets.*\.json$"
    "firebase-adminsdk.*\.json$"
    "service-account.*\.json$"
)

# Check if file matches any sensitive pattern
for pattern in "${SENSITIVE_PATTERNS[@]}"; do
    if echo "$FILE_PATH" | grep -qE "$pattern"; then
        echo "BLOCKED: Cannot modify sensitive file: $FILE_PATH"
        echo "This file matches a protected pattern and should not be modified."
        exit 1
    fi
done

exit 0
