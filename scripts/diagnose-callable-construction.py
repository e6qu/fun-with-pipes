#!/usr/bin/env python3
"""Reproduce compiler reports or isolate preceding-call effects in one binary.

No unchanged timing retry, production runtime patch, or disassembly.
"""
import argparse
import importlib.util
import json
import os
from pathlib import Path
import platform
import resource
import shutil
import subprocess

from callable_context import collect

SPEC = importlib.util.spec_from_file_location("phases", Path(__file__).with_name("measure-callable-phases.py"))
PHASES = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PHASES)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--input", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--source", required=True)
    parser.add_argument("--arch", choices=("aarch64", "x86_64"), required=True)
    parser.add_argument("--cc", required=True)
    parser.add_argument("--study", choices=("reports", "context"), required=True)
    args = parser.parse_args()
    assert os.environ.get("GITHUB_ACTIONS") == "true"
    resource.setrlimit(resource.RLIMIT_CORE, (0, 0))
    assert platform.system() == "Linux" and platform.machine() == args.arch
    PHASES.audit(args)
    report = json.loads((args.input / "report.json").read_text())
    actual_version = subprocess.check_output([args.cc, "--version"], text=True)
    assert actual_version == report["versions"]["cc"], (actual_version, report["versions"]["cc"])
    # Preserve original source paths so GCC's file identities match the measured
    # objects. Only restore into this checkout's named evidence directory.
    root = Path(report["root"])
    assert root.parent == PHASES.ROOT and root.name == f"callable-phase-evidence-{report['session']}"
    assert not root.exists()
    shutil.copytree(args.input, root)
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    commands = [json.loads(line) for line in (root / "commands.jsonl").read_text().splitlines()]
    if args.study == "context":
        collect(args, root, out / "context", PHASES)
        return
    results = {}
    for peer in ("reference", "fwp"):
        source = root / peer / "implementation.c"
        original = root / peer / "implementation.o"
        builds = [row for row in commands if row["argv"][-2:] == ["-o", str(original)]]
        assert len(builds) == 1 and builds[0]["status"] == 0
        argv = builds[0]["argv"]
        assert argv[0] == args.cc and argv[-4:-2] == ["-c", str(source)]
        copied = out / (peer + ".o")
        inline = out / (peer + ".inline.txt")
        optimized = out / (peer + ".optimized.txt")
        command = [*argv[:-2], "-fopt-info-inline-all=" + str(inline),
                   "-fdump-tree-optimized=" + str(optimized), "-o", str(copied)]
        result = subprocess.run(command, capture_output=True, text=True, timeout=180, check=False)
        record = dict(command=command, status=result.returncode, stdout=result.stdout, stderr=result.stderr)
        (out / (peer + ".command.json")).write_text(json.dumps(record, indent=2) + "\n")
        assert result.returncode == 0 and not result.stdout and not result.stderr, record
        assert PHASES.BINARY.digest(copied) == PHASES.BINARY.digest(original), "report flags changed the measured object"
        results[peer] = dict(objectSha256=PHASES.BINARY.digest(copied), inlineSha256=PHASES.BINARY.digest(inline),
                             optimizedSha256=PHASES.BINARY.digest(optimized))
        print("OBJECT", peer, json.dumps(results[peer]), flush=True)
        for line in inline.read_text().splitlines():
            if any(name in line for name in ("returned_make", "fwp_pap", "fwp_rc_fresh", "fwp_heap_alloc")):
                print(peer, "INLINE", line, flush=True)
        text = optimized.read_text()
        sections = text.split(";; Function ")
        found = [section for section in sections if section.startswith("returned_make ")]
        assert len(found) == 1
        print(peer, "FACTORY", found[0], flush=True)
    (out / "report.json").write_text(json.dumps(dict(source=args.source, architecture=args.arch,
        session=report["session"], cc=actual_version, results=results), indent=2) + "\n")


if __name__ == "__main__":
    main()
