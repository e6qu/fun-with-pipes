#!/usr/bin/env python3
"""Compare CI Rust profiles on the same source and runner, retaining debug checks."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import resource
import subprocess
import time

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument("--source", type=Path, required=True)
parser.add_argument("--output", type=Path, required=True)
args = parser.parse_args()
source, output = args.source.resolve(), args.output.resolve()
output.mkdir(parents=True, exist_ok=True)
head = subprocess.check_output(["git", "rev-parse", "HEAD"], cwd=source, text=True).strip()
assert head == os.environ["SOURCE_REVISION"]
targets = ["linalg_ownership", "arc_tasks"]
report = {"sourceHead": head, "platform": platform.platform(),
          "machine": platform.machine(), "logicalCpus": os.cpu_count(),
          "rustc": subprocess.check_output(["rustc", "-Vv"], text=True),
          "cc": subprocess.check_output([os.environ["CC"], "--version"], text=True),
          "targets": targets, "builds": [], "samples": [],
          "scope": "Same runner and source; Rust optimization levels 0/1 with debug assertions and overflow checks enabled. Separate builds and caches, one complete warmup per profile, then balanced 0/1/1/0 test-harness runs. Generated-C flags and each target's test cases are unchanged. Build times are separate from test times. This measures CI workloads, not fwp/C/Rust program parity; two samples per profile do not characterize arbitrary runner noise."}

def save():
    (output / "report.json").write_text(json.dumps(report, indent=2) + "\n")

def measured(command, env, label):
    before = resource.getrusage(resource.RUSAGE_CHILDREN)
    start = time.monotonic()
    result = subprocess.run(command, cwd=source, env=env, capture_output=True, timeout=1800)
    after = resource.getrusage(resource.RUSAGE_CHILDREN)
    row = {"command": command, "wallSeconds": time.monotonic()-start,
           "childCpuSeconds": after.ru_utime+after.ru_stime-before.ru_utime-before.ru_stime,
           "exitCode": result.returncode}
    (output / (label+".stdout")).write_bytes(result.stdout)
    (output / (label+".stderr")).write_bytes(result.stderr)
    print(label, json.dumps(row), flush=True)
    if result.returncode:
        report["failure"] = {"label": label, **row}; save()
        raise RuntimeError(f"{label} failed; see retained output")
    return row, result.stdout

profiles = {}
for level in [0, 1]:
    env = dict(os.environ)
    for profile in ["DEV", "TEST"]:
        env[f"CARGO_PROFILE_{profile}_OPT_LEVEL"] = str(level)
        env[f"CARGO_PROFILE_{profile}_DEBUG_ASSERTIONS"] = "true"
        env[f"CARGO_PROFILE_{profile}_OVERFLOW_CHECKS"] = "true"
    env["CARGO_TARGET_DIR"] = str(Path(os.environ["RUNNER_TEMP"]) / f"ci-profile-target-{level}")
    env["FWP_CACHE_DIR"] = str(Path(os.environ["RUNNER_TEMP"]) / f"ci-profile-cache-{level}")
    command = ["cargo", "test", "--no-run", "--message-format=json"]
    for target in targets:
        command += ["--test", target]
    build, data = measured(command, env, f"build-{level}")
    executables = {}
    for line in data.splitlines():
        message = json.loads(line)
        if message.get("reason") != "compiler-artifact" or not message.get("executable"):
            continue
        profile = message["profile"]
        assert profile["opt_level"] == str(level), message
        assert profile["debug_assertions"] and profile["overflow_checks"], message
        name = message["target"]["name"]
        executable = Path(message["executable"])
        build.setdefault("artifacts", {})[name] = {
            "profile": profile, "sha256": hashlib.sha256(executable.read_bytes()).hexdigest()}
        if name in targets:
            executables[name] = str(executable)
    assert set(executables) == set(targets), executables
    assert "fwp" in build["artifacts"], build
    build["optimizationLevel"] = level
    report["builds"].append(build); save()
    profiles[level] = (env, executables)

for sample, level in enumerate([0, 1, 0, 1, 1, 0]):
    env, executables = profiles[level]
    warmup = sample < 2
    row = {"optimizationLevel": level, "warmup": warmup, "targets": []}
    for target in targets:
        result, _ = measured([executables[target], "--nocapture"], env, f"sample-{sample}-{level}-{target}")
        row["targets"].append({"target": target, **result})
    row["wallSeconds"] = sum(item["wallSeconds"] for item in row["targets"])
    row["childCpuSeconds"] = sum(item["childCpuSeconds"] for item in row["targets"])
    report["samples"].append(row); save()
report["status"] = "All selected tests pass in both profiles; compiler/harness artifacts retain debug and overflow checks"
save()
