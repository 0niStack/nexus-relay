#!/usr/bin/env bash
# Shared helpers: load .env and build the Nexus index URL
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
[ -f "$ROOT/.env" ] || { echo "Missing $ROOT/.env (copy .env.example)"; exit 1; }
set -a; . "$ROOT/.env"; set +a

NEXUS_SCHEME="${NEXUS_SCHEME:-http}"
NEXUS_PORT="${NEXUS_PORT:-8081}"
BASE_URL="${NEXUS_SCHEME}://${NEXUS_HOST}:${NEXUS_PORT}/repository/${NEXUS_REPO}/simple"

urlencode() { python3 -c 'import sys,urllib.parse as u; print(u.quote(sys.argv[1], safe=""))' "$1"; }

if [ -n "${NEXUS_USERNAME:-}" ]; then
  AUTH_URL="${NEXUS_SCHEME}://$(urlencode "$NEXUS_USERNAME"):$(urlencode "${NEXUS_PASSWORD:-}")@${NEXUS_HOST}:${NEXUS_PORT}/repository/${NEXUS_REPO}/simple"
else
  AUTH_URL="$BASE_URL"
fi
