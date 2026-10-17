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
    parser.add_argument("--baseline-report", type=Path, help="Compare owned-cache results with a retained six-host baseline report")
    parser.add_argument("--capture-moves", action="store_true", help="Require capture-transfer controls and retain their per-case counts")
    args = parser.parse_args()
    assert not args.capture_moves or args.baseline_report, "capture comparison requires its measured baseline"
    run = json.loads(subprocess.check_output([
        "gh", "run", "view", args.run, "--repo", REPO,
        "--json", "headSha,status,conclusion,jobs,url"]))
    assert run["headSha"] == args.head and run["status"] == "completed" and run["conclusion"] == "success"
    jobs = [job for job in run["jobs"] if job["conclusion"] != "skipped"]
    assert {job["name"] for job in jobs} == {f"paths ({host})" for host in HOSTS}
    tests = ["remote_stream_client_memory_measurement", "server_startup_deadline_covers_silent_processes"]
    if args.baseline_report:
        tests += ["cache_owners_release_aliases_and_long_chains_without_collection",
                  "decoder_callbacks_transfer_values_and_restore_handlers_after_traps",
                  "forced_cells_release_received_storage_and_decoder_failure_text",
                  "cached_stream_positions_preserve_values_and_report_storage",
                  "incoming_stream_descriptions_outlive_their_input_text",
                  "concurrent_reads_share_one_receive_and_cancel_independently",
                  "canonical_encoding_scratch_releases_on_partial_and_transcoder_failure",
                  "canonical_decoding_scratch_releases_on_malformed_values_and_allocation_traps"]
    if args.capture_moves:
        tests += ["unique_closure_captures_move_through_partial_calls_and_failures",
                  "partial_duplicate_failures_preserve_aliases_and_pending_owned_arguments",
                  "failed_calls_reclaim_function_storage_without_collection",
                  "closure_aliases_and_captures_under_stress",
                  "overapplication_releases_pending_arguments_without_counting_scalars"]
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
        cleanup = None
        if args.baseline_report:
            names += ["primitive-inventory.json", "cache-owners.c", "cache-owners-O1.exe",
                      "cache-owners-O2.exe", "cache-owners-O1.tsv", "cache-owners-O2.tsv"]
            inventory = json.loads((folder / "primitive-inventory.json").read_text())
            assert inventory["head"] == args.head
            assert "grpc._force" in inventory["changedContractSymbols"]
            cleanup = []
            for opt in ["-O1", "-O2"]:
                parsed = [[int(field) for field in line.split("\t")]
                          for line in (folder / f"cache-owners{opt}.tsv").read_text().splitlines()]
                assert len(parsed) == 21
                assert {(r[0], r[1]) for r in parsed} == {(n, mode) for n in sizes for mode in range(7)}
                assert all(r[2] == 4*r[0]+2 and 0 <= r[3] <= 4096 for r in parsed)
                cleanup.extend({"optimization": opt, "positions": n, "alias_mode": mode,
                                "releases": freed, "stack_span_bytes": span}
                               for n, mode, freed, span in parsed)
        captures = None
        if args.capture_moves:
            names += ["capture-moves/captures.c", "capture-moves/language.c", "capture-moves/source.fwp"]
            captures = []
            for opt in ["-O1", "-O2"]:
                names += [f"capture-moves/captures{opt}.exe", f"capture-moves/captures{opt}.tsv"]
                parsed = [[int(field) for field in line.split("\t")]
                          for line in (folder / f"capture-moves/captures{opt}.tsv").read_text().splitlines()]
                assert len(parsed) == 12 and {r[0] for r in parsed} == set(range(12))
                for mode, partial_retains, entry_retains, remaining in parsed:
                    shared, partial, failure = mode % 2, (mode % 4) // 2, mode // 4
                    assert partial_retains == (1 if partial and shared else 0)
                    assert entry_retains == (2 if not partial and shared else 0)
                    assert remaining == 0
                    captures.append({"optimization": opt, "mode": mode, "shared": bool(shared),
                        "partial_application": bool(partial), "exit": ["return", "error", "trap"][failure],
                        "partial_capture_retains": partial_retains, "entry_capture_retains": entry_retains,
                        "remaining_managed_bytes": remaining})
        observations = folder / "binary-observations.json"
        if observations.exists():
            names.append(observations.name)
        results.append({"host": host, "job_url": job["url"], "rows": rows, "ranges": ranges,
                        "environment": {name: (folder / f"{name}.txt").read_text() for name in ["rust", "c", "cpu"]},
                        "scope": (folder / "scope.txt").read_text(),
                        "cache_cleanup": cleanup,
                        "capture_transfers": captures,
                        "binary_observations": json.loads(observations.read_text()) if observations.exists() else None,
                        "files": {name: fingerprint(folder / name) for name in names}})
    report = {
        "source_revision": args.head, "run_url": run["url"], "checks": tests,
        "modes": {"unique": "Sum 1..n in one pass", "retained": "Sum 1..n, retaining the original iterator until rereading its first value", "partial": "Sum only the first 32 values of the requested n"},
        "sampling": "Three separate instrumented client processes per mode and size; raw interpreter and uninstrumented client outputs must agree with the expected sums. No elapsed-time comparison.",
        "limits": "Managed client allocation requests, requested bytes, counted retains and allocator-charged storage. GC disabled; physical freeing enabled. Includes iterator and connection setup, argument parsing and entry cleanup; excludes raw network buffers, allocator metadata/pages, whole-process memory and the interpreted server. Storage is sampled after each managed allocation. Final means before whole-runtime shutdown, not after process exit. Partial-consumption networking may vary with scheduling.",
        "hosts": results,
    }
    if args.baseline_report:
        baseline = json.loads(args.baseline_report.read_text())
        old_hosts = {host["host"]: host for host in baseline["hosts"]}
        assert set(old_hosts) == HOSTS and len(old_hosts) == len(baseline["hosts"])
        comparisons = []
        for host in results:
            old_rows = {(row["mode"], row["elements"], row["repetition"]): row
                        for row in old_hosts[host["host"]]["rows"]}
            assert len(old_rows) == 27
            for row in host["rows"]:
                key = row["mode"], row["elements"], row["repetition"]
                old = old_rows[key]
                comparisons.append({"host": host["host"], "mode": key[0], "elements": key[1],
                    "repetition": key[2], "before": old, "after": row})
            for mode in ["unique", "retained", "partial"]:
                final = [row["final_charged_bytes"] for row in host["rows"] if row["mode"] == mode]
                assert len(set(final)) == 1, (host["host"], mode, "final managed storage grows or varies", final)
            peak = [row["peak_charged_bytes"] for row in host["rows"] if row["mode"] == "unique"]
            assert len(set(peak)) == 1, (host["host"], "one-pass managed peak grows or varies", peak)
        report["comparison"] = {"baseline_source": baseline["source_revision"],
            "baseline_run": baseline["run_url"], "baseline_report": fingerprint(args.baseline_report),
            "scope": ("Same native fwp clients before and after "
                + ("moving unique closure captures" if args.capture_moves else "typed cache ownership")
                + ", with three separate processes per case. Final managed charge must be constant across the three sizes in each mode; unique one-pass peak must also be constant. Retained histories may grow until released. These checks do not bound raw networking buffers or establish runtime speed."),
            "samples": comparisons}
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, indent=2) + "\n")
    print(f"Retained {len(results)} native client measurements at {args.head}")


if __name__ == "__main__":
    main()
