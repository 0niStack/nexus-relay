# nexus-python-config

Use a Nexus 3 (Sonatype) PyPI repository for **one project only**, with pip and with uv.

## Prerequisites
- Nexus repo of type `pypi (proxy)` (to https://pypi.org) or `pypi (group)`
- The index URL must end with `/simple`

## Setup
```bash
cp .env.example .env     # fill in host, repo name, credentials
```

## 01-pip
```bash
make pip-setup           # creates 01-pip/venv and venv/pip.conf
make pip-test
source 01-pip/venv/bin/activate && pip install -r 01-pip/requirements.txt
```
pip reads `pip.conf` from the active venv, so nothing outside this venv is affected.

## 02-uv
```bash
make uv-setup            # writes 02-uv/uv.toml and 02-uv/env.sh
make uv-test
source 02-uv/env.sh && cd 02-uv && uv sync
```
- `uv.toml` in the project dir overrides the user-level uv config for this project only.
- `default = true` replaces PyPI with Nexus. Remove it to use Nexus as an extra index.
- Credentials come from `UV_INDEX_NEXUS_USERNAME` / `UV_INDEX_NEXUS_PASSWORD` (the `NEXUS` part is the index `name` uppercased).
- `allow-insecure-host` is only written when using plain `http`.

## Alternatives (no files)
```bash
# pip one-off
pip install requests --index-url http://HOST:8081/repository/REPO/simple --trusted-host HOST
# uv one-off
uv pip install requests --default-index http://HOST:8081/repository/REPO/simple --allow-insecure-host HOST:8081
```

## Troubleshooting
- 401: wrong credentials, or the Nexus *anonymous access* / *PyPI Bearer Token Realm* setting needs checking
- 404 on package: the repo name or `/simple` suffix is wrong
- SSL errors: use `https` with a valid cert, or add the CA via `SSL_CERT_FILE` (uv: `--native-tls`)
- Password with special chars: handled automatically for pip; for uv they are passed via env vars as-is
