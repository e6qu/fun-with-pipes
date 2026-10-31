#!/usr/bin/env python3
"""Runner-only callable correctness, ownership and binary evidence; no timing."""
import argparse
import base64
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import re
import shutil
import subprocess


ROOT = Path(__file__).resolve().parent.parent


def load(name):
    spec = importlib.util.spec_from_file_location(name, ROOT / "scripts" / f"{name}.py")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


SOURCE = load("returned-callable-source")
RESULTS = load("returned-callable-results")
FRAMES = load("prepare-buffer-baselines")


def binary_architecture(data):
    if data[:6] == b"\x7fELF\x02\x01":
        return {62: "x86_64", 183: "aarch64"}[int.from_bytes(data[18:20], "little")]
    if data[:4] == b"\xcf\xfa\xed\xfe":
        return {0x1000007: "x86_64", 0x100000c: "aarch64"}[int.from_bytes(data[4:8], "little")]
    raise ValueError("expected a native 64-bit ELF or Mach-O binary")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ("compiler", "output"):
        parser.add_argument("--" + name, type=Path, required=True)
    for name in ("cc", "rustc", "c-arch", "rust-cpu", "rust-target", "objdump", "nm", "size"):
        parser.add_argument("--" + name, required=True)
    parser.add_argument("--rust-frame-pass", choices=("prolog-epilog", "prologepilog"), required=True)
    args = parser.parse_args()
    if os.environ.get("GITHUB_ACTIONS") != "true":
        parser.error("complete evidence collection runs on GitHub runners")
    machine = {"arm64": "aarch64", "aarch64": "aarch64", "x86_64": "x86_64"}[platform.machine()]
    assert args.c_arch == {"aarch64": "armv8-a", "x86_64": "x86-64"}[machine]
    assert args.rust_cpu == {"aarch64": "generic", "x86_64": "x86-64"}[machine]
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    compiler = args.compiler.resolve()
    env = {key: value for key, value in os.environ.items()
           if not key.startswith("FWP_") and key not in ("GH_TOKEN", "GITHUB_TOKEN")}
    env.update(CC=args.cc, FWP_STACK="1", FWP_LTO="0", LC_ALL="C")

    def run(command, *, status, diagnostic, environment):
        command = list(map(str, command))
        try:
            result = subprocess.run(command, capture_output=True, env=environment, timeout=180)
        except subprocess.TimeoutExpired as error:
            record = dict(command=command, status=None, timedOut=True,
                          stdout=base64.b64encode(error.stdout or b"").decode(),
                          stderr=base64.b64encode(error.stderr or b"").decode())
        else:
            record = dict(command=command, status=result.returncode, timedOut=False,
                          stdout=base64.b64encode(result.stdout).decode(),
                          stderr=base64.b64encode(result.stderr).decode())
        record["rawInterpreter"] = environment.get("FWP_NO_OPT") == "1"
        with (out / "commands.jsonl").open("a") as log:
            log.write(json.dumps(record) + "\n")
        assert record["status"] == status and not record["timedOut"], record
        if diagnostic is not None:
            assert result.stderr == diagnostic.encode(), record
        return result

    def checked(command):
        return run(command, status=0, diagnostic="", environment=env).stdout.decode()

    source = checked(["git", "rev-parse", "HEAD"]).strip()
    assert source == os.environ["GITHUB_SHA"]
    report = dict(source=source, compilerSha256=hashlib.sha256(compiler.read_bytes()).hexdigest(),
                  host=platform.uname()._asdict(), machine=machine, commands="commands.jsonl",
                  versions={name: checked([getattr(args, name), "--version"])
                            for name in ("cc", "rustc", "objdump", "nm", "size")}, programs={})
    assert binary_architecture(compiler.read_bytes()) == machine
    rust_host = checked([args.rustc, "-vV"])
    assert f"host: {args.rust_target}\n" in rust_host
    report["rustHost"] = rust_host
    fixtures = out / "fixtures"
    fixtures.mkdir()
    for path in sorted((ROOT / "tests/fixtures").glob("returned_callable_*")):
        shutil.copyfile(path, fixtures / path.name)
    input_file = fixtures / "returned_callable_peer.fwp"
    expected_raw = "(0, 0)\n(7, 14)\n(232, 464)\n(8415232, 16830464)\n"
    for raw in (False, True):
        environment = dict(env, FWP_NO_OPT="1") if raw else env
        result = run([compiler, "run", "--interp", input_file], status=0,
                     diagnostic="", environment=environment)
        assert result.stdout.decode() == expected_raw
    original = out / "generated.c"
    assert not checked([compiler, "build", "--fn", "callable-values", "--memory", "dynamic",
                        "--emit-c", "-O2", input_file, "-o", original])
    ordinary = SOURCE.boundary(original.read_text())
    profiled = SOURCE.profile(ordinary)
    # Negative metadata controls must be rejected before any C is compiled.
    for damaged in (original.read_text().replace('"escaped-partial"', '"missing-partial"'),
                    re.sub(r'\{2, (e\d+, "escaped-partial")', r'{1, \1', original.read_text())):
        try:
            SOURCE.boundary(damaged)
        except ValueError:
            pass
        else:
            raise AssertionError("invalid callback metadata was accepted")
    for level in (1, 2):
        for language, diagnostic in (("c", False), ("rust", False), ("fwp", False), ("fwp", True)):
            label = f"{language}-O{level}" + ("-profile" if diagnostic else "")
            folder = out / label
            folder.mkdir()
            implementation = folder / ("callable.rs" if language == "rust" else "callable.c")
            if language == "fwp":
                implementation.write_text(profiled if diagnostic else ordinary)
            else:
                shutil.copyfile(fixtures / f"returned_callable_peer.{implementation.suffix[1:]}", implementation)
            cflags = [args.cc, f"-O{level}", "-std=gnu11", "-ffp-contract=off", "-fno-fast-math",
                      "-fno-lto", "-fstack-usage", "-march=" + args.c_arch,
                      "-I", fixtures, f"-DRETURNED_FWP={int(language == 'fwp')}",
                      f"-DRETURNED_PROFILE={int(diagnostic)}"]
            objects = [folder / "callable.o", folder / "observer.o"]
            rust_frames = []
            if language == "rust":
                result = run([args.rustc, "--edition=2024", "--crate-type=lib", "--emit=obj",
                              "--target", args.rust_target, "-C", f"opt-level={level}",
                              "-C", "panic=abort", "-C", "lto=no", "-C", "target-cpu=" + args.rust_cpu,
                              "-C", "remark=" + args.rust_frame_pass, "--error-format=json", implementation,
                              "-o", objects[0]], status=0, diagnostic=None, environment=env)
                assert not result.stdout
                rust_frames = FRAMES.rust_frames(result.stderr.decode(), args.rust_frame_pass)
                (folder / "rust-frames.jsonl").write_bytes(result.stderr)
            else:
                assert not checked([*cflags, "-c", implementation, "-o", objects[0]])
            assert not checked([*cflags, "-Wall", "-Wextra", "-Werror", "-c",
                                fixtures / "returned_callable_peer_probe.c", "-o", objects[1]])
            binary = folder / "callable"
            assert not checked([args.cc, "-fno-lto", *objects, "-lm", "-lpthread", "-o", binary])
            data = binary.read_bytes()
            assert binary_architecture(data) == machine
            frames = [row for path in sorted(folder.glob("*.su")) for row in FRAMES.c_frames(path.read_text())]
            assert frames
            row = dict(binarySha256=hashlib.sha256(data).hexdigest(), binaryBytes=len(data),
                       sourceSha256=hashlib.sha256(implementation.read_bytes()).hexdigest(),
                       cFrames=frames, rustFrames=rust_frames, controls={}, phases={})
            expected = "".join(f"{kind} {n} {(kind+1)*(7*n+n*(n-1)//2)} {8 if language == 'fwp' else 16} 8\n"
                               for kind in range(2) for n in RESULTS.COUNTS)
            cases = [("success", 0, expected)]
            if language == "fwp":
                cases += [("omit-release", 78, expected), ("recovery", 0,
                           "".join(f"recovered {kind} {n}\n" for kind in range(2) for n in (0, 8)))]
            for case, status, stdout in cases:
                result = run([binary, case], status=status, diagnostic=None if diagnostic else "", environment=env)
                assert result.stdout.decode() == stdout
                row["controls"][case] = dict(status=status, stdout=stdout)
                (folder / f"{case}.stdout").write_bytes(result.stdout)
                (folder / f"{case}.stderr").write_bytes(result.stderr)
                if diagnostic:
                    row["phases"][case] = RESULTS.phases(result.stderr.decode(), case)
            for case, message in (("add-max", "addition overflow"), ("add-min", "addition overflow"),
                                  ("composition-add", "addition overflow"), ("mul-max", "multiplication overflow"),
                                  ("mul-min", "multiplication overflow"), ("invalid-kind", "invalid callable kind")):
                for prefix in ("", "direct-"):
                    status = 71 if case == "invalid-kind" else (101 if language == "fwp" else 70)
                    stderr = (("fwp: trap: arithmetic overflow in I64" if language == "fwp" and status == 101
                               else message) + "\n")
                    result = run([binary, prefix + case], status=status, diagnostic=stderr, environment=env)
                    assert not result.stdout
                    row["controls"][prefix + case] = dict(status=status, stderr=stderr)
            if not diagnostic:
                listing = json.loads(checked([compiler, "disassemble", "--json", "--tool", args.objdump, binary]))
                assert listing["instructions"]
                row["code"] = RESULTS.code_sizes(listing["instructions"], language)
                (folder / "instructions.json").write_text(json.dumps(listing, indent=2) + "\n")
                sections = checked([args.size, "--format=sysv", binary])
                (folder / "sections.txt").write_text(sections)
                symbols = checked([args.nm, "--defined-only", binary])
                (folder / "symbols.txt").write_text(symbols)
                undefined = checked([args.nm, "--undefined-only", objects[0]])
                (folder / "undefined.txt").write_text(undefined)
                if language != "fwp":
                    assert not re.search(r"\b_?(?:malloc|calloc|realloc|free|__rust_alloc)\b", undefined)
                row["instructionListing"] = str((folder / "instructions.json").relative_to(out))
                row["sections"] = sections
                row["undefinedImplementationSymbols"] = undefined
            report["programs"][label] = row
            (out / "report.json").write_text(json.dumps(report, indent=2) + "\n")
            print(label + ": results, overflow and declared ownership controls pass", flush=True)
    report["scope"] = (
        "No elapsed-time acceptance. Separate translation units, no LTO. C/Rust scalar callable records "
        "contain an inline capture and function pointer; Rust uses core, not whole-application std startup. "
        "fwp retains ordinary runtime startup and cleanup. Direct calls are outside the invocation counters. "
        "Phase counters measure successful managed payload requests, physical frees, effective count operations "
        "and runtime application entries, not machine instructions. Requested-byte peaks exclude slot padding, "
        "raw allocator backing and stacks. Charged payload and retained count-table bytes are separate snapshots. "
        "Ordinary binaries include the observer and recovery controls; only ordinary code is inspected. "
        "Compiler frame reports describe individual frames, not aggregate stack use.")
    (out / "report.json").write_text(json.dumps(report, indent=2) + "\n")


if __name__ == "__main__":
    main()
