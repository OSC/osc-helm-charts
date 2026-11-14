#!/bin/bash

SITE="/opt/dynamo/venv/lib/python3.12/site-packages/vllm"
VERSION="$1"
if [[ "$VERSION" == *"1.3.0"* ]]; then
  exit 0
fi

cd $SITE
patch -p2 < /workspace/vllm-nixl-env-patch.patch
