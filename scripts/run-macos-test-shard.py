#!/usr/bin/env python3
"""Partition Cargo's test targets across the two required macOS jobs."""

import argparse
import json
from pathlib import Path
import subprocess

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
    selected = sorted(schedule[shard])
    if not selected:
        raise ValueError(f"empty integration test shard: {shard}")
    args = ["cargo", "test", "--no-fail-fast"]
    # Unit, example and benchmark targets run once in the regular job.
    if shard == "regular":
        args += ["--lib", "--bins", "--examples", "--benches"]
    for name in selected:
        args += ["--test", name]
    # The gc job runs this test separately, exactly once, before its shard.
    args += ["--", "--skip", "golden_programs_under_gc_stress"]
    return args, sorted(names), selected


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--shard", choices=SHARDS, required=True)
    options = parser.parse_args()
    metadata = json.loads(subprocess.check_output(
        ["cargo", "metadata", "--no-deps", "--format-version", "1"], cwd=ROOT))
    args, all_targets, selected = command(metadata, options.shard, assignment(SCHEDULE))
    print(f"macOS {options.shard}: {len(selected)}/{len(all_targets)} "
          "integration targets", flush=True)
    print("\n".join(selected), flush=True)
    print("Command: " + " ".join(args), flush=True)
    subprocess.run(args, cwd=ROOT, check=True)


if __name__ == "__main__":
    main()
