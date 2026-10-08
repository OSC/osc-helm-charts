#!/bin/bash

VERSION="$1"
if [[ "$VERSION" != *"1.3.0"* ]]; then
  exit 0
fi
PATCH="$2"
if [[ "$PATCH" == "0b973594e2cac8dfcf826401333a650349abea0c.patch" ]]; then
  SITE="/usr/local/lib/python3.12/dist-packages/dynamo/vllm/"
  cd $SITE
  patch -p5 < /workspace/0b973594e2cac8dfcf826401333a650349abea0c.patch
fi
