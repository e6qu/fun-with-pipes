#!/usr/bin/env python3
"""Run all native Cargo test targets or one explicit macOS shard."""

import argparse
from concurrent.futures import ThreadPoolExecutor
import json
from pathlib import Path
import subprocess
import sys
import time

ROOT = Path(__file__).resolve().parent.parent
SHARDS = {"regular": 0, "gc": 1}
UNIT_TARGETS = {"lib", "bin", "example", "bench"}
# Every integration target has an explicit assignment. Adding a target must not
# reshuffle unrelated work or consume the GC job's separate stress allowance.
SCHEDULE = ROOT / "scripts/macos-test-shards.json"


def assignment(path):
    schedule = json.loads(path.read_text())
    if set(schedule) != set(SHARDS):
        raise ValueError("schedule must contain exactly regular and gc")
    for shard, names in schedule.items():
        if not isinstance(names, list) or not names or any(
                not isinstance(name, str) or not name for name in names):
            raise ValueError(f"invalid target list for {shard}")
    names = schedule["regular"] + schedule["gc"]
    if len(names) != len(set(names)):
        raise ValueError("duplicate target in macOS schedule")
    return schedule


def command(metadata, shard, schedule):
    packages = [package for package in metadata["packages"]
                if Path(package["manifest_path"]).resolve() == ROOT / "Cargo.toml"]
    if len(packages) != 1:
        raise ValueError("expected exactly one root package in Cargo metadata")
    targets = packages[0]["targets"]
    names = []
    for target in targets:
        kinds = target["kind"]
        if kinds == ["test"]:
            names.append(target["name"])
        elif kinds == ["custom-build"]:
            # Cargo runs build scripts as dependencies of each selected target.
            continue
        elif len(kinds) != 1 or kinds[0] not in UNIT_TARGETS:
            raise ValueError(f"unassigned Cargo target: {target['name']} {kinds}")
    if not names or len(names) != len(set(names)):
        raise ValueError("expected nonempty, unique integration test targets")
    assigned = schedule["regular"] + schedule["gc"]
    if len(assigned) != len(set(assigned)):
        raise ValueError("duplicate target in macOS schedule")
    missing, obsolete = set(names) - set(assigned), set(assigned) - set(names)
    if missing or obsolete:
        raise ValueError(f"update scripts/macos-test-shards.json: "
                         f"unassigned={sorted(missing)}, obsolete={sorted(obsolete)}")
    selected = sorted(names) if shard == "all" else list(schedule[shard])
    if not selected:
        raise ValueError(f"empty integration test shard: {shard}")
    args = ["cargo", "test", "--no-fail-fast"]
    if shard == "all":
        # Linux retains Cargo's complete target selection and every stress test.
        args += ["--all-targets", "--"]
    else:
        # Mac unit, example and benchmark targets run once in the regular job.
        if shard == "regular":
            args += ["--lib", "--bins", "--examples", "--benches"]
        for name in selected:
            args += ["--test", name]
        # The Mac GC job runs this test separately before its shard.
        args += ["--", "--skip", "golden_programs_under_gc_stress"]
    return args, sorted(names), selected


def test_executables(output, metadata, shard, selected):
    package = next(package for package in metadata["packages"]
                   if Path(package["manifest_path"]).resolve() == ROOT / "Cargo.toml")
    expected = {(target["kind"][0], target["name"]) for target in package["targets"]
                if (target["kind"] == ["test"] and target["name"] in selected)
                or (shard in {"regular", "all"} and len(target["kind"]) == 1
                    and target["kind"][0] in UNIT_TARGETS)}
    executables = {}
    for line in output.splitlines():
        message = json.loads(line)
        if message.get("reason") == "compiler-message":
            rendered = message["message"].get("rendered")
            if rendered:
                print(rendered, file=sys.stderr, end="")
        if (message.get("reason") != "compiler-artifact"
                or message.get("package_id") != package["id"]
                or not message["profile"]["test"] or not message.get("executable")):
            continue
        target = message["target"]
        key = (target["kind"][0], target["name"])
        if len(target["kind"]) != 1 or key not in expected or key in executables:
            raise ValueError(f"unexpected or duplicate test executable: {key}")
        executables[key] = message["executable"]
    if set(executables) != expected:
        raise ValueError(f"missing test executables: {sorted(expected - set(executables))}")
    if len(set(executables.values())) != len(executables):
        raise ValueError("test targets share an executable path")
    order = {name: index for index, name in enumerate(selected)}
    return sorted(executables.items(), key=lambda item:
                  (1, order[item[0][1]]) if item[0][0] == "test" else (0, *item[0]))


def run_tests(executables, test_args, logs):
    logs.mkdir(parents=True, exist_ok=True)

    def run(item):
        (kind, name), executable = item
        log = logs / f"{kind}-{name}.log"
        started = time.monotonic()
        print(f"Starting {kind}/{name}; log: {log}", flush=True)
        # Two executable workers, each with one harness thread. Individual tests
        # keep their existing internal parallelism (for example golden programs).
        with log.open("wb") as output:
            result = subprocess.run([executable, "--test-threads=1", *test_args],
                                    cwd=ROOT, stdout=output, stderr=subprocess.STDOUT)
        print(f"Finished {kind}/{name}: exit {result.returncode}, "
              f"{time.monotonic() - started:.2f}s", flush=True)
        print(log.read_text(errors="replace"), end="", flush=True)
        return result.returncode

    with ThreadPoolExecutor(max_workers=2) as workers:
        codes = list(workers.map(run, executables))
    return 1 if any(codes) else 0


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    selection = parser.add_mutually_exclusive_group(required=True)
    selection.add_argument("--shard", choices=SHARDS)
    selection.add_argument("--all", action="store_true")
    parser.add_argument("--logs", type=Path, required=True)
    options = parser.parse_args()
    metadata = json.loads(subprocess.check_output(
        ["cargo", "metadata", "--no-deps", "--format-version", "1"], cwd=ROOT))
    selected_group = "all" if options.all else options.shard
    args, all_targets, selected = command(metadata, selected_group, assignment(SCHEDULE))
    print(f"Native {selected_group}: {len(selected)}/{len(all_targets)} "
          "integration targets", flush=True)
    print("\n".join(selected), flush=True)
    split = args.index("--")
    build_args = args[:split] + ["--no-run", "--message-format=json"]
    print("Build: " + " ".join(build_args), flush=True)
    built = subprocess.run(build_args, cwd=ROOT, stdout=subprocess.PIPE, text=True)
    if built.returncode:
        print(built.stdout, end="", file=sys.stderr)
        built.check_returncode()
    executables = test_executables(built.stdout, metadata, selected_group, selected)
    return run_tests(executables, args[split + 1:], options.logs)


if __name__ == "__main__":
    sys.exit(main())
