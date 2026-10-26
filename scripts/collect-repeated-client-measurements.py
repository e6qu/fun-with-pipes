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
    parser.add_argument("--baseline-report", type=Path, help="Compare owned client streams with the untouched repeated-call baseline")
    parser.add_argument("--projection-moves", action="store_true", help="Compare compiler field transfers with the owned-request baseline")
    parser.add_argument("--closed-connections", action="store_true", help="Require connection closure and I/O task draining between calls")
    args = parser.parse_args()
    if args.projection_moves:
        assert args.baseline_report, "projection comparison requires a retained baseline report"
    baseline = json.loads(args.baseline_report.read_text()) if args.baseline_report else None
    assert not (args.closed_connections and args.projection_moves), "select one comparison workload"
    if baseline:
        assert baseline["source_revision"] != args.head
        assert {host["host"] for host in baseline["hosts"]} == HOSTS
        if args.closed_connections:
            assert baseline["connection_lifetime"] == "closed_and_drained"
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
    if args.closed_connections:
        checks[0] = "closed_remote_connection_memory_measurement"
    if baseline or args.closed_connections:
        checks += ["owned_client_streams_release_after_readers_and_senders_finish",
                   "queued_message_allocation_failure_reports_out_of_memory",
                   "every_kind_of_call", "stream_aliases_are_consistent_across_tasks",
                   "calls_are_concurrent"]
    if args.projection_moves:
        checks += ["boxed_projection_transfers_unique_fields_and_preserves_shared_values",
                   "environment_tls_cache_releases_after_task_and_finalizer_teardown",
                   "failed_environment_tls_construction_releases_unpublished_storage"]
    if args.closed_connections and baseline:
        checks += ["task_handles_and_cached_results_have_independent_owners",
                   "fatal_runtime_allocations_report_errors_from_task_stacks",
                   "library_unload_closes_idle_connections_before_draining_tasks",
                   "served_status_messages_release_after_encoding_and_on_cancellation",
                   "encoded_messages_release_on_cancel_and_preserve_plain_and_gzip_frames"]
    output_tables = args.output.parent / args.output.stem
    output_tables.mkdir(parents=True, exist_ok=True)
    results = []
    for job in jobs:
        assert job["status"] == "completed" and job["conclusion"] == "success"
        host = job["name"][len("paths ("):-1]
        folder = args.artifacts / (("closed-clients-" if args.closed_connections else "repeated-clients-") + host)
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
        if args.closed_connections and baseline and not host.startswith("windows-"):
            for check in ["grpc_connection_startup_releases_failed_task_reservations",
                          "grpc_connect_and_handshake_release_pending_resources_on_cancellation"]:
                assert re.search(r"test " + re.escape(check) + r" \.\.\. ok", log), (host, check)
        inventory = json.loads((folder / "primitive-inventory.json").read_text())
        assert inventory["head"] == args.head
        rows = table(folder / "memory.tsv")
        checkpoints = table(folder / "checkpoints.tsv")
        drains = table(folder / "drains.tsv") if args.closed_connections else None
        storage = table(folder / "connection-storage.tsv") if args.closed_connections else None
        drain_summaries = []
        keys = {(mode, batches, repetition) for mode in MODES for batches in BATCHES for repetition in range(3)}
        assert len(rows) == len(keys) == 27
        assert {(r["mode"], r["batches"], r["repetition"]) for r in rows} == keys
        if storage is not None:
            assert len(storage) == len(keys)
            assert {(r["mode"], r["batches"], r["repetition"]) for r in storage} == keys
        summaries = []
        selected_count = 0
        for row in rows:
            assert row["requests"] > 0
            assert 0 <= row["final_charged_bytes"] <= row["peak_charged_bytes"]
            calls = row["batches"] * MODES[row["mode"]]
            assert row["streams_created"] == calls
            for kind in ["connections", "streams"]:
                assert 0 <= row[kind + "_finalized"] <= row[kind + "_created"]
            assert 0 < row["connections_created"] <= calls
            if drains is not None:
                assert row["connections_created"] == calls
                assert row["streams_finalized"] == row["streams_created"]
                assert row["messages_freed"] == row["messages_created"]
                assert row["message_freed_bytes"] == row["message_requested_bytes"]
                allocated = next(s for s in storage if all(s[key] == row[key] for key in ["mode", "batches", "repetition"]))
                assert allocated["connection_charged_bytes"] >= allocated["connection_requested_bytes"] > calls * allocated["connection_header_bytes"]
                assert allocated["io_task_charged_bytes"] >= allocated["io_task_requested_bytes"] == 2 * calls * allocated["task_bytes"]
                drained = [d for d in drains if all(d[key] == row[key] for key in ["mode", "batches", "repetition"])]
                assert len(drained) == calls
                for index, sample in enumerate(drained, 1):
                    assert sample["connections_created"] == sample["connections_closed"] == index
                    assert sample["live_io_tasks"] == sample["unfinalized_streams"] == sample["message_bytes"] == 0
                    assert 0 <= sample["unfinalized_connections"] <= index
                    assert sample["managed_charged_bytes"] >= 0
                assert drained[-1]["managed_charged_bytes"] == row["final_charged_bytes"]
                assert drained[-1]["unfinalized_connections"] == calls - row["connections_finalized"]
                drain_summaries.append({"mode": row["mode"], "batches": row["batches"], "repetition": row["repetition"], "first": drained[0], "last": drained[-1]})
                if baseline:
                    assert row["connections_finalized"] == calls
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
        if drains is not None:
            assert len(drains) == selected_count
            assert "--- exit 213\n" in (folder / "missing-connection-drain.log").read_text()
        comparison = None
        if baseline:
            earlier = next(item for item in baseline["hosts"] if item["host"] == host)
            before = {(r["mode"], r["batches"], r["repetition"]): r for r in earlier["rows"]}
            assert set(before) == keys
            # Require physical release before whole-runtime shutdown, not just
            # unchanged output or eventual collector finalization.
            for row in rows:
                assert row["streams_finalized"] == row["streams_created"], (host, row)
                assert row["messages_freed"] == row["messages_created"], (host, row)
                assert row["message_freed_bytes"] == row["message_requested_bytes"], (host, row)
            comparison = []
            for mode in MODES:
                measured = [row for row in rows if row["mode"] == mode]
                final = {row["final_charged_bytes"] for row in measured}
                assert len(final) == 1, (host, mode, final)
                old_final = [before[(mode, 256, rep)]["final_charged_bytes"] for rep in range(3)]
                if args.projection_moves:
                    assert all(value >= next(iter(final)) for value in old_final)
                    for row in measured:
                        prior = before[(mode, row["batches"], row["repetition"])]
                        assert row["retains"] < prior["retains"], (host, mode, row, prior)
                        assert row["requests"] <= prior["requests"], (host, mode, row, prior)
                else:
                    assert all(value > next(iter(final)) for value in old_final)
                comparison.append({"mode": mode, "remaining_managed_bytes": next(iter(final)),
                    "baseline_remaining_after_256_batches": old_final,
                    "rows": [{"batches": row["batches"], "repetition": row["repetition"],
                        "change_from_baseline": {key: row[key]-before[(mode, row["batches"], row["repetition"])][key]
                            for key in ["requests", "requested_bytes", "retains", "peak_charged_bytes", "final_charged_bytes", "messages_created", "message_requested_bytes"]}}
                        for row in measured]})
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
        raw_drains = None
        if drains is not None:
            drain_destination = output_tables / (host + "-drains.tsv")
            shutil.copyfile(folder / "drains.tsv", drain_destination)
            raw_drains = {"file": str(drain_destination.relative_to(args.output.parent)), **fingerprint(drain_destination)}
            names += ["drains.tsv", "connection-storage.tsv", "missing-connection-drain.log", "missing-connection-drain.c", "missing-connection-drain" + suffix]
        for mode in MODES:
            names += [mode + ext for ext in [".fwp", ".c", "-measured.c", suffix, "-measured" + suffix]]
            names += [f"{mode}-{batches}-{repetition}.log" for batches in BATCHES for repetition in range(3)]
        layouts = []
        if baseline or args.closed_connections:
            for opt in ["-O1", "-O2"]:
                for no_free in ["false", "true"]:
                    layout_name = f"stream-owners/layout{opt}-no-free-{no_free}.tsv"
                    with (folder / layout_name).open() as source:
                        layout_rows = list(csv.DictReader(source, delimiter="\t"))
                    assert len(layout_rows) == 1
                    layout = {key: int(value) for key, value in layout_rows[0].items()}
                    assert layout["stream_bytes"] % layout["stream_alignment"] == 0
                    assert layout["raw_offset"] < layout["abandoned_offset"] < layout["stream_bytes"]
                    layouts.append({"optimization": opt, "physical_freeing": no_free == "false", **layout})
                    names += [layout_name, f"stream-owners/streams{opt}-no-free-{no_free}.exe"]
            names += [f"stream-owners/streams-no-free-{no_free}.c" for no_free in ["false", "true"]]
        if args.closed_connections and baseline:
            names += [f"task-owners/{memory}-unique{opt}{extension}"
                      for memory in ["arc", "tracing"]
                      for opt in ["-O1", "-O2"] for extension in [".c", ".exe"]]
        observations = folder / "binary-observations.json"
        if observations.exists():
            names.append(observations.name)
        results.append({"host": host, "job_url": job["url"], "rows": rows,
            "checkpoint_summaries": summaries, "comparison": comparison, "request_layouts": layouts,
            "drain_summaries": drain_summaries, "raw_drains": raw_drains,
            "connection_storage_allocations": storage,
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
        "sampling": "1, 16 or 256 batches in one process; three separate measured processes per case, after raw interpreter and uninstrumented native output agreement. Checkpoints precede each new request-stream allocation. Counters start after constant initialization. Final counters follow root execution, joining its child tasks and cached-value cleanup, before whole-runtime shutdown. Reusable connections and detached I/O tasks are still live at this point.",
        "limits": "Collection disabled, physical freeing enabled. Managed allocations and counted retains plus connection/stream object and queued-message counts. Message requested bytes include the header and trailing byte. Other raw buffers, allocator/TLS/OS storage, server/process memory and timing excluded. Partial-read queue occupancy can vary with network/task scheduling. This is an ownership baseline, not a bounded-memory, zero-cost or C/Rust parity claim.",
        "hosts": results}
    if baseline:
        report["baseline"] = {"file": args.baseline_report.name,
                              "source_revision": baseline["source_revision"],
                              "run_url": baseline["run_url"], **fingerprint(args.baseline_report)}
        report["limits"] = ("Collection disabled, physical freeing enabled. Compared with the retained repeated-call baseline using the same source programs, input sizes and output checks. Managed allocation/count totals and explicit request/message releases are measured before whole-runtime shutdown. Constant final managed charge is required in every measured mode and size, as is release of all created streams and queued messages. Reusable connections and detached I/O tasks remain live at the final sampling point; their remaining storage is not a demonstrated leak. Partial readers can avoid constructing later messages once abandoned, so message-construction work can differ. Other raw buffers, allocator/TLS/OS storage, server/process memory and timing are excluded. Connections and retained callback graphs still require tracing; these cases do not establish unlimited-call bounds, checked ARC, zero-cost abstractions or C/Rust parity.")
    if args.projection_moves:
        report["comparison_kind"] = "compiler transfer of the only counted field from a consumed boxed record"
        report["limits"] += " This compiler comparison requires fewer retains in every measured case without extra allocation requests or higher final managed storage; shared records keep their existing owners. Dynamic dispatch, record allocations and ownership tests remain."
    if args.closed_connections:
        report["connection_lifetime"] = "closed_and_drained"
        report["sampling"] = "1, 16 or 256 batches, three measured processes per case. Native-only hooks close each connection and drain its reader/writer tasks before the next call and before final sampling. Every drain requires one closed socket per created connection, no pooled connection, no live I/O task and no remaining request/message. Managed charge and unfinalized connection counts are sampled at each drain. Counters start after constant initialization and end after root execution, child joins, cached-value cleanup and the final drain, before runtime shutdown."
        report["limits"] = "Collection disabled, physical freeing enabled. Raw interpretation and ordinary native output are functional references using their usual connection pooling; their transport work differs from this instrumented churn workload. Ownership revision comparisons must use the same connection-closing hooks. Managed allocation/retain counts, charged storage, connection/request finalization and queued-message bytes are measured. Empty I/O task lists establish completed task execution, not reclaimed task-object storage. Stack pools, other raw buffers, allocator/TLS/OS storage, server/process memory and timing are excluded. This establishes a closed-connection ownership baseline, not zero-cost abstractions, checked ARC or C/Rust parity."
        if baseline:
            report["limits"] += " The comparison additionally requires every created connection finalized and constant final managed charge across measured sizes."
    args.output.write_text(json.dumps(report, indent=2) + "\n")
    print(f"Retained six native repeated-call measurements at {args.head}")


if __name__ == "__main__":
    main()
