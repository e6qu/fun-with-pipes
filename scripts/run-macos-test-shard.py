#!/usr/bin/env python3
"""Partition Cargo's test targets across the two required macOS jobs."""

import argparse
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parent.parent
SHARDS = {"regular": 0, "gc": 1}
UNIT_TARGETS = {"lib", "bin", "example", "bench"}
# The GC job also runs the full stress golden suite. In Intel run 38550733670,
# REST and examples took 458s and 297s; put them in the shorter regular job.
# Keep the other assignments unchanged, and never duplicate or omit a target.
REGULAR_TARGETS = {"rest", "examples"}


def command(metadata, shard):
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
    selected = [name for index, name in enumerate(sorted(names))
                if (0 if name in REGULAR_TARGETS else index % len(SHARDS))
                == SHARDS[shard]]
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
    args, all_targets, selected = command(metadata, options.shard)
    print(f"macOS {options.shard}: {len(selected)}/{len(all_targets)} "
          "integration targets", flush=True)
    print("\n".join(selected), flush=True)
    print("Command: " + " ".join(args), flush=True)
    subprocess.run(args, cwd=ROOT, check=True)


if __name__ == "__main__":
    main()
