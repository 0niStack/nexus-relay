#!/usr/bin/env bash
# Write a project-level uv.toml pointing at Nexus (gitignored; credentials via env vars).
. "$(dirname "$0")/../lib.sh"
cd "$(dirname "$0")"

{
  echo "[[index]]"
  echo 'name = "nexus"'
  echo "url = \"${BASE_URL}\""
  echo "default = true"
  if [ "$NEXUS_SCHEME" = "http" ]; then
    echo
    echo "allow-insecure-host = [\"${NEXUS_HOST}:${NEXUS_PORT}\"]"
  fi
} > uv.toml

# uv reads credentials for the index named "nexus" from these variables
cat > env.sh << ENV
export UV_INDEX_NEXUS_USERNAME='${NEXUS_USERNAME:-}'
export UV_INDEX_NEXUS_PASSWORD='${NEXUS_PASSWORD:-}'
ENV
chmod 600 env.sh

echo "Done. Run: source 02-uv/env.sh && cd 02-uv && uv sync"
