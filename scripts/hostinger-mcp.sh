#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [[ -z "${API_TOKEN:-}" && -z "${HOSTINGER_API_TOKEN:-}" ]]; then
  if [[ -f "${VPS_PROFILES_PATH:-$ROOT_DIR/profiles.json}" ]]; then
    eval "$(
      node "$ROOT_DIR/scripts/profiles.js" resolve --provider hostinger --format shell
    )"
  fi
fi

if ! command -v hostinger-api-mcp >/dev/null 2>&1; then
  echo "hostinger-api-mcp not found in PATH. Install with: npm install -g hostinger-api-mcp" >&2
  exit 1
fi

if [[ -z "${HOSTINGER_API_TOKEN:-}" && -z "${API_TOKEN:-}" ]]; then
  echo "Missing HOSTINGER_API_TOKEN or API_TOKEN in the environment or selected profiles.json entry." >&2
  exit 1
fi

if [[ -z "${API_TOKEN:-}" ]]; then
  export API_TOKEN="$HOSTINGER_API_TOKEN"
fi

if [[ -z "${DEBUG:-}" ]]; then
  export DEBUG="${HOSTINGER_MCP_DEBUG:-false}"
fi

exec hostinger-api-mcp "$@"
