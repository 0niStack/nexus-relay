.PHONY: pip-setup pip-test uv-setup uv-test clean
pip-setup: ; ./01-pip/setup.sh
pip-test:  ; ./01-pip/test.sh
uv-setup:  ; ./02-uv/setup.sh
uv-test:   ; ./02-uv/test.sh
clean:
	rm -rf 01-pip/venv 02-uv/.venv 02-uv/uv.toml 02-uv/env.sh 02-uv/uv.lock
