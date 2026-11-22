#!/usr/bin/env bash
# Create a venv and write venv/pip.conf so ONLY this project uses Nexus.
. "$(dirname "$0")/../lib.sh"
cd "$(dirname "$0")"

python3 -m venv venv

cat > venv/pip.conf << CONF
[global]
index-url = ${AUTH_URL}
CONF
if [ "$NEXUS_SCHEME" = "http" ]; then
  echo "trusted-host = ${NEXUS_HOST}" >> venv/pip.conf
fi
chmod 600 venv/pip.conf

echo "Done. Activate with: source 01-pip/venv/bin/activate"
