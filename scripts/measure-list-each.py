#!/usr/bin/env python3
"""Compare old and current list each on Linux GitHub runners."""

import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import statistics
import subprocess
import time

ROOT = Path(__file__).resolve().parent.parent
SIZES = (10_000, 100_000, 1_000_000)
REPEATS = 8
OLD = "each-before : (a -> () ! e) -> List[a] -> () ! e\neach-before = map | flip compose ignore\n"


def run(command, env):
    result = subprocess.run(list(map(str, command)), cwd=ROOT, env=env,
                            text=True, capture_output=True, check=True)
    return result.stdout


def fingerprint(path):
    return {"bytes": path.stat().st_size,
            "sha256": hashlib.sha256(path.read_bytes()).hexdigest()}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--compiler", required=True, type=Path)
    parser.add_argument("--output", required=True, type=Path)
    args = parser.parse_args()
    assert os.environ.get("GITHUB_ACTIONS") == "true", "timing runs belong on CI"
    assert platform.system() == "Linux", "measurements require native Linux and GNU time"
    env = dict(os.environ, LC_ALL="C")
    env.pop("FWP_NO_OPT", None)
    compiler = args.compiler.resolve()
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=True)
    programs = {}
    rows = []
    for size in SIZES:
        expected = f"{size}\n"
        for label, function in [("map", "each-before"), ("fold", "each")]:
            stem = f"{label}-{size}"
            source = out / f"{stem}.fwp"
            source.write_text(OLD + f"main = range 0 {size} | run-state 0 ({function} (const (add 1) | modify)) | .1 | echo\n")
            cfile, binary = out / f"{stem}.c", out / stem
            generate = [str(compiler), "build", "-O2", "--emit-c", str(source), "-o", str(cfile)]
            started = time.perf_counter_ns()
            run(generate, env)
            generate_ns = time.perf_counter_ns() - started
            command = [os.environ["CC"], "-O2", "-std=gnu11", "-ffp-contract=off", "-w", str(cfile), "-o", str(binary), "-lm", "-lpthread"]
            started = time.perf_counter_ns()
            run(command, env)
            build_ns = time.perf_counter_ns() - started
            assert run([binary], env) == expected, stem
            programs[stem] = {"source": fingerprint(source), "generated_c": fingerprint(cfile),
                              "binary": fingerprint(binary), "build_command": command,
                              "generate_command": generate, "generate_wall_ns": generate_ns,
                              "c_build_wall_ns": build_ns, "expected_stdout": expected}
        samples = {"map": [], "fold": []}
        order = []
        for repeat in range(REPEATS):
            pair = ("map", "fold") if repeat % 2 == 0 else ("fold", "map")
            for label in pair:
                stem = f"{label}-{size}"
                resource_file = out / f"{stem}-sample-{repeat}.json"
                command = ["/usr/bin/time", "-f",
                           '{"user_seconds":%U,"system_seconds":%S,"peak_rss_kib":%M}',
                           "-o", resource_file, out / stem]
                started = time.perf_counter_ns()
                actual = run(command, env)
                elapsed = time.perf_counter_ns() - started
                assert actual == expected, (stem, actual)
                sample = json.loads(resource_file.read_text())
                sample["process_wall_ns"] = elapsed
                samples[label].append(sample)
                order.append(label)
        medians = {label: statistics.median(s["process_wall_ns"] for s in values)
                   for label, values in samples.items()}
        ratio = medians["fold"] / medians["map"]
        rows.append({"elements": size, "run_order": order, "samples": samples,
                     "median_wall_ns": medians, "fold_over_map_ratio": ratio,
                     "fold_extra_time_percent": 100 * (ratio - 1)})
        print(f"{size} elements: fold/map median wall ratio {ratio:.3f}, "
              f"extra time {100 * (ratio - 1):+.1f}%", flush=True)
    report = {
        "source_revision": run(["git", "rev-parse", "HEAD"], env).strip(),
        "comparison": "Current fold-based list each versus its previous map-based definition, built by the same compiler with -O2. Both express the same integer range, update an integer state once per element and print its length. Current State-range fusion can eliminate the fold program's input list; this comparison includes that saving as well as eliminating the discarded result list. It does not isolate the cost of changing the library definition alone. Counted owners release remaining storage at last use.",
        "timing_scope": "Whole process including input construction, state updates, output and teardown, plus the same GNU time launcher. One unrecorded warmup per binary; eight recorded samples, alternating implementation order equally. Compilation is timed separately, once per binary: fwp startup/C generation and C compilation are recorded separately with their exact commands.",
        "limits": "Comparison between fwp implementations, not C/Rust parity. No timing assertion from these noisy samples. Peak RSS includes the whole native process; GNU time rounds CPU times. Allocation counts are measured separately by state_sequence_ownership at 32/128 elements; these uninstrumented binaries contain no allocation counters.",
        "environment": {"host": platform.uname()._asdict(),
                        "cpu": run(["lscpu"], env),
                        "c_compiler": run([os.environ["CC"], "--version"], env),
                        "rust_compiler": run(["rustc", "--version", "--verbose"], env),
                        "time": run(["/usr/bin/time", "--version"], env)},
        "runtime_settings": {key: value for key, value in env.items() if key.startswith("FWP_")},
        "compiler_binary": fingerprint(compiler), "programs": programs, "rows": rows,
    }
    (out / "timings.json").write_text(json.dumps(report, indent=2) + "\n")


if __name__ == "__main__":
    main()
