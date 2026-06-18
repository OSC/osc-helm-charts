"""Applies fix from https://github.com/ai-dynamo/dynamo/pull/10165.

Moves fpm_worker_id out of additional_config (which perturbs vLLM compile
cache hash) into environment variables so compile cache is stable across
pod restarts.
"""
import os

SITE = "/opt/dynamo/venv/lib/python3.12/site-packages/dynamo/vllm"


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
    f"{SITE}/instrumented_scheduler.py",
    [
        (
            'ENV_FPM_PORT = "DYN_FORWARDPASS_METRIC_PORT"',
            'ENV_FPM_PORT = "DYN_FORWARDPASS_METRIC_PORT"\n'
            'ENV_FPM_WORKER_ID = "DYN_FPM_WORKER_ID"\n'
            'ENV_FPM_BENCHMARK_OUTPUT_PATH = "DYN_FPM_BENCHMARK_OUTPUT_PATH"',
        ),
        (
            'self._fpm_worker_id = vllm_config.additional_config.get("fpm_worker_id", "")',
            'self._fpm_worker_id = os.environ.get(ENV_FPM_WORKER_ID, "")',
        ),
        (
            "        self._bench_config = BenchmarkConfig(\n"
            "            **{k: v for k, v in cfg.items() if k in known}\n"
            "        )",
            "        self._bench_config = BenchmarkConfig(\n"
            "            **{k: v for k, v in cfg.items() if k in known}\n"
            "        )\n"
            "        self._bench_config.output_path = os.environ.get(\n"
            "            ENV_FPM_BENCHMARK_OUTPUT_PATH,\n"
            "            self._bench_config.output_path,\n"
            "        )",
        ),
    ],
)

patch(
    f"{SITE}/main.py",
    [
        (
            "from .handlers import get_dp_range_for_worker",
            "from .handlers import get_dp_range_for_worker\n"
            "from .instrumented_scheduler import ENV_FPM_BENCHMARK_OUTPUT_PATH, ENV_FPM_WORKER_ID",
        ),
        (
            '    if fpm_worker_id is not None:\n'
            '        vllm_config.additional_config["fpm_worker_id"] = fpm_worker_id\n',
            "    if fpm_worker_id is not None:\n"
            "        os.environ[ENV_FPM_WORKER_ID] = fpm_worker_id\n",
        ),
        (
            '            bench["output_path"] = f"/tmp/benchmark_results_{short_id}.json"',
            '            os.environ[ENV_FPM_BENCHMARK_OUTPUT_PATH] = f"/tmp/benchmark_results_{short_id}.json"',
        ),
    ],
)

patch(
    f"{SITE}/worker_factory.py",
    [
        (
            "from .multimodal_handlers import EncodeWorkerHandler",
            "from .instrumented_scheduler import ENV_FPM_BENCHMARK_OUTPUT_PATH, ENV_FPM_WORKER_ID\n"
            "from .multimodal_handlers import EncodeWorkerHandler",
        ),
        (
            '            vllm_config.additional_config["fpm_worker_id"] = fpm_worker_id',
            "            os.environ[ENV_FPM_WORKER_ID] = fpm_worker_id",
        ),
        (
            '    base_path = Path(bench_cfg["output_path"])',
            "    base_path = Path(\n"
            '        os.environ.get(ENV_FPM_BENCHMARK_OUTPUT_PATH, bench_cfg["output_path"])\n'
            "    )",
        ),
    ],
)

print("All patches applied successfully.")
