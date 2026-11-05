"""Summarize saved derivative phase observations; never execute a benchmark."""
import argparse
import gzip
import hashlib
import json
from pathlib import Path
import statistics


parser = argparse.ArgumentParser()
parser.add_argument("--report", type=Path, action="append", required=True)
parser.add_argument("--case", required=True)
args = parser.parse_args()
rows = []
for path in args.report:
    raw = path.read_bytes()
    report = json.loads(gzip.decompress(raw))
    case = report["results"][args.case]
    for label in ("fwp-ad", "fwp-ad-history"):
        observations = case["phaseObservations"][label]["observations"]
        measured = [row for row in observations
                    if row["phase"] == "sample" and row["variant"] == "diagnostic"]
        phases = [row["profile"]["derivativePhases"] for row in measured]
        assert phases and all(row["status"] == 0 for row in measured)
        counts = [{key: phase[key] for key in ("updates", "inputs", "nodes")}
                  for phase in phases]
        assert all(count == counts[0] for count in counts)
        shares = {
            key: statistics.median(phase["nanoseconds"][key]
                                   / sum(phase["nanoseconds"].values()) * 100
                                   for phase in phases)
            for key in phases[0]["nanoseconds"]
        }
        rows.append(dict(report=str(path), reportSha256=hashlib.sha256(raw).hexdigest(),
                         source=report["source"], case=args.case, program=label,
                         samples=len(measured), counts=counts[0],
                         medianPercentOfDerivativePhases=shares,
                         medianForwardPercentOfInstrumentedProcess=statistics.median(
                             row["profile"]["derivativePhases"]["nanoseconds"]["forwardWithRecording"]
                             / row["elapsedNs"] * 100 for row in measured)))
print(json.dumps(rows, indent=2))
