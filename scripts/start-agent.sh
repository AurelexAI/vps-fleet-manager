#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

if ! command -v codex >/dev/null 2>&1; then
  echo "codex not found. Run ./scripts/bootstrap-unix.sh first." >&2
  exit 1
fi

exec codex "$@"
