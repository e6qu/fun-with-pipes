"""Retain C and actual O0/O1/O2/O3 objects for three maintained applications."""
import argparse
import json
from pathlib import Path
import platform
import subprocess

from fwp_tools.disassembler import Disassembler, Target


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--fwp", required=True)
    parser.add_argument("--cc", required=True)
    parser.add_argument("--objdump", required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--timeout", type=float, required=True)
    args = parser.parse_args()
    root = Path(__file__).resolve().parents[1]
    args.output.mkdir(parents=True, exist_ok=False)
    lesson = (root / "docs/tutorials/20-autodiff-and-devices/main.fwp").read_text(encoding="utf-8")
    service = (root / "tests/fixtures/weak_callback_service.fwp").read_text(encoding="utf-8")
    sources = {
        "words": (root / "examples/wordfreq.fwp").read_text(encoding="utf-8"),
        "numerical": lesson.split("\nloss :", 1)[0] +
            "\nmain = [-1.2, 1.0, 0.5] | descend | json.write | print\n",
        "callbacks": service.split("\nmain =", 1)[0] +
            "\nmain = [(64, 0), (64, 1), (64, 2), (64, 3)] | each (service | json.write | print)\n",
    }
    machine = subprocess.run([args.cc, "-dumpmachine"], check=True, capture_output=True,
        text=True, encoding="utf-8", timeout=args.timeout)
    if machine.stderr or not machine.stdout.strip():
        raise RuntimeError(f"unexpected compiler target reply: {machine!r}")
    summary = {"host": platform.machine(), "system": platform.system(),
        "compiler_target": machine.stdout.strip(), "executed": False, "applications": {}, "issues": []}
    tool = Disassembler(fwp=args.fwp, llvm_objdump=args.objdump, timeout=args.timeout)
    for name, program in sources.items():
        source = args.output / (name + ".fwp")
        source.write_text(program, encoding="utf-8")
        try:
            report = tool.compare(source, args.output / name,
                targets=[Target("native", args.cc, "native", triple=None, sysroot=None)],
                levels=("O0", "O1", "O2", "O3"))
        except (RuntimeError, OSError, subprocess.SubprocessError) as error:
            summary["issues"].append(f"{name}: {error}")
            continue
        if report["executed"] or len(report["variants"]) != 4:
            summary["issues"].append(f"{name}: incomplete inspection report")
        for target in report["targets"]:
            if target["emit_stderr"] or not target["generated_c"]:
                summary["issues"].append(f"{name}: missing C or unexpected emission diagnostic: {target['emit_stderr']}")
        variants = []
        for variant in report["variants"]:
            instructions = variant["instructions"]
            if variant["compiler_stderr"] or not instructions or not all(i["encoding"] for i in instructions):
                summary["issues"].append(f"{name}/{variant['optimization']}: compiler diagnostic or missing instructions: {variant['compiler_stderr']}")
            if not any(i["c_line"] is not None and i["c_source"] is not None for i in instructions):
                summary["issues"].append(f"{name}/{variant['optimization']}: no C line annotations")
            variants.append({"level": variant["optimization"], "instructions": len(instructions),
                "binary_sha256": variant["binary_sha256"], "compiler_version": variant["compiler_version"]})
        summary["applications"][name] = variants
        (args.output / "summary.json").write_text(json.dumps(summary, indent=2) + "\n", encoding="utf-8")
        print(f"{name}: retained generated C and four native object listings", flush=True)
    (args.output / "summary.json").write_text(json.dumps(summary, indent=2) + "\n", encoding="utf-8")
    if summary["issues"]:
        raise RuntimeError("\n".join(summary["issues"]))
    print("Application disassembly checks passed; objects were not executed.")


if __name__ == "__main__":
    main()
