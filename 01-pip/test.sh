#!/usr/bin/env bash
cd "$(dirname "$0")"
source venv/bin/activate
pip config list
pip install -v -r requirements.txt 2>&1 | grep -Ei "nexus|repository|Looking in|Downloading" | head -20
