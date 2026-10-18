#!/bin/sh
# Render config, then start either the public gateway or the admin proxy.
set -eu

python - << 'PY'
import os
from pathlib import Path

text = Path("/opt/compressa/config.yaml").read_text()
if os.environ.get("OPENROUTER_API_KEY"):
    block = """model_list:
  - model_name: openrouter
    litellm_params:
      model: openrouter/openai/gpt-4o-mini
      api_key: os.environ/OPENROUTER_API_KEY
    model_info:
      id: external-openrouter
      mode: chat
"""
    needle = "model_list: []"
    if needle not in text:
        raise SystemExit("config.yaml must keep an empty model_list")
    text = text.replace(needle, block.rstrip("\n"), 1)
Path("/tmp/config.yaml").write_text(text)
PY

export CONFIG_FILE_PATH=/tmp/config.yaml
exec "$@"
