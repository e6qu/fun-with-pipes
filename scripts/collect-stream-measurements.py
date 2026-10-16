#!/usr/bin/env python3
"""Retain queued stream-storage measurements and lifetime checks from passing CI.

This reads artifacts and logs; it does not build or execute downloaded programs.
The measured path excludes sockets, connection pooling and whole-call timing.
"""
import argparse
import csv
import hashlib
import json
from pathlib import Path
import re
import subprocess


def gh(*args):
    return subprocess.check_output(["gh", *args, "--repo", "e6qu/fun-with-pipes"])


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
    run = json.loads(gh("run", "view", args.run, "--json", "headSha,status,conclusion,jobs,url"))
    assert run["headSha"] == args.head and run["status"] == "completed" and run["conclusion"] == "success"
    jobs = [job for job in run["jobs"] if job["conclusion"] != "skipped"]
    assert jobs and all(job["status"] == "completed" and job["conclusion"] == "success" for job in jobs)
    hosts = []
    required_tests = [
        "cached_positions_release_the_source_after_end_and_last_early_owner",
        "cached_error_ends_release_sources_and_failed_reads_keep_them",
        "cached_stream_positions_preserve_values_and_report_storage",
        "incoming_stream_descriptions_outlive_their_input_text",
        "forced_cells_release_received_storage_and_decoder_failure_text",
        "every_kind_of_call",
        "concurrent_reads_share_one_receive_and_cancel_independently",
        "recursive_and_cancelled_waiters_preserve_the_active_reader",
        "stream_aliases_are_consistent_across_tasks",
    ]
    for job in jobs:
        match = re.fullmatch(r"paths \(([^)]+)\)", job["name"])
        assert match, job["name"]
        host = match[1]
        folder = args.artifacts / ("stream-storage-" + host)
        if not folder.exists():
            subprocess.run(["gh", "run", "download", args.run, "--repo", "e6qu/fun-with-pipes",
                            "--name", folder.name, "--dir", str(folder)], check=True)
        assert (folder / "source.txt").read_text().strip() == args.head
        log_path = folder / "job.log"
        if not log_path.exists():
            log_path.write_bytes(subprocess.check_output([
                "gh", "api", "--allow-escape-sequences",
                f"repos/e6qu/fun-with-pipes/actions/jobs/{job['databaseId']}/logs"]))
        log = re.sub(r"\x1b\[[0-?]*[ -/]*[@-~]", "", log_path.read_text())
        for test in required_tests:
            assert re.search(r"test (?:[\w]+::)*" + test + r" \.\.\. ok", log), (host, test)
        with (folder / "storage.tsv").open() as source:
            rows = [{key: int(value) for key, value in row.items()}
                    for row in csv.DictReader(source, delimiter="\t")]
        assert len(rows) == 9 and {(r["elements"], r["mode"]) for r in rows} == {
            (count, mode) for count in [1, 32, 128] for mode in [0, 1, 2]}
        for row in rows:
            expected = (row["elements"] + 1) // 2 if row["mode"] == 1 else row["elements"]
            assert row["consumed"] == expected and row["collections"] == 0
            assert row["queued_messages"] == row["elements"] - expected
            assert row["receive_requests"] == 4 * expected and row["receive_bytes"] == 89 * expected
            assert row["after_clearing_roots_charged_bytes"] == row["after_read_charged_bytes"]
        with (folder / "layout.tsv").open() as source:
            layout = list(csv.DictReader(source, delimiter="\t"))
        assert {item["type"] for item in layout} == {"cell", "incoming"}
        for item in layout:
            assert int(item["bytes"]) % int(item["alignment"]) == 0
        names = ["source.txt", "rust.txt", "c.txt", "cpu.txt", "storage.tsv", "layout.tsv", "stream.c", "description.c",
                 "stream-O1.exe", "stream-O2.exe", "description-O1.exe", "description-O2.exe",
                 "readers.c", "readers-O1.exe", "readers-O2.exe", "shared-client.exe",
                 "shared-server.exe", "shared-client.fwp", "shared-server.fwp", "service-build.txt", "job.log"]
        hosts.append({"host": host, "job_url": job["url"], "rows": rows, "layout": layout,
                      "environment": {name: (folder / (name + ".txt")).read_text() for name in ["rust", "c", "cpu"]},
                      "files": {name: fingerprint(folder / name) for name in names},
                      "binary_observations": json.loads((folder / "binary-observations.json").read_text())
                      if (folder / "binary-observations.json").exists() else None})
    report = {
        "source_revision": args.head, "run_url": run["url"],
        "workload": "Receive queued protobuf messages with 16-character strings; 1/32/128 values, full/half consumption and retained first positions. Read each position twice.",
        "results": "Four managed requests and 89 requested bytes per received value. Completed cells no longer retain incoming sources. Native cached storage still needs explicit owners and is not released merely by clearing C references with collection disabled.",
        "limits": "This is fwp representation and lifetime evidence, not a C/Rust comparison or timing benchmark. Excludes socket I/O, pooled connections, raw codec buffers and total process memory. Native services still require tracing.",
        "checks": required_tests,
        "modes": {"0": "consume all", "1": "consume ceil(elements/2)", "2": "consume all while retaining the first position"},
        "hosts": hosts,
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, indent=2) + "\n")
    print(f"Retained {len(hosts)} passing host(s) at {args.head}; native cache ownership remains unfinished")


if __name__ == "__main__":
    main()
