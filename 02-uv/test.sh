#!/usr/bin/env bash
cd "$(dirname "$0")"
source ./env.sh
rm -rf .venv uv.lock
uv sync -v 2>&1 | grep -Ei "nexus|index|Downloaded|Resolved" | head -20
grep -n "source" uv.lock | head
