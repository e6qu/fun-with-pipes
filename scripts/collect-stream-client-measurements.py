#!/usr/bin/env python3
"""Retain complete remote-client memory measurements from passing native jobs.

Reads CI artifacts and logs; never executes downloaded programs. Counts cover
managed client storage, with raw network buffers and server memory excluded.
"""
import argparse
import csv
import hashlib
import json
from pathlib import Path
import re
import subprocess

REPO = "e6qu/fun-with-pipes"
HOSTS = {"ubuntu-latest", "ubuntu-24.04-arm", "macos-15", "macos-15-intel",
         "windows-2025", "windows-11-arm"}


def fingerprint(path):
    data = path.read_bytes()
    return {"bytes": len(data), "sha256": hashlib.sha256(data).hexdigest()}


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
    assert {job["name"] for job in jobs} == {f"paths ({host})" for host in HOSTS}
    tests = ["remote_stream_client_memory_measurement", "server_startup_deadline_covers_silent_processes"]
    results = []
    for job in jobs:
        assert job["status"] == "completed" and job["conclusion"] == "success"
        host = job["name"][len("paths ("):-1]
        folder = args.artifacts / ("stream-clients-" + host)
        if not folder.exists():
            subprocess.run(["gh", "run", "download", args.run, "--repo", REPO,
                            "--name", folder.name, "--dir", str(folder)], check=True)
        assert (folder / "source.txt").read_text().strip() == args.head
        log_path = folder / "job.log"
        if not log_path.exists():
            log_path.write_bytes(subprocess.check_output([
                "gh", "api", "--allow-escape-sequences",
                f"repos/{REPO}/actions/jobs/{job['databaseId']}/logs"]))
        log = re.sub(r"\x1b\[[0-?]*[ -/]*[@-~]", "", log_path.read_text())
        for test in tests:
            assert re.search(r"test " + test + r" \.\.\. ok", log), (host, test)
        with (folder / "memory.tsv").open() as source:
            rows = []
            for row in csv.DictReader(source, delimiter="\t"):
                rows.append({key: value if key == "mode" else int(value) for key, value in row.items()})
        modes = ["unique", "retained", "partial"]
        sizes = [64, 1024, 16384]
        assert len(rows) == 27
        assert {(r["mode"], r["elements"], r["repetition"]) for r in rows} == {
            (mode, size, repetition) for mode in modes for size in sizes for repetition in range(3)}
        for row in rows:
            assert row["collections"] == 0 and row["requests"] > 0 and row["requested_bytes"] > 0
            assert 0 <= row["final_charged_bytes"] <= row["peak_charged_bytes"]
        ranges = []
        for mode in modes:
            for size in sizes:
                selected = [row for row in rows if (row["mode"], row["elements"]) == (mode, size)]
                ranges.append({"mode": mode, "elements": size, "min_max": {
                    key: [min(row[key] for row in selected), max(row[key] for row in selected)]
                    for key in ["requests", "requested_bytes", "retains", "peak_charged_bytes", "final_charged_bytes"]}})
        suffix = ".exe" if host.startswith("windows-") else ""
        names = ["source.txt", "rust.txt", "c.txt", "cpu.txt", "scope.txt", "memory.tsv", "greeter.fwp", "job.log"]
        for mode in modes:
            names.extend([f"{mode}.fwp", f"{mode}.c", f"{mode}-measured.c", f"{mode}{suffix}", f"{mode}-measured{suffix}"])
        results.append({"host": host, "job_url": job["url"], "rows": rows, "ranges": ranges,
                        "environment": {name: (folder / f"{name}.txt").read_text() for name in ["rust", "c", "cpu"]},
                        "scope": (folder / "scope.txt").read_text(),
                        "files": {name: fingerprint(folder / name) for name in names}})
    report = {
        "source_revision": args.head, "run_url": run["url"], "checks": tests,
        "modes": {"unique": "Sum 1..n in one pass", "retained": "Sum 1..n, retaining the original iterator until rereading its first value", "partial": "Sum only the first 32 values of the requested n"},
        "sampling": "Three separate instrumented client processes per mode and size; raw interpreter and uninstrumented client outputs must agree with the expected sums. No elapsed-time comparison.",
        "limits": "Managed client allocation requests, requested bytes, counted retains and allocator-charged storage. GC disabled; physical freeing enabled. Includes iterator and connection setup, argument parsing and entry cleanup; excludes raw network buffers, allocator metadata/pages, whole-process memory and the interpreted server. Storage is sampled after each managed allocation. Final means before whole-runtime shutdown, not after process exit. Partial-consumption networking may vary with scheduling.",
        "hosts": results,
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, indent=2) + "\n")
    print(f"Retained {len(results)} native client measurements at {args.head}")


if __name__ == "__main__":
    main()
