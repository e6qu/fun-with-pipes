#!/usr/bin/env python3
"""Runner-only comparison of self-tail recursion with an explicit fwp loop."""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import statistics
import subprocess
import time

from fwp_tools.disassembler import Disassembler

ROOT = Path(__file__).resolve().parent.parent
spec = importlib.util.spec_from_file_location("iteration", ROOT / "scripts/measure-iteration.py")
iteration = importlib.util.module_from_spec(spec)
spec.loader.exec_module(iteration)

SOURCES = {
    "recursive": "rec down : I64 -> I64\ndown = match\n    0 -> 0\n    _ -> sub 1 | down\nmain = COUNT | down | echo\n",
    "explicit-loop": "step : I64 -> Step[I64, I64]\nstep = match\n    0 -> Stop 0\n    _ -> sub 1 | Again\nmain = COUNT | loop step | echo\n",
}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--fwp", type=Path, required=True)
    parser.add_argument("--cc", required=True)
    parser.add_argument("--objdump", required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--iterations", type=int, required=True)
    parser.add_argument("--samples", type=int, required=True)
    parser.add_argument("--timeout", type=float, required=True)
    args = parser.parse_args()
    if os.environ.get("GITHUB_ACTIONS") != "true":
        parser.error("full measurements run on GitHub runners")
    if args.iterations <= 1000 or args.samples < 4 or args.timeout <= 0:
        parser.error("choose more than 1000 iterations, at least four samples and a positive timeout")
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    env = dict(os.environ, FWP_PREEMPT="1000", FWP_SEED="42")
    for key in ["FWP_NO_OPT", "FWP_DUMP_IR"]:
        env.pop(key, None)
    compiler = str(args.fwp.resolve())
    tool = Disassembler(fwp=compiler, llvm_objdump=args.objdump, timeout=args.timeout)

    commands = []

    def run(command):
        commands.append(list(map(str, command)))
        completed = subprocess.run(list(map(str, command)), env=env, capture_output=True,
                                   text=True, encoding="utf-8", timeout=args.timeout)
        if completed.returncode:
            raise RuntimeError(f"{command!r}: {completed.stdout}\n{completed.stderr}")
        return completed

    report = {
        "source": run(["git", "rev-parse", "HEAD"]).stdout.strip(),
        "host": {"platform": platform.platform(), "machine": platform.machine(),
                 "cpu": Path("/proc/cpuinfo").read_text()},
        "compiler": run([args.cc, "--version"]).stdout,
        "work": "Count down the same positive integer to zero, print zero, and tear down the runtime.",
        "comparison": "Current fwp self-tail lowering versus an explicit fwp loop; no C/Rust baseline.",
        "timing": "Fresh-process wall time includes startup, countdown, output capture and teardown. Profiling/disassembly are excluded. Variant order rotates each round.",
        "differences": "Source function boundaries can add constant entry/scheduling costs. Both variants retain checked subtraction and loop cancellation polls. Generated code and commands are retained.",
        "iterations": args.iterations, "samples": args.samples, "cases": [],
        "runtime": {key: env[key] for key in ["FWP_PREEMPT", "FWP_SEED"]},
        "commands": commands,
        "sizeScope": "Whole file includes debug information; stack-use reports are compiler estimates per function, not a measured aggregate peak.",
    }
    for level in ["O0", "O2"]:
        variants = {}
        for name, template in SOURCES.items():
            label = f"counted-{level}-{name}"
            source = output / f"{label}.fwp"
            source.write_text(template.replace("COUNT", str(args.iterations)), encoding="utf-8")
            cfile = output / f"{label}.c"
            emit = [compiler, "build", "--emit-c", source, "-o", cfile]
            run(emit)
            code = cfile.read_text(encoding="utf-8")
            if name == "recursive":
                assert "fwp_self_again:" in code, "measurement must use the new lowering"
            binary = output / label
            command = [args.cc, f"-{level}", "-g", "-fstack-usage", "-std=gnu11", "-ffp-contract=off",
                       "-fno-fast-math", cfile, "-o", binary, "-lm", "-lpthread"]
            run(command)
            stack_files = list(output.glob(label + "*.su"))
            assert stack_files, "compiler must emit stack-use estimates"
            assert run([binary]).stdout == "0\n"
            listing = tool.inspect(binary)
            assert listing["instructions"], "actual binary must contain decoded instructions"
            (output / f"{label}-disassembly.json").write_text(json.dumps(listing, indent=2), encoding="utf-8")
            profiles = []
            for count in [1000, args.iterations]:
                profile_source = output / f"{label}-{count}-profile.fwp"
                profile_source.write_text(template.replace("COUNT", str(count)), encoding="utf-8")
                profile_c = profile_source.with_suffix(".c")
                run([compiler, "build", "--emit-c", profile_source, "-o", profile_c])
                profile_c.write_text(iteration.instrument(profile_c.read_text(encoding="utf-8")), encoding="utf-8")
                profile_binary = profile_source.with_suffix("")
                run([args.cc, f"-{level}", "-std=gnu11", "-ffp-contract=off", profile_c,
                     "-o", profile_binary, "-lm", "-lpthread"])
                measured = run([profile_binary])
                assert measured.stdout == "0\n"
                profile = json.loads(measured.stderr)
                assert profile["finalChargedBytes"] == 0, profile
                profiles.append({"iterations": count, **profile})
            assert profiles[0]["requests"] == profiles[1]["requests"], profiles
            assert profiles[0]["peakChargedBytes"] == profiles[1]["peakChargedBytes"], profiles
            variants[name] = {
                "binary": str(binary), "binaryBytes": binary.stat().st_size,
                "stackUseReports": {p.name: p.read_text() for p in stack_files},
                "disassemblyCommand": [compiler, "disassemble", "--json", "--tool", args.objdump, str(binary)],
                "binarySha256": hashlib.sha256(binary.read_bytes()).hexdigest(),
                "emitCommand": list(map(str, emit)), "compileCommand": list(map(str, command)),
                "profiles": profiles, "seconds": [],
            }
        names = list(variants)
        for round_index in range(args.samples):
            order = names[round_index % 2:] + names[:round_index % 2]
            for name in order:
                started = time.perf_counter()
                result = run([variants[name]["binary"]])
                elapsed = time.perf_counter() - started
                assert result.stdout == "0\n"
                variants[name]["seconds"].append(elapsed)
        ratio = statistics.median(variants["recursive"]["seconds"]) / statistics.median(variants["explicit-loop"]["seconds"])
        report["cases"].append({"level": level, "variants": variants,
                                "recursiveOverExplicitLoop": ratio,
                                "extraPercent": (ratio - 1) * 100})
        (output / "report.json").write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
        print(f"counted {level}: recursive/explicit-loop={ratio:.4f}; extra={(ratio - 1) * 100:.2f}%", flush=True)


if __name__ == "__main__":
    main()
