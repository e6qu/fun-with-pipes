#!/usr/bin/env python3
"""Check the actual Swift loop body and detect removed overflow checks."""
import argparse
import json
import os
from pathlib import Path
import resource
import subprocess

ROOT = Path(__file__).resolve().parent.parent
MIN = -(1 << 63)
MAX = (1 << 63) - 1


def expected(i, total):
    if i == 0:
        return f"{i} {total}\n"
    if i - 1 < MIN or not MIN <= i * 3 <= MAX:
        return None
    product = i * 3
    remainder = product % 7 if product >= 0 else -((-product) % 7)
    if not MIN <= total + remainder <= MAX:
        return None
    return f"{i - 1} {total + remainder}\n"


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--swiftc", required=True)
    parser.add_argument("--target", required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=False)
    resource.setrlimit(resource.RLIMIT_CORE, (0, 0))
    env = dict(os.environ, SWIFT_BACKTRACE="enable=no")
    original = (ROOT / "bench/loop/main.swift").read_text()
    assert original.count("while i != 0 {\n") == 1
    body = original.split("while i != 0 {\n")[1].split("\n}\n")[0]
    variants = {"ordinary": body}
    for name, before, after in (("subtraction", "i - 1", "i &- 1"),
                                ("multiplication", "i * 3", "i &* 3"),
                                ("addition", "sum + product % 7", "sum &+ product % 7")):
        assert body.count(before) == 1
        variants[name] = body.replace(before, after)
    cases = [(i, total) for i in (MIN, MIN + 1, MAX, MAX // 3, MAX // 3 + 1, -8, -1, 0, 1, 7, 8)
             for total in (MIN, 0, MAX)]
    report = []
    for name, candidate in variants.items():
        source = args.output / (name + ".swift")
        source.write_text("var i = Int64(CommandLine.arguments[1])!\nvar sum = Int64(CommandLine.arguments[2])!\nif i != 0 {\n"
                          + candidate + '\n}\nprint("\\(i) \\(sum)")\n')
        binary = args.output / name
        command = [args.swiftc, "-swift-version", "6", "-O", "-whole-module-optimization", "-warnings-as-errors",
                   "-target", args.target, str(source), "-o", str(binary)]
        built = subprocess.run(command, capture_output=True, text=True, env=env, timeout=60)
        assert built.returncode == 0 and not built.stdout and not built.stderr, built
        observations = []
        for i, total in cases:
            actual = subprocess.run([str(binary.resolve()), str(i), str(total)], capture_output=True, text=True, env=env, timeout=10)
            reference = expected(i, total)
            agrees = (actual.returncode in (-4, -5, -6) and not actual.stdout if reference is None
                      else actual.returncode == 0 and actual.stdout == reference and not actual.stderr)
            observations.append(dict(i=i, total=total, expected=reference, status=actual.returncode,
                                     stdout=actual.stdout, stderr=actual.stderr, agrees=agrees))
        # i == MIN already traps on multiplication if subtraction wraps; use a
        # one-operation probe to verify subtraction separately below.
        if name == "ordinary":
            assert all(row["agrees"] for row in observations)
        elif name != "subtraction":
            assert any(not row["agrees"] for row in observations), name
        report.append(dict(variant=name, command=command, observations=observations))
    # The loop can mask a missing subtraction check with its later multiply.
    # Check the extracted first expression in isolation, including the trap.
    for checked, expression in ((True, "i - 1"), (False, "i &- 1")):
        path = args.output / ("sub-checked.swift" if checked else "sub-wrapping.swift")
        path.write_text(f'let i = Int64(CommandLine.arguments[1])!\nprint({expression})\n')
        binary = path.with_suffix("")
        command = [args.swiftc, "-swift-version", "6", "-O", "-target", args.target, str(path), "-o", str(binary)]
        built = subprocess.run(command, capture_output=True, text=True, env=env, timeout=60)
        assert built.returncode == 0 and not built.stdout and not built.stderr
        actual = subprocess.run([str(binary.resolve()), str(MIN)], capture_output=True, text=True, env=env, timeout=10)
        assert (actual.returncode in (-4, -5, -6) and not actual.stdout) if checked else (actual.returncode == 0 and actual.stdout == f"{MAX}\n")
        report.append(dict(subtractionChecked=checked, command=command, status=actual.returncode, stdout=actual.stdout, stderr=actual.stderr))
    (args.output / "report.json").write_text(json.dumps(report, indent=2) + "\n")
    print("33 dynamic loop cases and removed subtraction/multiplication/addition checks verified")


if __name__ == "__main__":
    main()
