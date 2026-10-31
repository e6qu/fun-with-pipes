#!/usr/bin/env python3
"""Collect or audit four-language, whole-process comparisons on native Linux."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import resource
import shutil
import statistics
import struct
import subprocess
import time

from process_wait import run_capture

ROOT = Path(__file__).resolve().parent.parent
LANGUAGES = ("c", "rs", "swift", "fwp")
PROGRAMS = ("fib", "loop", "map", "pipeline", "range-set", "strings", "text-length")
LABELS = tuple(language + suffix for language in LANGUAGES for suffix in ("", "-copy"))
ROUNDS = 24
COPY_LIMIT = 1.02


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def order(round_number):
    # Balanced predecessors and positions across each block of eight rounds.
    return [LABELS[(i + round_number) % 8] for i in (0, 1, 7, 2, 6, 3, 5, 4)]


def summarize(samples):
    assert len(samples) == ROUNDS * len(LABELS)
    values = {label: [] for label in LABELS}
    for index, row in enumerate(samples):
        round_number, position = divmod(index, len(LABELS))
        assert row["round"] == round_number and row["position"] == position
        assert row["label"] == order(round_number)[position]
        assert type(row["elapsedNs"]) is int and row["elapsedNs"] > 0
        values[row["label"]].append(row["elapsedNs"])
    medians = {label: statistics.median(rows) for label, rows in values.items()}
    copies = {language: max(medians[language], medians[language + "-copy"])
              / min(medians[language], medians[language + "-copy"]) for language in LANGUAGES}
    return dict(medianNs=medians, copyRatios=copies, stable=all(v <= COPY_LIMIT for v in copies.values()),
                fwpOverPeer={language: medians["fwp"] / medians[language] for language in LANGUAGES[:-1]})


def native(path, arch):
    data = path.read_bytes()
    assert data[:6] == b"\x7fELF\x02\x01", path
    assert struct.unpack_from("<H", data, 18)[0] == {"x86_64": 62, "aarch64": 183}[arch]
    assert struct.unpack_from("<H", data, 16)[0] in (2, 3)
    assert struct.unpack_from("<Q", data, 24)[0] != 0


def collect(args):
    assert os.environ.get("GITHUB_ACTIONS") == "true", "full measurements run on GitHub"
    assert platform.system() == "Linux" and platform.machine() == args.arch
    assert subprocess.check_output(["git", "rev-parse", "HEAD"], cwd=ROOT, text=True).strip() == args.source
    assert args.source == os.environ["GITHUB_SHA"]
    assert args.c_arch == {"x86_64": "x86-64", "aarch64": "armv8-a"}[args.arch]
    assert args.rust_target == args.arch + "-unknown-linux-gnu"
    assert args.swift_target == args.arch + "-unknown-linux-gnu"
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    resource.setrlimit(resource.RLIMIT_CORE, (0, 0))
    env = {k: v for k, v in os.environ.items() if not k.startswith("FWP_") and k not in ("GH_TOKEN", "GITHUB_TOKEN")}
    env.update(CC=args.cc, FWP_STACK="1", FWP_LTO="0", LC_ALL="C", SWIFT_BACKTRACE="enable=no")
    commands = []

    def run(command, expected_status):
        command = list(map(str, command))
        started = time.perf_counter_ns()
        try:
            actual = run_capture(command, timeout=180, env=env, cwd=None, input_data=None,
                                 input_stream=None, text=True, encoding="utf-8", check=False)
        except subprocess.TimeoutExpired as error:
            with (out / "timeout.txt").open("w") as failed:
                failed.write(repr(error))
            raise
        row = dict(command=command, status=actual.returncode, stdout=actual.stdout,
                   stderr=actual.stderr, elapsedNs=time.perf_counter_ns() - started)
        commands.append(row)
        with (out / "commands.jsonl").open("a") as log:
            log.write(json.dumps(row) + "\n")
        if expected_status == "trap":
            assert actual.returncode in (-4, -5, -6), row
            assert not actual.stdout, row
        else:
            assert actual.returncode == expected_status and not actual.stderr, row
        return len(commands) - 1

    def output(command):
        return commands[run(command, 0)]["stdout"]

    def build(command):
        index = run(command, 0)
        assert not commands[index]["stdout"]
        return index

    report = dict(source=args.source, architecture=args.arch, session=args.session,
                  compilerSha256=digest(args.compiler), host=platform.uname()._asdict(),
                  cpu=output(["lscpu"]), versions={name: output([getattr(args, name), "--version"])
                  for name in ("cc", "rustc", "swiftc", "time", "objdump")},
                  settings=vars(args).copy(), programs={}, callable={})
    report["settings"] = {k: str(v) if isinstance(v, Path) else v for k, v in report["settings"].items()}
    report["swiftTarget"] = json.loads(output([args.swiftc, "-print-target-info", "-target", args.swift_target]))
    assert report["swiftTarget"]["target"]["triple"] == args.swift_target
    flags = ["-std=gnu11", "-O2", "-ffp-contract=off", "-fno-fast-math", "-fno-lto", "-march=" + args.c_arch]
    swift_flags = ["-swift-version", "6", "-O", "-whole-module-optimization", "-target", args.swift_target, "-warnings-as-errors"]

    def save():
        (out / "report.json").write_text(json.dumps(report, indent=2) + "\n")

    for name in PROGRAMS:
        folder = out / name
        folder.mkdir()
        row = dict(builds={}, binaries={}, samples=[], warmups=[], memory={}, summary={})
        report["programs"][name] = row
        for language in LANGUAGES:
            source = folder / ("main." + language)
            shutil.copyfile(ROOT / "bench" / name / source.name, source)
            binary = folder / language / "program"
            binary.parent.mkdir()
            if language == "fwp":
                generated = folder / "generated.c"
                build([args.compiler.resolve(), "build", source, "-O2", "--memory", "dynamic", "--emit-c", "-o", generated])
                command = [args.cc, *flags, "-fstack-usage", generated, "-lm", "-lpthread", "-ldl", "-o", binary]
            elif language == "c":
                command = [args.cc, *flags, "-fstack-usage", source, "-o", binary]
            elif language == "rs":
                command = [args.rustc, "--edition=2021", "-O", "-C", "lto=no", "-C", "target-cpu=" + args.rust_cpu,
                           "--target", args.rust_target, source, "-o", binary]
            else:
                command = [args.swiftc, *swift_flags, source, "-o", binary]
            row["builds"][language] = build(command)
            native(binary, args.arch)
            copy = folder / (language + "-copy") / "program"
            copy.parent.mkdir()
            shutil.copy2(binary, copy)
            assert digest(copy) == digest(binary)
            row["binaries"][language] = dict(sha256=digest(binary), bytes=binary.stat().st_size,
                sections=output([args.objdump, "--section-headers", binary]), libraries=output(["ldd", binary]))
        reference = output([folder / "c" / "program"])
        assert reference and all(line.isdecimal() for line in reference.splitlines())
        row["stdout"] = reference
        for warmup in range(2):
            for label in order(warmup):
                index = run([folder / label / "program"], 0)
                assert commands[index]["stdout"] == reference
                row["warmups"].append(index)
        for round_number in range(ROUNDS):
            for position, label in enumerate(order(round_number)):
                index = run([folder / label / "program"], 0)
                assert commands[index]["stdout"] == reference
                row["samples"].append(dict(round=round_number, position=position, label=label,
                                           command=index, elapsedNs=commands[index]["elapsedNs"]))
            save()
        row["summary"] = summarize(row["samples"])
        for language in LANGUAGES:
            values = []
            for sample in range(3):
                rss = folder / f"{language}-{sample}.rss-kib"
                index = run([args.time, "-f", "%M", "-o", rss, folder / language / "program"], 0)
                assert commands[index]["stdout"] == reference
                value = int(rss.read_text())
                assert value > 0
                values.append(dict(command=index, peakRssKiB=value))
            row["memory"][language] = values
        save()
        print(name, json.dumps(row["summary"]), flush=True)

    # Native Swift closure ABI between separate compilation units, not a C box.
    folder = out / "callable"
    folder.mkdir()
    for name in ("returned_callable_peer.swift", "returned_callable_swift_probe.swift", "returned_callable_swift_lifetime.swift"):
        shutil.copyfile(ROOT / "tests/fixtures" / name, folder / name)
    module = folder / "ReturnedCallable.swiftmodule"
    object_file = folder / "ReturnedCallable.o"
    peer = folder / "returned_callable_peer.swift"
    build([args.swiftc, *swift_flags, "-parse-as-library", "-module-name", "ReturnedCallable",
           "-emit-module", "-emit-module-path", module, "-emit-object", peer, "-o", object_file])
    binary = folder / "program"
    build([args.swiftc, *swift_flags, "-I", folder, folder / "returned_callable_swift_probe.swift", object_file, "-o", binary])
    native(binary, args.arch)
    expected = "".join(f"{kind} {n} {(kind+1)*(7*n+n*(n-1)//2)} 16 8\n" for kind in range(2) for n in (0, 1, 16, 4096))
    assert output([binary, "success"]) == expected
    for case in ("add-max", "add-min", "composition-add", "mul-max", "mul-min", "invalid-kind"):
        for prefix in ("", "direct-"):
            run([binary, prefix + case], "trap")
    for mode, extension in (("-emit-sil", "sil"), ("-emit-ir", "ll")):
        build([args.swiftc, *swift_flags, "-parse-as-library", "-module-name", "ReturnedCallable", mode, peer,
               "-o", folder / ("ReturnedCallable." + extension)])
    lifetime = folder / "lifetime"
    build([args.swiftc, *swift_flags, folder / "returned_callable_swift_lifetime.swift", "-o", lifetime])
    assert output([lifetime, "release"]) == "released\n"
    index = run([lifetime, "omit-release"], 78)
    assert not commands[index]["stdout"]
    report["callable"] = dict(scalarOutput=expected, overflowControls=12, releaseControl=True,
                              omittedReleaseStatus=78, allocationCounts=None, elapsedComparison=None)
    report["scope"] = "Whole-process elapsed time and separate peak RSS; no isolated ARC overhead or allocation counts. Swift native scalar closures have separate correctness/overflow and reference-capture cleanup controls, not timing or allocation measurements."
    save()
    manifest = {str(path.relative_to(out)): digest(path) for path in sorted(out.rglob("*")) if path.is_file()}
    (out / "manifest.json").write_text(json.dumps(manifest, indent=2) + "\n")


def audit(args):
    folder = args.input.resolve()
    manifest = json.loads((folder / "manifest.json").read_text())
    actual_files = {str(p.relative_to(folder)) for p in folder.rglob("*") if p.is_file() and p.name != "manifest.json"}
    assert set(manifest) == actual_files
    for name, expected in manifest.items():
        path = Path(name)
        assert not path.is_absolute() and ".." not in path.parts
        assert digest(folder / path) == expected, name
    report = json.loads((folder / "report.json").read_text())
    assert report["source"] == args.source and report["architecture"] == args.arch
    commands = [json.loads(line) for line in (folder / "commands.jsonl").read_text().splitlines()]
    assert set(report["programs"]) == set(PROGRAMS)
    for name, row in report["programs"].items():
        assert row["summary"] == summarize(row["samples"])
        assert len(row["warmups"]) == 16
        indices = row["warmups"] + [sample["command"] for sample in row["samples"]]
        assert len(set(indices)) == len(indices)
        for position, index in enumerate(row["warmups"]):
            assert Path(commands[index]["command"][0]).parts[-3:] == (name, order(position // 8)[position % 8], "program")
        for index in row["warmups"] + [sample["command"] for sample in row["samples"]]:
            record = commands[index]
            assert record["status"] == 0 and record["stdout"] == row["stdout"] and not record["stderr"]
        for sample in row["samples"]:
            record = commands[sample["command"]]
            assert Path(record["command"][0]).parts[-3:] == (name, sample["label"], "program")
            assert sample["elapsedNs"] == record["elapsedNs"]
        for language in LANGUAGES:
            source = folder / name / ("main." + language)
            assert source.read_bytes() == subprocess.check_output(["git", "show", f"{args.source}:bench/{name}/main.{language}"], cwd=ROOT)
            binary = folder / name / language / "program"
            native(binary, args.arch)
            assert digest(binary) == digest(folder / name / (language + "-copy") / "program") == row["binaries"][language]["sha256"]
            assert binary.stat().st_size == row["binaries"][language]["bytes"]
            build = commands[row["builds"][language]]
            assert build["status"] == 0 and not build["stdout"] and not build["stderr"]
            assert Path(build["command"][-1]).parts[-3:] == (name, language, "program")
            assert ("-O" if language in ("rs", "swift") else "-O2") in build["command"]
            assert "-Ounchecked" not in build["command"]
            assert len(row["memory"][language]) == 3
            for sample, memory in enumerate(row["memory"][language]):
                record = commands[memory["command"]]
                assert record["status"] == 0 and record["stdout"] == row["stdout"] and not record["stderr"]
                assert record["command"][1:4] == ["-f", "%M", "-o"]
                assert Path(record["command"][-1]).parts[-3:] == (name, language, "program")
                assert Path(record["command"][-2]).name == f"{language}-{sample}.rss-kib"
                assert memory["peakRssKiB"] == int((folder / name / f"{language}-{sample}.rss-kib").read_text()) > 0
    traps = [row for row in commands if row["status"] < 0]
    assert len(traps) == 12 and all(row["status"] in (-4, -5, -6) and not row["stdout"] for row in traps)
    assert {row["command"][-1] for row in traps} == {prefix + case for prefix in ("", "direct-")
        for case in ("add-max", "add-min", "composition-add", "mul-max", "mul-min", "invalid-kind")}
    assert all(len(row["command"]) == 2 and Path(row["command"][0]).parts[-2:] == ("callable", "program") for row in traps)
    leaks = [row for row in commands if row["status"] == 78]
    assert len(leaks) == 1 and leaks[0]["command"][-1] == "omit-release" and not leaks[0]["stdout"] and not leaks[0]["stderr"]
    assert Path(leaks[0]["command"][0]).parts[-2:] == ("callable", "lifetime")
    assert all(row["status"] == 0 or row in traps or row in leaks for row in commands)
    expected = "".join(f"{kind} {n} {(kind+1)*(7*n+n*(n-1)//2)} 16 8\n" for kind in range(2) for n in (0, 1, 16, 4096))
    assert report["callable"] == dict(scalarOutput=expected, overflowControls=12, releaseControl=True,
                                      omittedReleaseStatus=78, allocationCounts=None, elapsedComparison=None)
    success = [row for row in commands if len(row["command"]) == 2 and row["command"][-1] == "success"]
    assert len(success) == 1 and success[0]["stdout"] == expected and not success[0]["stderr"]
    release = [row for row in commands if len(row["command"]) == 2 and row["command"][-1] == "release"]
    assert len(release) == 1 and release[0]["stdout"] == "released\n" and not release[0]["stderr"]
    for path in (folder / "callable").glob("*.swift"):
        assert path.read_bytes() == subprocess.check_output(["git", "show", f"{args.source}:tests/fixtures/{path.name}"], cwd=ROOT)
    print("Seven four-language timing/RSS rows and Swift closure controls verified; noisy rows remain inconclusive")
    print("HOST", json.dumps(dict(source=report["source"], architecture=report["architecture"],
                                 session=report["session"], cpu=report["cpu"], versions=report["versions"])))
    for name, row in report["programs"].items():
        print("RESULT", json.dumps(dict(program=name, **row["summary"],
            peakRssKiB={language: [sample["peakRssKiB"] for sample in values]
                        for language, values in row["memory"].items()})))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    commands = parser.add_subparsers(dest="mode", required=True)
    collect_parser = commands.add_parser("collect")
    for name in ("compiler", "output"):
        collect_parser.add_argument("--" + name, type=Path, required=True)
    for name in ("cc", "rustc", "swiftc", "c-arch", "rust-cpu", "rust-target", "swift-target", "time", "objdump"):
        collect_parser.add_argument("--" + name, required=True)
    collect_parser.add_argument("--session", type=int, choices=(1, 2), required=True)
    audit_parser = commands.add_parser("audit")
    audit_parser.add_argument("--input", type=Path, required=True)
    for child in (collect_parser, audit_parser):
        child.add_argument("--source", required=True)
        child.add_argument("--arch", choices=("x86_64", "aarch64"), required=True)
    args = parser.parse_args()
    if args.mode == "collect":
        collect(args)
    else:
        audit(args)


if __name__ == "__main__":
    main()
