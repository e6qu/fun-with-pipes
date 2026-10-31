#!/usr/bin/env python3
"""Native closure phase timings with same-source fwp and identical-copy controls."""
import argparse
import importlib.util
import json
import os
from pathlib import Path
import platform
import resource
import shutil
import statistics
import subprocess
import time

from process_wait import run_capture

ROOT = Path(__file__).resolve().parent.parent
PEERS = ("c", "rust", "swift", "reference", "fwp")
LABELS = tuple(peer + suffix for peer in PEERS for suffix in ("", "-copy"))
PHASES = ("construction", "invocation", "release", "process")
ROUNDS = 20
INPUT = (4096, 256, 16)
COPY_LIMIT = 1.02
MIN_PHASE_NS = 5_000_000
FAST_PATH = "if (first && !fi->owned->drop_arguments && n == fi->arity - c->n) {"


def load(name):
    spec = importlib.util.spec_from_file_location(name, ROOT / "scripts" / (name + ".py"))
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


SOURCE = load("returned-callable-source")
RESULTS = load("returned-callable-results")
BINARY = load("measure-swift-peers")


def reference(code):
    # The reference is not an older compiler: disable only this branch.
    return SOURCE.replace_once(code, FAST_PATH, "if (0) {")


def order(round_number):
    return [LABELS[(i + round_number) % 10] for i in (0, 1, 9, 2, 8, 3, 7, 4, 6, 5)]


def parse_output(stdout, kind):
    parts = stdout.split()
    assert len(parts) == 4 and all(part.isdecimal() for part in parts), stdout
    checksum, *durations = map(int, parts)
    population, cycles, passes = INPUT
    expected = (kind + 1) * cycles * (passes * (population * (population - 1) // 2 + 7 * population)
                                    + population * passes * (passes - 1) // 2)
    assert checksum == expected and all(value > 0 for value in durations)
    return dict(zip(PHASES[:3], durations, strict=True))


def summarize(samples):
    assert len(samples) == ROUNDS * len(LABELS)
    values = {phase: {label: [] for label in LABELS} for phase in PHASES}
    for i, row in enumerate(samples):
        round_number, position = divmod(i, len(LABELS))
        assert (row["round"], row["position"], row["label"]) == (round_number, position, order(round_number)[position])
        assert set(row["ns"]) == set(PHASES)
        for phase, value in row["ns"].items():
            assert type(value) is int and value > 0
            values[phase][row["label"]].append(value)
        assert sum(row["ns"][phase] for phase in PHASES[:3]) <= row["ns"]["process"]
    result = {}
    for phase, rows in values.items():
        medians = {label: statistics.median(durations) for label, durations in rows.items()}
        copies = {peer: max(medians[peer], medians[peer + "-copy"]) / min(medians[peer], medians[peer + "-copy"])
                  for peer in PEERS}
        # Candidate assessment depends on its own two implementations, not noisy
        # nanosecond C destruction. Peer comparisons retain independent controls.
        qualified = (all(copies[peer] <= COPY_LIMIT for peer in ("reference", "fwp"))
                     and all(medians[label] >= MIN_PHASE_NS for label in ("reference", "reference-copy", "fwp", "fwp-copy")))
        ratios = {peer: medians["fwp"] / medians[peer] for peer in PEERS[:-1]}
        result[phase] = dict(medianNs=medians, copyRatios=copies, candidateQualified=qualified,
                             fwpOverPeer=ratios,
                             withinBudget=(ratios["reference"] <= (0.95 if phase == "invocation" else 1.02)) if qualified else None,
                             peerQualified={peer: copies[peer] <= COPY_LIMIT and copies["fwp"] <= COPY_LIMIT
                                            and all(medians[label] >= MIN_PHASE_NS for label in (peer, peer + "-copy", "fwp", "fwp-copy"))
                                            for peer in PEERS[:-1]})
    return result


def collect(args):
    assert os.environ.get("GITHUB_ACTIONS") == "true"
    assert platform.system() == "Linux" and platform.machine() == args.arch
    assert args.source == os.environ["GITHUB_SHA"]
    assert subprocess.check_output(["git", "rev-parse", "HEAD"], cwd=ROOT, text=True).strip() == args.source
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    resource.setrlimit(resource.RLIMIT_CORE, (0, 0))
    env = {k: v for k, v in os.environ.items() if not k.startswith("FWP_") and k not in ("GH_TOKEN", "GITHUB_TOKEN")}
    env.update(CC=args.cc, FWP_STACK="1", FWP_LTO="0", LC_ALL="C", SWIFT_BACKTRACE="enable=no")
    commands = []

    def run(argv, status=0, stderr=""):
        argv = list(map(str, argv))
        start = time.perf_counter_ns()
        try:
            result = run_capture(argv, timeout=180, env=env, cwd=None, input_data=None, input_stream=None,
                                 text=True, encoding="utf-8", check=False)
        except subprocess.TimeoutExpired as error:
            (out / "timeout.json").write_text(json.dumps(dict(argv=argv, timeoutSeconds=180,
                stdout=repr(error.stdout), stderr=repr(error.stderr))) + "\n")
            raise
        row = dict(argv=argv, status=result.returncode, stdout=result.stdout, stderr=result.stderr,
                   elapsedNs=time.perf_counter_ns() - start)
        commands.append(row)
        with (out / "commands.jsonl").open("a") as log:
            log.write(json.dumps(row) + "\n")
        assert result.returncode == status and (stderr is None or result.stderr == stderr), row
        return len(commands) - 1

    def build(argv):
        index = run(argv)
        assert not commands[index]["stdout"]
        return index

    def output(argv):
        return commands[run(argv)]["stdout"]

    fixtures = out / "fixtures"
    fixtures.mkdir()
    for pattern in ("returned_callable_*", "callable_phase_clock.*"):
        for path in sorted((ROOT / "tests/fixtures").glob(pattern)):
            shutil.copyfile(path, fixtures / path.name)
    c_arch = {"x86_64": "x86-64", "aarch64": "armv8-a"}[args.arch]
    rust_cpu = {"x86_64": "x86-64", "aarch64": "generic"}[args.arch]
    target = args.arch + "-unknown-linux-gnu"
    cflags = ["-O2", "-std=gnu11", "-ffp-contract=off", "-fno-fast-math", "-fno-lto", "-march=" + c_arch,
              "-I", str(fixtures)]
    swiftflags = ["-swift-version", "6", "-O", "-whole-module-optimization", "-warnings-as-errors", "-target", target]
    report = dict(source=args.source, architecture=args.arch, session=args.session, root=str(out),
                  host=platform.uname()._asdict(), cpu=output(["lscpu"]),
                  versions={name: output([getattr(args, name), "--version"]) for name in ("cc", "rustc", "swiftc", "time", "objdump")},
                  settings=dict(cFlags=cflags, swiftFlags=swiftflags, rustCpu=rust_cpu, target=target,
                                input=INPUT, rounds=ROUNDS, copyLimit=COPY_LIMIT, minimumPhaseNs=MIN_PHASE_NS),
                  builds={}, binaries={}, controls={}, cases={})

    def save():
        (out / "report.json").write_text(json.dumps(report, indent=2) + "\n")

    generated = out / "generated.c"
    build([args.compiler.resolve(), "build", "--fn", "callable-values", "--memory", "dynamic", "--emit-c", "-O2",
           fixtures / "returned_callable_peer.fwp", "-o", generated])
    ordinary = SOURCE.boundary(generated.read_text())
    clock = out / "clock.o"
    build([args.cc, *cflags, "-Wall", "-Wextra", "-Werror", "-c", fixtures / "callable_phase_clock.c", "-o", clock])
    for peer in PEERS:
        folder = out / peer
        folder.mkdir()
        binary = folder / "program"
        fwp = peer in ("reference", "fwp")
        if peer == "swift":
            obj = folder / "ReturnedCallable.o"
            build([args.swiftc, *swiftflags, "-parse-as-library", "-module-name", "ReturnedCallable", "-emit-module",
                   "-emit-module-path", folder / "ReturnedCallable.swiftmodule", "-emit-object",
                   fixtures / "returned_callable_peer.swift", "-o", obj])
            report["builds"][peer] = build([args.swiftc, *swiftflags, "-I", folder, "-import-objc-header",
                  fixtures / "callable_phase_clock.h", fixtures / "returned_callable_time.swift", obj, clock, "-o", binary])
        else:
            obj = folder / "implementation.o"
            flags = [args.cc, *cflags, "-DRETURNED_FWP=" + str(int(fwp))]
            if fwp:
                implementation = folder / "implementation.c"
                implementation.write_text(reference(ordinary) if peer == "reference" else ordinary)
                build([*flags, "-c", implementation, "-o", obj])
            elif peer == "rust":
                build([args.rustc, "--edition=2024", "--crate-type=lib", "--emit=obj", "--target", target,
                       "-C", "opt-level=2", "-C", "panic=abort", "-C", "lto=no", "-C", "target-cpu=" + rust_cpu,
                       fixtures / "returned_callable_peer.rs", "-o", obj])
            else:
                build([*flags, "-Wall", "-Wextra", "-Werror", "-c", fixtures / "returned_callable_peer.c", "-o", obj])
            observer = folder / "observer.o"
            build([*flags, "-Wall", "-Wextra", "-Werror", "-c", fixtures / "returned_callable_time.c", "-o", observer])
            report["builds"][peer] = build([args.cc, "-fno-lto", obj, observer, clock, "-lm", "-lpthread", "-o", binary])
        BINARY.native(binary, args.arch)
        copy = out / (peer + "-copy") / "program"
        copy.parent.mkdir()
        shutil.copy2(binary, copy)
        report["binaries"][peer] = dict(sha256=BINARY.digest(binary), bytes=binary.stat().st_size,
            sections=output([args.objdump, "--section-headers", binary]), libraries=output(["ldd", binary]))
        assert BINARY.digest(binary) == BINARY.digest(copy)
        if fwp:
            # Count and clean up one closure at a time, in a separate executable.
            # Its fixed ledger is not used by the 4,096-element timing program.
            profiled = folder / "profile.c"
            profiled.write_text(SOURCE.profile((folder / "implementation.c").read_text()))
            profile_binary = folder / "profile"
            build([*flags, "-DRETURNED_PROFILE=1", profiled, fixtures / "returned_callable_peer_probe.c",
                   "-lm", "-lpthread", "-o", profile_binary])
            controls = {}
            for case, status in (("success", 0), ("omit-release", 78), ("recovery", 0)):
                index = run([profile_binary, case], status=status, stderr=None)
                rows = RESULTS.phases(commands[index]["stderr"], case)
                if case == "success":
                    for row in rows:
                        if row["phase"] == 1:
                            count = row["calls"] if peer == "reference" else 0
                            assert row["retains"] == row["releases"] == count
                            assert row["applications"] == row["calls"] * (2 if peer == "reference" else 1)
                controls[case] = dict(command=index, phases=rows)
            report["controls"][peer] = controls
        save()
    for kind in range(2):
        row = dict(warmups=[], samples=[], memory={})
        report["cases"][str(kind)] = row
        arguments = [str(kind), *map(str, INPUT)]
        for warmup in range(2):
            for label in order(warmup):
                index = run([out / label / "program", *arguments])
                parse_output(commands[index]["stdout"], kind)
                row["warmups"].append(index)
        for round_number in range(ROUNDS):
            for position, label in enumerate(order(round_number)):
                index = run([out / label / "program", *arguments])
                ns = parse_output(commands[index]["stdout"], kind)
                ns["process"] = commands[index]["elapsedNs"]
                row["samples"].append(dict(round=round_number, position=position, label=label, command=index, ns=ns))
            save()
        row["summary"] = summarize(row["samples"])
        for peer in PEERS:
            row["memory"][peer] = []
            for sample in range(3):
                rss = out / peer / f"{kind}-{sample}.rss-kib"
                index = run([args.time, "-f", "%M", "-o", rss, out / peer / "program", *arguments])
                parse_output(commands[index]["stdout"], kind)
                value = int(rss.read_text())
                assert value > 0
                row["memory"][peer].append(dict(command=index, peakRssKiB=value))
        row["memoryWithinBudget"] = (max(value["peakRssKiB"] for value in row["memory"]["fwp"])
                                     <= max(value["peakRssKiB"] for value in row["memory"]["reference"]) + 1024)
        save()
        print("RESULT", kind, json.dumps(row["summary"]), "MEMORY", json.dumps(row["memory"]),
              "memoryWithinBudget", row["memoryWithinBudget"], flush=True)
    manifest = {str(path.relative_to(out)): BINARY.digest(path) for path in sorted(out.rglob("*")) if path.is_file()}
    (out / "manifest.json").write_text(json.dumps(manifest, indent=2) + "\n")


def audit(args):
    folder = args.input.resolve()
    manifest = json.loads((folder / "manifest.json").read_text())
    assert set(manifest) == {str(p.relative_to(folder)) for p in folder.rglob("*") if p.is_file() and p.name != "manifest.json"}
    for name, digest in manifest.items():
        path = Path(name)
        assert not path.is_absolute() and ".." not in path.parts
        assert BINARY.digest(folder / path) == digest
    report = json.loads((folder / "report.json").read_text())
    assert (report["source"], report["architecture"]) == (args.source, args.arch)
    assert report["session"] in (1, 2)
    assert report["settings"]["input"] == list(INPUT) and report["settings"]["rounds"] == ROUNDS
    assert report["settings"]["copyLimit"] == COPY_LIMIT and report["settings"]["minimumPhaseNs"] == MIN_PHASE_NS
    for path in (folder / "fixtures").iterdir():
        source = subprocess.check_output(["git", "show", f"{args.source}:tests/fixtures/{path.name}"], cwd=ROOT)
        assert path.read_bytes() == source
    assert (folder / "reference/implementation.c").read_text() == reference((folder / "fwp/implementation.c").read_text())
    commands = [json.loads(line) for line in (folder / "commands.jsonl").read_text().splitlines()]
    root = Path(report["root"])
    assert set(report["binaries"]) == set(PEERS) and set(report["cases"]) == {"0", "1"}
    for peer, row in report["binaries"].items():
        for label in (peer, peer + "-copy"):
            binary = folder / label / "program"
            BINARY.native(binary, args.arch)
            assert BINARY.digest(binary) == row["sha256"] and binary.stat().st_size == row["bytes"]
        build = commands[report["builds"][peer]]
        assert build["status"] == 0 and not build["stderr"] and not build["stdout"]
        assert build["argv"][-2:] == ["-o", str(root / peer / "program")]
    for peer in ("reference", "fwp"):
        assert set(report["controls"][peer]) == {"success", "omit-release", "recovery"}
        for case, row in report["controls"][peer].items():
            cmd = commands[row["command"]]
            assert cmd["argv"] == [str(root / peer / "profile"), case]
            assert cmd["status"] == (78 if case == "omit-release" else 0)
            assert row["phases"] == RESULTS.phases(cmd["stderr"], case)
            if case == "success":
                for phase in row["phases"]:
                    if phase["phase"] == 0:
                        assert phase["requests"] == 1 and phase["requestedBytes"] == 16
                    elif phase["phase"] == 1:
                        expected = phase["calls"] if peer == "reference" else 0
                        assert phase["retains"] == phase["releases"] == expected
                        assert phase["applications"] == phase["calls"] * (2 if peer == "reference" else 1)
                    else:
                        assert phase["frees"] == 1 and phase["finalRequestedBytes"] == 0
    for kind, row in report["cases"].items():
        arguments = [kind, *map(str, INPUT)]
        assert row["summary"] == summarize(row["samples"])
        assert len(row["warmups"]) == 20
        used = set()
        for i, index in enumerate(row["warmups"]):
            cmd = commands[index]
            assert cmd["argv"] == [str(root / order(i // 10)[i % 10] / "program"), *arguments]
            assert cmd["status"] == 0 and not cmd["stderr"]
            parse_output(cmd["stdout"], int(kind))
            assert index not in used
            used.add(index)
        for sample in row["samples"]:
            cmd = commands[sample["command"]]
            assert sample["command"] not in used
            used.add(sample["command"])
            assert cmd["argv"] == [str(root / sample["label"] / "program"), *arguments]
            assert cmd["status"] == 0 and not cmd["stderr"]
            ns = parse_output(cmd["stdout"], int(kind))
            ns["process"] = cmd["elapsedNs"]
            assert sample["ns"] == ns
        assert set(row["memory"]) == set(PEERS)
        for peer, values in row["memory"].items():
            assert len(values) == 3
            for i, value in enumerate(values):
                cmd = commands[value["command"]]
                relative = Path(peer) / f"{kind}-{i}.rss-kib"
                assert cmd["argv"][1:] == ["-f", "%M", "-o", str(root / relative), str(root / peer / "program"), *arguments]
                assert cmd["status"] == 0 and not cmd["stderr"]
                parse_output(cmd["stdout"], int(kind))
                assert type(value["peakRssKiB"]) is int and value["peakRssKiB"] > 0
                assert value["peakRssKiB"] == int((folder / relative).read_text())
        assert row["memoryWithinBudget"] == (max(v["peakRssKiB"] for v in row["memory"]["fwp"])
                                               <= max(v["peakRssKiB"] for v in row["memory"]["reference"]) + 1024)
        print("RESULT", report["architecture"], report["session"], kind, json.dumps(row["summary"]), "MEMORY", json.dumps(row["memory"]))
    print("HOST", json.dumps({key: report[key] for key in ("source", "architecture", "session", "cpu", "versions")}))
    print("Callable phase records and identical executables audited")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    sub = parser.add_subparsers(dest="command", required=True)
    collecting = sub.add_parser("collect")
    collecting.add_argument("--compiler", type=Path, required=True)
    collecting.add_argument("--output", type=Path, required=True)
    collecting.add_argument("--session", type=int, choices=(1, 2), required=True)
    for name in ("cc", "rustc", "swiftc", "time", "objdump"):
        collecting.add_argument("--" + name, required=True)
    auditing = sub.add_parser("audit")
    auditing.add_argument("--input", type=Path, required=True)
    for command in (collecting, auditing):
        command.add_argument("--source", required=True)
        command.add_argument("--arch", choices=("x86_64", "aarch64"), required=True)
    args = parser.parse_args()
    (collect if args.command == "collect" else audit)(args)


if __name__ == "__main__":
    main()
