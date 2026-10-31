#!/usr/bin/env python3
"""Check the published scalar borrowed-call limits; make no timing claim."""
import argparse
import base64
import gzip
import hashlib
import importlib.util
import json
from pathlib import Path
import re


ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location(
    "callable_evidence", Path(__file__).with_name("check-returned-callable-evidence.py"))
EVIDENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(EVIDENCE)
BASELINE = "7d7cf98bc62944d6c040293f4d17543c3bb51470"
MACHINES = {"linux-arm": "aarch64", "linux-amd": "x86_64", "mac-arm": "aarch64"}


def baseline(host):
    payload = (ROOT / "docs/measurements/returned-callables-baseline-2026-10-31.json.gz").read_bytes()
    assert hashlib.sha256(payload).hexdigest() == "bd77ee227a214f4466530e1980c0941c05a58da8733f7bcecbf45afdd4167bcc"
    archive = json.loads(gzip.decompress(payload))
    assert archive["source"] == BASELINE
    return json.loads(base64.b64decode(archive["hosts"][host]["files"]["report.json"], validate=True))


def text_bytes(program):
    rows = re.findall(r"^\s*(?:\.text|__text)\s+(\d+)\s+\d+\s*$", program["sections"], re.M)
    assert len(rows) == 1 and int(rows[0]) > 0, "missing or duplicate text section"
    return int(rows[0])


def frame_costs(program):
    frames = program["cFrames"]
    assert frames and all(type(row["bytes"]) is int and row["bytes"] >= 0 for row in frames)
    borrowed = [row for row in frames if re.fullmatch(
        r"fwp_apply_borrowed(?:_span|_prefix)?(?:\..*)?", row["location"].rsplit(":", 1)[-1])]
    assert borrowed, "missing borrowed-application frames"
    return dict(largest=max(row["bytes"] for row in frames),
                borrowedSum=sum(row["bytes"] for row in borrowed), borrowed=borrowed)


def compare(reference, candidate):
    assert reference["source"] == BASELINE
    assert reference["machine"] == candidate["machine"]
    decisions = {}
    for level in (1, 2):
        label = f"fwp-O{level}"
        old, new = reference["programs"][label], candidate["programs"][label]
        old_frames, new_frames = frame_costs(old), frame_costs(new)
        checks = dict(worker=new["code"]["workerDecodedBytes"] * 100 <= old["code"]["workerDecodedBytes"] * 105,
                      text=text_bytes(new) * 100 <= text_bytes(old) * 105,
                      largestFrame=new_frames["largest"] <= old_frames["largest"] + 64,
                      borrowedFrames=new_frames["borrowedSum"] <= old_frames["borrowedSum"] + 64)
        old_phases = reference["programs"][label + "-profile"]["phases"]
        new_phases = candidate["programs"][label + "-profile"]["phases"]
        assert set(old_phases) == set(new_phases) == {"success", "omit-release", "recovery"}
        counts = storage = True
        for case, rows in old_phases.items():
            for before, after in zip(rows, new_phases[case], strict=True):
                assert all(before[key] == after[key] for key in ("kind", "calls", "phase"))
                # Construction/destruction and failure/retry may not add work.
                # Invocation has the stricter zero-count/one-entry requirement.
                for key in EVIDENCE.COLLECT.RESULTS.FIELDS:
                    if after["phase"] == 1 and key in ("retains", "releases", "applications"):
                        continue
                    storage &= after[key] <= before[key]
                if after["phase"] == 1:
                    counts &= (after["retains"] == after["releases"] == 0
                               and after["applications"] == after["calls"])
        checks.update(counts=counts, storage=storage)
        decisions[label] = dict(checks=checks, accepted=all(checks.values()),
                               baselineFrames=old_frames, candidateFrames=new_frames,
                               baselineWorkerBytes=old["code"]["workerDecodedBytes"],
                               candidateWorkerBytes=new["code"]["workerDecodedBytes"],
                               baselineTextBytes=text_bytes(old), candidateTextBytes=text_bytes(new))
    return dict(baseline=BASELINE, source=candidate["source"], levels=decisions,
                accepted=all(row["accepted"] for row in decisions.values()),
                scope="Count, code and reported frame limits only; no timing acceptance or total stack bound.")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--input", type=Path, required=True)
    parser.add_argument("--source", required=True)
    parser.add_argument("--host", choices=MACHINES, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    audit = EVIDENCE.audit(args.input, args.source, MACHINES[args.host])
    result = compare(baseline(args.host), json.loads((args.input / "report.json").read_text()))
    result["evidenceAudit"] = audit
    args.output.write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps({label: row["checks"] for label, row in result["levels"].items()}))
    assert result["accepted"], "scalar borrowed-call budget failed; retained decision contains every limit"


if __name__ == "__main__":
    main()
