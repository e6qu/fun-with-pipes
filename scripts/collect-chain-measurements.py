#!/usr/bin/env python3
"""Compare native stack use when releasing the same wrapped ownership chain.

Read passing CI artifacts and logs only; never execute downloaded programs.
Stack addresses are sampled at generated destructor entries. Their span shows
growth, not absolute stack use: zero span does not mean zero stack storage.
Instrumentation can affect frames; these are not timing or process-memory data.
"""
import argparse
import hashlib
import json
from pathlib import Path
import re
import subprocess

HOSTS = {"ubuntu-latest", "ubuntu-24.04-arm", "macos-15", "macos-15-intel",
         "windows-2025", "windows-11-arm"}


def gh(*args):
    return subprocess.check_output(["gh", *args])


def fingerprint(path):
    data = path.read_bytes()
    return {"bytes": len(data), "sha256": hashlib.sha256(data).hexdigest()}


def collect(run_id, head, artifacts, baseline):
    repo = "e6qu/fun-with-pipes"
    run = json.loads(gh("run", "view", run_id, "--repo", repo, "--json",
                        "headSha,status,conclusion,jobs,url"))
    assert run["headSha"] == head and run["status"] == "completed" and run["conclusion"] == "success"
    jobs = [job for job in run["jobs"] if job["conclusion"] != "skipped"]
    hosts = {}
    for job in jobs:
        assert job["status"] == "completed" and job["conclusion"] == "success"
        match = re.fullmatch(r"paths \(([^)]+)\)", job["name"])
        assert match, job["name"]
        host = match[1]
        assert host in HOSTS and host not in hosts
        folder = artifacts / run_id / ("chain-cleanup-" + host)
        if not folder.exists():
            subprocess.run(["gh", "run", "download", run_id, "--repo", repo,
                            "--name", folder.name, "--dir", str(folder)], check=True)
        log = folder / "job.log"
        if not log.exists():
            log.write_bytes(gh("api", "--allow-escape-sequences",
                               f"repos/{repo}/actions/jobs/{job['databaseId']}/logs"))
        assert "test wrapped_chain_cleanup_stack_measurement ... ok" in log.read_text()
        shapes = {}
        for shape in ["optional"] if baseline else ["optional", "tuple"]:
            source = folder if baseline else folder / shape
            if not baseline:
                assert (source / "source.txt").read_text().strip() == head
            rows = []
            for opt in ["-O1", "-O2"]:
                parsed = [[int(field) for field in line.split("\t")]
                          for line in (source / f"stack{opt}.tsv").read_text().splitlines()]
                if baseline:
                    assert len(parsed) == 2 and [row[0] for row in parsed] == [64, 1024]
                    assert parsed[1][1] > parsed[0][1] * 4
                    rows.extend({"optimization": opt, "links": count, "alias_mode": 0,
                                 "stack_span_bytes": span} for count, span in parsed)
                else:
                    modes = range(4 if shape == "optional" else 5)
                    assert {(row[0], row[1]) for row in parsed} == {
                        (count, mode) for count in [64, 1024, 16384] for mode in modes}
                    assert len(parsed) == 3 * len(modes) and all(0 <= row[2] <= 4096 for row in parsed)
                    rows.extend({"optimization": opt, "links": count, "alias_mode": mode,
                                 "stack_span_bytes": span} for count, mode, span in parsed)
            names = ["chain.c", "chain-O1.exe", "chain-O2.exe", "stack-O1.tsv", "stack-O2.tsv"]
            if not baseline:
                names += ["language.c", "language-O1.exe", "language-O2.exe", "source.txt",
                          "rust.txt", "c.txt", "cpu.txt"]
            observations = source / "binary-observations.json"
            shapes[shape] = {
                "rows": rows, "files": {name: fingerprint(source / name) for name in names},
                "environment": None if baseline else {
                    name: (source / (name + ".txt")).read_text() for name in ["rust", "c", "cpu"]},
                "binary_observations": json.loads(observations.read_text()) if observations.exists() else None,
            }
        hosts[host] = {"job_url": job["url"], "log": fingerprint(log), "shapes": shapes}
    assert set(hosts) == HOSTS
    return {"run": run_id, "source": head, "url": run["url"], "hosts": hosts}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ["baseline-run", "baseline-head", "run", "head"]:
        parser.add_argument("--" + name, required=True)
    parser.add_argument("--artifacts", required=True, type=Path)
    parser.add_argument("--output", required=True, type=Path)
    args = parser.parse_args()
    before = collect(args.baseline_run, args.baseline_head, args.artifacts, True)
    after = collect(args.run, args.head, args.artifacts, False)
    comparisons = []
    for host in sorted(HOSTS):
        old = before["hosts"][host]["shapes"]["optional"]["rows"]
        new = after["hosts"][host]["shapes"]["optional"]["rows"]
        for row in old:
            current = next(r for r in new if all(r[k] == row[k] for k in ["optimization", "links", "alias_mode"]))
            assert current["stack_span_bytes"] < row["stack_span_bytes"]
            comparisons.append({"host": host, "optimization": row["optimization"],
                                "links": row["links"], "before_bytes": row["stack_span_bytes"],
                                "after_bytes": current["stack_span_bytes"]})
    report = {
        "workload": "Release a native chain: each record owns a five-byte string and an optional next record.",
        "comparison": "Original fwp recursive destructors versus fwp destruction loops; no C/Rust timing comparison.",
        "scope": "Stack-address span sampled at generated destructor entries, O1/O2. Instrumentation can change frames. Zero span means no address variation, not zero stack use. Excludes construction, process memory and timing.",
        "memory_check": "Every case returns the managed allocation budget to its starting value after the last alias is dropped. Allocation requests during cleanup are not separately counted.",
        "alias_modes": {"0": "unique chain", "1": "retained root", "2": "retained middle record", "3": "retained middle optional wrapper", "4": "retained middle tuple (tuple case only)"},
        "limits": ["The baseline did not capture CPU/compiler metadata separately; its CI logs, generated C and binaries are retained. Do not infer timing improvements.",
                   "Only the optional case has a measured preceding-version comparison. The tuple case extends correctness and stack-scaling coverage.",
                   "These are ordinary typed values; native remote stream caches still need explicit ownership."],
        "before": before, "after": after, "comparisons": comparisons,
    }
    args.output.write_text(json.dumps(report, indent=2) + "\n")
    print("Retained six-host wrapped-chain comparison; remote stream ownership remains unfinished")


if __name__ == "__main__":
    main()
