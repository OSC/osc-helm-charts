"""Applies fix from https://github.com/ai-dynamo/dynamo/pull/10248.
"""
import os
import sys

if len(sys.argv) > 1:
    if '1.2.0' in sys.argv[1]:
        sys.exit(0)

SITE = "/usr/local/lib/python3.12/dist-packages/dynamo/vllm/"


def patch(path, replacements):
    with open(path) as f:
        src = f.read()
    for old, new in replacements:
        assert old in src, f"Pattern not found in {path}:\n{old!r}"
        src = src.replace(old, new, 1)
    with open(path, "w") as f:
        f.write(src)
    print(f"patched {path}")


patch(
    f"{SITE}/handlers.py",
    [
        (
            'from vllm import PoolingParams',
            '',
        ),
        (
            'import torch',
            'import torch\n'
            'from vllm import PoolingParams',
        ),
        (
            'pooling_params = PoolingParams()',
            'pooling_params = PoolingParams(task="embed")',
        ),
    ],
)

