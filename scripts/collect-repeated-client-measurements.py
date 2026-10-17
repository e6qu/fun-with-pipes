#!/usr/bin/env python3
"""Retain repeated-call memory evidence from six passing native jobs.

Requires exact source identities and complete output/control checks. Downloads
artifacts and reads tables; never executes a downloaded program. Checkpoint TSVs
are copied beside the report so raw per-call samples remain available in Git.
"""
import argparse
import csv
import hashlib
import json
from pathlib import Path
import re
import shutil
import subprocess

REPO = "e6qu/fun-with-pipes"
HOSTS = {"ubuntu-latest", "ubuntu-24.04-arm", "macos-15", "macos-15-intel",
         "windows-2025", "windows-11-arm"}
MODES = {"full": 1, "partial": 1, "retained": 2}
BATCHES = [1, 16, 256]


def fingerprint(path):
    data = path.read_bytes()
    return {"bytes": len(data), "sha256": hashlib.sha256(data).hexdigest()}


def table(path):
    with path.open() as source:
        return [{key: value if key == "mode" else int(value) for key, value in row.items()}
                for row in csv.DictReader(source, delimiter="\t")]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--run", required=True)
    parser.add_argument("--head", required=True)
    parser.add_argument("--artifacts", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    run = json.loads(subprocess.check_output([
        "gh", "run", "view", args.run, "--repo", REPO,
        "--json", "headSha,status,conclusion,jobs,url"]))
    assert run["headSha"] == args.head and run["status"] == "completed" and run["conclusion"] == "success"
    jobs = [job for job in run["jobs"] if job["conclusion"] != "skipped"]
    assert len(jobs) == 6 and {job["name"] for job in jobs} == {f"paths ({host})" for host in HOSTS}
    checks = ["repeated_remote_call_memory_measurement", "server_startup_deadline_covers_silent_processes",
              "unique_closure_captures_move_through_partial_calls_and_failures",
              "cache_owners_release_aliases_and_long_chains_without_collection",
              "decoder_callbacks_transfer_values_and_restore_handlers_after_traps"]
    output_tables = args.output.parent / args.output.stem
    output_tables.mkdir(parents=True, exist_ok=True)
    results = []
    for job in jobs:
        assert job["status"] == "completed" and job["conclusion"] == "success"
        host = job["name"][len("paths ("):-1]
        folder = args.artifacts / ("repeated-clients-" + host)
        if not folder.exists():
            subprocess.run(["gh", "run", "download", args.run, "--repo", REPO,
                            "--name", folder.name, "--dir", str(folder)], check=True)
        assert (folder / "source.txt").read_text().strip() == args.head
        log_path = folder / "job.log"
        if not log_path.exists():
            log_path.write_bytes(subprocess.check_output([
                "gh", "api", "--allow-escape-sequences",
                f"repos/{REPO}/actions/jobs/{job['databaseId']}/logs"]))
        log = log_path.read_text()
        for check in checks:
            assert re.search(r"test " + re.escape(check) + r" \.\.\. ok", log), (host, check)
        inventory = json.loads((folder / "primitive-inventory.json").read_text())
        assert inventory["head"] == args.head
        rows = table(folder / "memory.tsv")
        checkpoints = table(folder / "checkpoints.tsv")
        keys = {(mode, batches, repetition) for mode in MODES for batches in BATCHES for repetition in range(3)}
        assert len(rows) == len(keys) == 27
        assert {(r["mode"], r["batches"], r["repetition"]) for r in rows} == keys
        summaries = []
        selected_count = 0
        for row in rows:
            assert row["collections"] == 0 and row["requests"] > 0
            assert 0 <= row["final_charged_bytes"] <= row["peak_charged_bytes"]
            calls = row["batches"] * MODES[row["mode"]]
            assert row["streams_created"] == calls
            for kind in ["connections", "streams"]:
                assert 0 <= row[kind + "_finalized"] <= row[kind + "_created"]
            assert 0 < row["connections_created"] <= calls
            assert 0 <= row["messages_freed"] <= row["messages_created"]
            assert 0 <= row["message_freed_bytes"] <= row["message_requested_bytes"]
            assert row["peak_message_bytes"] >= row["message_requested_bytes"] - row["message_freed_bytes"]
            if row["mode"] != "partial":
                assert row["messages_created"] == row["messages_freed"] == 64 * calls
                assert row["message_requested_bytes"] == row["message_freed_bytes"]
            group = [c for c in checkpoints if all(c[key] == row[key] for key in ["mode", "batches", "repetition"])]
            assert len(group) == calls and [c["prior_streams"] for c in group] == list(range(calls))
            assert all(all(value >= 0 for key, value in c.items() if key != "mode") for c in group)
            selected_count += len(group)
            summaries.append({"mode": row["mode"], "batches": row["batches"], "repetition": row["repetition"],
                "first": group[0], "last": group[-1], "min_max": {
                    key: [min(c[key] for c in group), max(c[key] for c in group)]
                    for key in ["managed_charged_bytes", "message_bytes", "live_connections", "live_streams"]}})
        assert selected_count == len(checkpoints)
        control = (folder / "missing-message-release.log").read_text()
        fields = [line[len("transport-memory\t"):] for line in control.splitlines() if line.startswith("transport-memory\t")]
        assert len(fields) == 1
        counts = [int(value) for value in fields[0].split("\t")]
        assert len(counts) == 9 and counts[4] > counts[5] and counts[6] > counts[7]
        destination = output_tables / (host + "-checkpoints.tsv")
        shutil.copyfile(folder / "checkpoints.tsv", destination)
        suffix = ".exe" if host.startswith("windows-") else ""
        names = ["source.txt", "rust.txt", "c.txt", "cpu.txt", "scope.txt", "memory.tsv", "checkpoints.tsv",
                 "greeter.fwp", "job.log", "primitive-inventory.json", "missing-message-release.log",
                 "missing-message-release.c", "missing-message-release" + suffix]
        for mode in MODES:
            names += [mode + ext for ext in [".fwp", ".c", "-measured.c", suffix, "-measured" + suffix]]
            names += [f"{mode}-{batches}-{repetition}.log" for batches in BATCHES for repetition in range(3)]
        observations = folder / "binary-observations.json"
        if observations.exists():
            names.append(observations.name)
        results.append({"host": host, "job_url": job["url"], "rows": rows,
            "checkpoint_summaries": summaries,
            "raw_checkpoints": {"file": str(destination.relative_to(args.output.parent)), **fingerprint(destination)},
            "environment": {name: (folder / (name + ".txt")).read_text() for name in ["rust", "c", "cpu"]},
            "scope": (folder / "scope.txt").read_text(),
            "missing_release_control": counts,
            "binary_observations": json.loads(observations.read_text()) if observations.exists() else None,
            "files": {name: fingerprint(folder / name) for name in names}})
    report = {"source_revision": args.head, "run_url": run["url"], "checks": checks,
        "modes": {"full": "One call per batch, sum 1..64 (2080)",
                  "partial": "One call per batch, sum first 32 of 64 (528)",
                  "retained": "Two calls per batch; sum both 1..64 streams and reread the first value of the initial retained iterator (4161)"},
        "sampling": "1, 16 or 256 batches in one process; three separate measured processes per case, after raw interpreter and uninstrumented native output agreement. Checkpoints precede each new request-stream allocation. Final counters follow entry/task cleanup, before whole-runtime shutdown.",
        "limits": "Collection disabled, physical freeing enabled. Managed allocations and counted retains plus connection/stream object and queued-message counts. Message requested bytes include the header and trailing byte. Other raw buffers, allocator/TLS/OS storage, server/process memory and timing excluded. Partial-read queue occupancy can vary with network/task scheduling. This is an ownership baseline, not a bounded-memory, zero-cost or C/Rust parity claim.",
        "hosts": results}
    args.output.write_text(json.dumps(report, indent=2) + "\n")
    print(f"Retained six native repeated-call measurements at {args.head}")


if __name__ == "__main__":
    main()
