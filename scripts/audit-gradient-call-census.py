#!/usr/bin/env python3
"""Audit gradient storage counts; retain the original corrected-call comparison."""

import argparse
import gzip
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import subprocess
import sys
import zipfile

sys.path.insert(0, str(Path("scripts").resolve()))
SPEC = importlib.util.spec_from_file_location(
    "census", Path("scripts/check-owned-numeric-census.py")
)
CENSUS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(CENSUS)
STACK_SPEC = importlib.util.spec_from_file_location(
    "pair_stack", Path("scripts/check-packed-pair-stack.py")
)
STACK = importlib.util.module_from_spec(STACK_SPEC)
STACK_SPEC.loader.exec_module(STACK)
parser = argparse.ArgumentParser(
    description="Audit frozen gradient counts and retain observations without executing saved images."
)
for name in ("input", "artifact", "job", "job-log", "recorded-checkout", "output"):
    parser.add_argument("--" + name, type=Path, required=True)
parser.add_argument("--comparison", choices=("gradient-call", "packed-pair", "scalar-constant", "recording-lookup", 'recording-inline', 'recording-capacity'), required=True)
parser.add_argument("--source", required=True)
parser.add_argument("--run", type=int, required=True)
parser.add_argument("--machine", choices=("aarch64", "x86_64"), required=True)
args = parser.parse_args()
ROOT = args.output
ROOT.mkdir(parents=True, exist_ok=False)
SOURCE = args.source
assert re.fullmatch("[0-9a-f]{40}", SOURCE)
assert (
    subprocess.check_output(
        ["git", "-C", str(args.recorded_checkout), "rev-parse", "HEAD"], text=True
    ).strip()
    == SOURCE
)
subprocess.run(
    ["git", "-C", str(args.recorded_checkout), "diff", "--quiet", "HEAD"],
    check=True,
)
CASES = (
    (3, 0, 32768),
    (3, 1, 512),
    (3, 199, 32),
    (3, 1999, 4),
    (33, 199, 32),
    (129, 199, 8),
)


def digest(raw):
    return hashlib.sha256(raw).hexdigest()


machine = args.machine
host = machine
elf = {"aarch64": 183, "x86_64": 62}[machine]
artifact = json.loads(args.artifact.read_text())
assert (
    artifact["name"]
    == args.comparison + "-census-" + {"aarch64": "ARM64", "x86_64": "X64"}[machine]
    and not artifact["expired"]
    and artifact["workflow_run"]["id"] == args.run
    and artifact["workflow_run"]["head_sha"] == SOURCE
)
with args.input.open("rb") as stream:
    assert (
        artifact["digest"]
        == "sha256:" + hashlib.file_digest(stream, "sha256").hexdigest()
    )
job = json.loads(args.job.read_text())
assert (
    job["name"]
    == "numeric_input_analysis ("
    + {"aarch64": "ubuntu-24.04-arm", "x86_64": "ubuntu-latest"}[machine]
    + ")"
    and job["head_sha"] == SOURCE
    and job["run_id"] == args.run
    and job["conclusion"] == ("failure" if args.comparison == "gradient-call" else "success")
)
failed_steps = [step["name"] for step in job["steps"] if step["conclusion"] == "failure"]
assert failed_steps == (["Verify fresh-solve savings and their exact phase attribution"]
                        if args.comparison == "gradient-call" else [])
log = gzip.decompress(args.job_log.read_bytes())
clean = re.sub(rb"\x1b\[[0-?]*[ -/]*[@-~]", b"", log)
uploaded = {int(value) for value in re.findall(
    rb"Artifact " + re.escape(artifact["name"].encode())
    + rb" successfully finalized\. Artifact ID ([0-9]+)", clean)}
assert uploaded == {artifact["id"]}, "artifact is not the one finalized by this job"
diagnostics = [
    line.decode(errors="replace")
    for line in clean.splitlines()
    if re.search(
        rb"\bwarning:|\berror:(?!:)|\berror\[|Traceback|##\[error\]|test result: FAILED",
        line,
        re.I,
    )
]
if args.comparison == "gradient-call":
    assert (len(diagnostics) == 3 and sum("Traceback" in line for line in diagnostics) == 2
            and "##[error]Process completed with exit code 1." in diagnostics[-1]), diagnostics
else:
    assert not diagnostics, diagnostics
reference_module, transformation = {
    "gradient-call": (CENSUS.GRADIENT_REFERENCE, "scoped input borrowing, numeric fold fields, single-root seeding and consumed array scratch"),
    "packed-pair": (CENSUS.PAIR_REFERENCE, "reuse of the consumed private neighboring-record buffer"),
    "scalar-constant": (CENSUS.SCALAR_REFERENCE, "exact immediate scalar constants and acyclic cached aliases"),
    "recording-lookup": (CENSUS.RECORDING_REFERENCE, "validated tape lookup reuse within bounded nonsuspending numeric workers"),
    "recording-inline": (CENSUS.INLINE_REFERENCE, "forced inlining of the checked F64 scalar append body"),
    "recording-capacity": (CENSUS.CAPACITY_REFERENCE, "inlined checked reserve gate with shared tape growth"),
}[args.comparison]
with zipfile.ZipFile(args.input) as z:
    report = json.loads(z.read("numeric-analysis/report.json"))
    assert (
        report["source"] == SOURCE
        and report["comparison"] == args.comparison
        and report["complete"]
        and report["machine"] == machine
    )
    assert report["settings"] == {
        "FWP_AD_WORKSPACE": "1",
        "FWP_LTO": "0",
        "FWP_VRET": "1",
        "FWP_FRAME_FIELDS": "1",
        "FWP_PACKED_ARRAYS": "1",
        "FWP_STACK": "1",
        "FWP_ARRAY_FUSION": "1",
    }
    stack = None
    # Historical protocols predate this gate. The recorded source determines
    # whether it is mandatory; a missing report never selects the old protocol.
    stack_required = args.comparison in ("packed-pair", "scalar-constant", "recording-lookup", 'recording-inline', 'recording-capacity') and (
        args.recorded_checkout / "scripts/check-packed-pair-stack.py"
    ).is_file()
    if stack_required:
        step, = [row for row in job["steps"] if row["name"] ==
                 "Check complete-program stack costs before allocation and timing gates"]
        assert step["conclusion"] == "success"
        stack = STACK.audit(
            {name.removeprefix("pair-stack/"): z.read(name) for name in z.namelist()
             if name.startswith("pair-stack/") and not name.endswith("/")},
            SOURCE, machine, dict(candidate=report["compilerSha256"],
                                  reference=report["referenceManifest"]["compilerSha256"]),
        )
    else:
        assert not any(name.startswith("pair-stack/") for name in z.namelist())
    assert len(report["commands"]) == (171 if args.comparison in ("recording-lookup", "recording-inline", 'recording-capacity') else 99) and all(
        c["returncode"] == 0 for c in report["commands"]
    )
    assert len(report["cases"]) == 12
    compilations = [
        row["command"] for row in report["commands"] if "-std=gnu11" in row["command"]
    ]
    assert len(compilations) == (48 if args.comparison in ("recording-lookup", "recording-inline", 'recording-capacity') else 24)
    flags = {
        "-O2",
        "-std=gnu11",
        "-fno-fast-math",
        "-ffp-contract=off",
        "-UFWP_NO_REUSE",
        "-fstack-usage",
        "-march=" + {"aarch64": "armv8-a", "x86_64": "x86-64"}[machine],
    }
    assert all(
        Path(command[0]).name == "gcc" and flags <= set(command)
        for command in compilations
    )
    summaries = {}
    verified_executions = 0
    manifest = json.loads(z.read("numeric-analysis-reference/manifest.json"))
    assert manifest == report["referenceManifest"] and manifest["source"] == SOURCE
    assert (
        set(manifest["candidate"])
        == set(manifest["reference"])
        == set(reference_module.EDITS)
    )
    assert (
        manifest["disabledTransformation"]
        == transformation
    )
    assert (
        digest(z.read("numeric-analysis-reference/fwp")) == manifest["compilerSha256"]
    )
    assert (
        digest(z.read("numeric-analysis-reference/reference.patch"))
        == manifest["patchSha256"]
    )
    expected = reference_module.reference_sources(
        {name: Path(name).read_text() for name in reference_module.EDITS}
    )
    assert set(manifest["unchanged"]) == set(reference_module.PRESERVED)
    for name, checksum in manifest["unchanged"].items():
        assert digest(Path(name).read_bytes()) == checksum
    for name, source in expected.items():
        assert digest(Path(name).read_bytes()) == manifest["candidate"][name]
        assert z.read("numeric-analysis-reference/source/" + name) == source.encode()
        assert digest(source.encode()) == manifest["reference"][name]
    safety = json.loads(z.read("numeric-analysis-safety/run.json"))
    assert safety["conclusion"] == "success"
    for name in ("src", "runtime", "lib", "tests", "Cargo.toml", "Cargo.lock", "build.rs"):
        assert subprocess.check_output(["git", "rev-parse", safety["head_sha"] + ":" + name]) == subprocess.check_output(["git", "rev-parse", SOURCE + ":" + name]), name
    pages = json.loads(z.read("numeric-analysis-safety/jobs.json"))
    expected_jobs = {
        "gradient_call_checks (ubuntu-24.04-arm, gcc)",
        "gradient_call_checks (ubuntu-latest, gcc)",
        "gradient_call_checks (macos-15, clang)",
    }
    jobs = [
        job for page in pages for job in page["jobs"] if job["name"] in expected_jobs
    ]
    assert len(jobs) == 3 and {job["name"] for job in jobs} == expected_jobs
    assert all(
        job["head_sha"] == safety["head_sha"] and job["conclusion"] == "success" for job in jobs
    )
    for name in ("cc", "rustc", "cpu"):
        assert z.read("numeric-analysis/" + name + ".stdout") and not z.read(
            "numeric-analysis/" + name + ".stderr"
        )
    for n, u, solves in CASES:
        for form in ("current", "history"):
            name = f"{n}-{u}-{form}"
            folder = "numeric-analysis/" + name + "/"
            row = report["cases"][name]
            assert (row["dimensions"], row["updates"], row["solves"]) == (n, u, solves)
            assert z.read(
                folder + "input.fwp"
            ).decode() == CENSUS.DESCENT.BASELINE.repeat_source(
                CENSUS.DESCENT.AD.program(n, u + 1, form == "history"), "fwp", solves
            )
            observations = {}
            for kind in ("candidate", "reference"):
                source = z.read(folder + kind + ".c").decode()
                if args.comparison == "recording-inline":
                    CENSUS.DESCENT.RECORDING_SELECTION.check_inline_declaration(source, kind == "candidate")
                if args.comparison == "recording-capacity":
                    CENSUS.DESCENT.RECORDING_SELECTION.check_capacity_gate(source, kind == "candidate")
                if args.comparison in ("recording-lookup", "recording-inline", 'recording-capacity') and u > 0:
                    CENSUS.DESCENT.RECORDING_SELECTION.check(source, kind == "candidate" or args.comparison in ('recording-inline', 'recording-capacity'))
                if args.comparison == "scalar-constant" and u > 0:
                    CENSUS.DESCENT.SCALAR_SELECTION.check(source, "literal" if kind == "candidate" else "cached")
                if args.comparison in ("recording-lookup", "recording-inline", 'recording-capacity'):
                    assert z.read(folder + kind + "-lookup.c").decode() == CENSUS.DESCENT.RECORDING_SELECTION.instrument(source)
                    image = z.read(folder + kind + "-lookup")
                    assert image[:6] == b"\x7fELF\x02\x01" and int.from_bytes(image[18:20], "little") == elf
                    assert not z.read(folder + kind + "-lookup-compile.stdout")
                    assert not z.read(folder + kind + "-lookup-compile.stderr")
                    for workspace in ("0", "1"):
                        stem = folder + kind + "-lookup-workspace" + workspace
                        CENSUS.DESCENT.verify(z.read(stem + ".stdout"), CENSUS.DESCENT.AD.analytic(n, u + 1), solves)
                        verified_executions += 1
                        counts = json.loads(z.read(stem + ".stderr"))
                        CENSUS.DESCENT.RECORDING_SELECTION.check_counts(counts, n, u, solves, kind == "candidate" or args.comparison in ('recording-inline', 'recording-capacity'))
                        assert counts == row["lookupObservations"][kind][workspace]
                assert z.read(
                    folder + kind + "-profile.c"
                ).decode() == CENSUS.DESCENT.AD.RAW.instrument(
                    CENSUS.DESCENT.AD.PROFILE.instrument(source)
                )
                image = z.read(folder + kind + "-profile")
                assert (
                    image[:6] == b"\x7fELF\x02\x01"
                    and int.from_bytes(image[18:20], "little") == elf
                )
                assert digest(image) == row[kind + "Sha256"]
                for stage in ("emit", "compile"):
                    assert not z.read(folder + kind + "-" + stage + ".stderr")
                    assert not z.read(folder + kind + "-" + stage + ".stdout")
                for workspace in ("0", "1"):
                    stem = folder + kind + "-workspace" + workspace
                    CENSUS.DESCENT.verify(
                        z.read(stem + ".stdout"),
                        CENSUS.DESCENT.AD.analytic(n, u + 1),
                        solves,
                    )
                    verified_executions += 1
                    managed, raw = [
                        json.loads(line)
                        for line in z.read(stem + ".stderr").splitlines()
                    ]
                    raw = raw["rawDerivativeStorage"]
                    assert managed["finalChargedBytes"] == raw["finalBytes"] == 0
                    CENSUS.DESCENT.AD.RAW.check_profile(
                        raw, u * solves, workspace == "1"
                    )
                    observations[kind + workspace] = dict(managed=managed, raw=raw)
                    assert (
                        observations[kind + workspace]
                        == row["observations"][kind + workspace]
                    )
                assert (
                    observations[kind + "0"]["managed"]
                    == observations[kind + "1"]["managed"]
                )
            expected = dict(
                requests=7 * u * solves + int(u > 0),
                requestedBytes=(8 * n + 128) * u * solves + 24 * int(u > 0),
                retains=2 * u * solves,
            )
            if args.comparison == "packed-pair":
                expected = dict(requests=u * solves, requestedBytes=(16 * n - 8) * u * solves, retains=0)
            elif args.comparison in ("scalar-constant", "recording-lookup", 'recording-inline', 'recording-capacity'):
                expected = dict(requests=0, requestedBytes=0, retains=0)
            for workspace in ("0", "1"):
                old, new = (
                    observations["reference" + workspace],
                    observations["candidate" + workspace],
                )
                assert (
                    {key: old["managed"][key] - new["managed"][key] for key in expected}
                    == expected
                    == row["savings"][workspace]
                )
                assert new["managed"]["retains"] <= old["managed"]["retains"]
                assert (
                    new["managed"]["peakChargedBytes"]
                    <= old["managed"]["peakChargedBytes"]
                )
                assert new["raw"] == old["raw"]
                if not u:
                    assert new == old
            summaries[name] = dict(
                solves=solves,
                savings=expected,
                candidate=observations["candidate1"]["managed"],
                reference=observations["reference1"]["managed"],
                rawPeakBytes=observations["candidate1"]["raw"]["peakBytes"],
                finalRawBytes=0,
            )
            if args.comparison in ("recording-lookup", "recording-inline", 'recording-capacity'):
                summaries[name]["recordingChecks"] = {
                    kind: row["lookupObservations"][kind]["1"]
                    for kind in ("candidate", "reference")
                }
    summary_spec = importlib.util.spec_from_file_location(
        "summary",
        args.recorded_checkout / "scripts/summarize-derivative-forward-costs.py",
    )
    summary = importlib.util.module_from_spec(summary_spec)
    summary_spec.loader.exec_module(summary)
    baseline = json.loads(gzip.decompress(z.read("fresh-baseline.json.gz")))
    for name in ("reference", "candidate"):
        archive = ROOT / (host + "-fresh-" + name + ".zip")
        archive.write_bytes(z.read("fresh-" + name + ".zip"))
    reference = summary.audit(
        ROOT / (host + "-fresh-reference.zip"), SOURCE, machine, "baseline", None
    )
    assert reference == baseline["hosts"][machine]
    assert reference["compilerSha256"] == manifest["compilerSha256"]
    fresh = summary.audit(
        ROOT / (host + "-fresh-candidate.zip"),
        SOURCE,
        machine,
        args.comparison,
        baseline,
    )
    assert fresh == json.loads(gzip.decompress(z.read("fresh-audit.json.gz")))
    assert fresh["compilerSha256"] == report["compilerSha256"]
    if args.comparison == "gradient-call":
        assert len(fresh["comparisonFailures"]) == 80 and all(
            "/outside: saving" in line or "/forwardWithRecording: saving" in line
            for line in fresh["comparisonFailures"]), fresh["comparisonFailures"]
        current_spec = importlib.util.spec_from_file_location(
            "current_measure", Path("scripts/measure-derivative-forward-costs.py"))
        current = importlib.util.module_from_spec(current_spec)
        current_spec.loader.exec_module(current)
        with zipfile.ZipFile(ROOT / (host + "-fresh-candidate.zip")) as saved:
            original_report = json.loads(saved.read("report.json"))
        corrected = current.comparison_failures(original_report, baseline, "gradient-call")
        assert not corrected, corrected
    else:
        assert not fresh["comparisonFailures"], fresh["comparisonFailures"]
        corrected = []
        if args.comparison == "recording-capacity":
            parent = Path("docs/measurements/recording-inline-census-2026-11-06") / machine / "audit"
            parent_repeated = json.loads((parent / (machine + "-verified.json")).read_text())
            parent_fresh = json.loads(gzip.decompress((parent / (machine + "-fresh-verified.json.gz")).read_bytes()))
        elif args.comparison == "recording-inline":
            parent = Path("docs/measurements/recording-lookup-census-2026-11-06") / machine / "audit"
            parent_repeated = json.loads((parent / (machine + "-verified.json")).read_text())
            parent_fresh = json.loads(gzip.decompress((parent / (machine + "-fresh-verified.json.gz")).read_bytes()))
        elif args.comparison == "recording-lookup":
            parent = Path("docs/measurements/scalar-constant-census-2026-11-05") / machine / "audit"
            parent_repeated = json.loads((parent / (machine + "-verified.json")).read_text())
            parent_fresh = json.loads(gzip.decompress((parent / (machine + "-fresh-verified.json.gz")).read_bytes()))
        elif args.comparison == "scalar-constant":
            parent = Path("docs/measurements/packed-pair-cleanup-census-2026-11-05") / machine / "audit"
            parent_repeated = json.loads(gzip.decompress((parent / (machine + "-verified.json.gz")).read_bytes()))
            parent_fresh = json.loads(gzip.decompress((parent / (machine + "-fresh-verified.json.gz")).read_bytes()))
        else:
            prefix = "arm" if machine == "aarch64" else "amd"
            parent = Path("docs/measurements/gradient-call-census-2026-11-05")
            parent_repeated = json.loads((parent / (prefix + "-verified.json")).read_text())
            parent_fresh = json.loads(gzip.decompress((parent / (prefix + "-fresh-verified.json.gz")).read_bytes()))
        reconciliation = CENSUS.reconcile_parent(report, reference, parent_repeated, parent_fresh)
        assert reconciliation == json.loads(z.read("parent-reconciliation.json"))
        (ROOT / "parent-reconciliation.json").write_text(json.dumps(reconciliation, indent=2) + "\n")
    inventory = {}
    with zipfile.ZipFile(ROOT / "observations.zip", "w", zipfile.ZIP_DEFLATED) as retained:
        for name in z.namelist():
            if name.endswith("/"):
                continue
            data = z.read(name)
            key = "original/" + name
            assert key not in inventory, ("duplicate artifact member", key)
            inventory[key] = digest(data)
            if name.endswith((".json", ".json.gz", ".stdout", ".stderr", ".status", ".log", ".fwp", ".su", ".patch", ".txt")):
                retained.writestr(key, data)
        for kind in ("reference", "candidate"):
            with zipfile.ZipFile(ROOT / (host + "-fresh-" + kind + ".zip")) as saved:
                for name in saved.namelist():
                    if name.endswith("/"):
                        continue
                    data = saved.read(name)
                    key = "fresh-" + kind + "/" + name
                    assert key not in inventory, ("duplicate fresh member", key)
                    inventory[key] = digest(data)
                    if name.endswith((".json", ".stdout", ".stderr", ".status", ".log", ".fwp", ".su", ".txt")):
                        retained.writestr(key, data)
    with zipfile.ZipFile(ROOT / "observations.zip") as retained:
        assert len(retained.namelist()) == len(set(retained.namelist()))
        for name in retained.namelist():
            assert digest(retained.read(name)) == inventory[name], name
    (ROOT / "inventory.json.gz").write_bytes(gzip.compress((json.dumps(inventory, indent=2) + "\n").encode(), mtime=0))
    (ROOT / (host + "-fresh-verified.json.gz")).write_bytes(
        gzip.compress((json.dumps(fresh, indent=2) + "\n").encode(), mtime=0)
    )
    (ROOT / (host + "-fresh-baseline.json.gz")).write_bytes(
        gzip.compress((json.dumps(baseline, indent=2) + "\n").encode(), mtime=0)
    )
    receipt = dict(
        source=SOURCE,
        run=args.run,
        machine=machine,
        allDiagnosticsAudited=True,
        recordedAttributionFailures=fresh["comparisonFailures"],
        correctedComparisonFailures=corrected,
        checkerSha256=digest(
            Path("scripts/measure-derivative-forward-costs.py").read_bytes()
        ),
        recordedCheckerSha256=digest(
            (
                args.recorded_checkout / "scripts/measure-derivative-forward-costs.py"
            ).read_bytes()
        ),
        artifact=artifact,
        freshCases=24,
        freshNativeImages=164,
        verifiedCommands=len(report["commands"]),
        nativeImages=len(compilations),
        verifiedExecutions=verified_executions,
        cases=summaries,
        completeProgramStack=stack,
    )
    (ROOT / f"{host}-verified.json").write_text(json.dumps(receipt, indent=2) + "\n")
    print(
        host,
        f"{len(summaries)} cases, {verified_executions} executions, "
        f"{len(compilations)} native images and exact reference verified",
        flush=True,
    )
    print(
        "Fresh counts: 24 cases per compiler, both workspace settings, 164 images; phase budgets pass",
        flush=True,
    )
