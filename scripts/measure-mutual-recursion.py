#!/usr/bin/env python3
"""Compare ordinary mutual calls, the compiler prototype and an explicit fwp loop."""
import argparse
import hashlib
import json
import math
import os
from pathlib import Path
import platform
import statistics
import subprocess
import time


def assess(case, budgets):
    """Recompute the decision from raw samples; failed controls are inconclusive."""
    control = [statistics.median(pair[i] for pair in case["controls"]) for i in range(2)]
    variants = case["variants"]
    grouped, explicit, ordinary = [variants[name] for name in ["grouped", "explicit", "ordinary"]]
    samples = [t for pair in case["controls"] for t in pair]
    samples.extend(t for variant in variants.values() for t in variant["seconds"])
    if any(not math.isfinite(t) or t <= 0 for t in samples):
        raise ValueError("timing samples must be finite and positive")
    control_ratio = max(control) / min(control)
    loop_ratio = statistics.median(grouped["seconds"]) / statistics.median(explicit["seconds"])
    valid = control_ratio <= budgets["controlRatio"]
    if case["level"] == "O0":
        valid &= ordinary["profiles"][1]["stackRange"] > ordinary["profiles"][0]["stackRange"] * 8
    checks = {
        "timing": loop_ratio <= budgets["groupedOverExplicit"],
        "codeSize": grouped["textBytes"] <= ordinary["textBytes"] + budgets["extraTextBytes"],
        "allocation": all(p["allocations"] == budgets["managedRequests"]
                          for v in variants.values() for p in v["profiles"]),
        "stack": all(v["profiles"][1]["stackRange"] <= v["profiles"][0]["stackRange"] + budgets["extraStackRangeBytes"]
                     for v in [grouped, explicit]),
    }
    accepted = valid and all(checks.values())
    return {"controlRatio": control_ratio, "groupedOverExplicit": loop_ratio,
            "validControls": valid, "checks": checks, "accepted": accepted,
            "decision": "inconclusive" if not valid else "accept" if accepted else "reject"}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--input", type=Path, required=True)
    parser.add_argument("--cc", required=True)
    parser.add_argument("--objdump", required=True)
    parser.add_argument("--iterations", type=int, required=True)
    parser.add_argument("--repeats", type=int, required=True)
    parser.add_argument("--samples", type=int, required=True)
    parser.add_argument("--warmups", type=int, required=True)
    parser.add_argument("--timeout", type=float, required=True)
    parser.add_argument("--max-control-ratio", type=float, required=True)
    parser.add_argument("--max-loop-ratio", type=float, required=True)
    args = parser.parse_args()
    if os.environ.get("GITHUB_ACTIONS") != "true":
        parser.error("measurements run on GitHub runners")
    if (args.iterations < 64 or args.iterations > 4096 or args.iterations % 2
            or args.repeats < 2 or args.repeats % 2 or args.samples < 6
            or args.warmups < 2 or args.timeout <= 0
            or not all(math.isfinite(n) for n in [args.timeout, args.max_control_ratio, args.max_loop_ratio])
            or args.max_control_ratio <= 1 or args.max_loop_ratio <= 1):
        parser.error("use an even input in [64,4096], even repeats, >=6 samples and >=2 warmups")
    root = args.input.resolve()
    commands = []
    environment = dict(os.environ, FWP_ALLOC_STATS="0")

    def run(command):
        started = time.perf_counter()
        try:
            out = subprocess.run(list(map(str, command)), env=environment,
                                 capture_output=True, text=True, timeout=args.timeout)
        except subprocess.TimeoutExpired as error:
            commands.append({"command": list(map(str, command)), "timeout": args.timeout,
                             "seconds": time.perf_counter() - started})
            (root / "commands.json").write_text(json.dumps(commands, indent=2) + "\n")
            # TimeoutExpired carries captured bytes even for text-mode runs.
            (root / "timeout.stdout").write_bytes(error.stdout or b"")
            (root / "timeout.stderr").write_bytes(error.stderr or b"")
            raise
        elapsed = time.perf_counter() - started
        commands.append({"command": list(map(str, command)), "status": out.returncode,
                         "seconds": elapsed,
                         "stderr": out.stderr, "failedStdout": out.stdout if out.returncode else ""})
        (root / "commands.json").write_text(json.dumps(commands, indent=2) + "\n")
        if out.returncode:
            raise RuntimeError(f"{command}: status {out.returncode}\n{out.stdout}\n{out.stderr}")
        return out

    report = {
        "source": run(["git", "rev-parse", "HEAD"]).stdout.strip(),
        "host": {"platform": platform.platform(), "machine": platform.machine(),
                 "cpu": Path("/proc/cpuinfo").read_text()},
        "compiler": run([args.cc, "--version"]).stdout,
        "work": "Compute integer parity by alternating countdown branches. Each repetition uses n or n+1; the checksum must be repeats/2.",
        "comparison": "Three current-fwp implementations; no C/Rust peer or language-wide overhead claim. Ordinary and grouped variants start from identical typed IR. Explicit uses the public loop combinator.",
        "timing": "Fresh-process wall time, including runtime startup, repetitions, checksum output and cleanup. No instrumentation in timed executables. A volatile C entry pointer prevents hoisting repeated calls; this common boundary cost is included.",
        "storage": "Separate instrumented binaries count managed requests during entry calls and sample C stack addresses with GCC function hooks. Per-function compiler stack estimates and actual binaries are retained separately.",
        "budgets": {"controlRatio": args.max_control_ratio, "groupedOverExplicit": args.max_loop_ratio,
                    "managedRequests": 0, "extraStackRangeBytes": 1024,
                    "extraTextBytes": 1024},
        "settings": vars(args) | {"input": str(root)}, "cases": [], "commands": commands,
    }

    def save():
        (root / "report.json").write_text(json.dumps(report, indent=2) + "\n")

    save()  # Freeze scope and budgets before compiling or timing a candidate.
    harness = r'''
int main(int argc, char **argv) {
    if(argc != 3) return 210;
    V n = strtoull(argv[1], NULL, 10), repeats = strtoull(argv[2], NULL, 10), sum = 0;
    V (*volatile invoke)(V) = @ENTRY@;
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    size_t baseline = fwp_heap.live;
    @START@
    for(V i = 0; i < repeats; i++) sum += invoke(n + (i & 1));
    @STOP@
    if(sum != repeats / 2 || fwp_heap.live != baseline || fwp_cleanups) return 211;
    printf("%llu\n", (unsigned long long)sum);
    fwp_tasks_finish(); fwp_caf_finish(); fwp_native_tasks_finish();
    if(fwp_heap.live || fwp_cleanups || fwp_state_owners) return 213;
    return 0;
}
'''
    profile = r'''
static int mutual_active;
static unsigned long long mutual_calls, mutual_allocations;
static uintptr_t mutual_low, mutual_high;
void __attribute__((no_instrument_function)) __cyg_profile_func_enter(void *fn, void *caller) {
    (void)fn; (void)caller;
    volatile unsigned char marker;
    if(!mutual_active) return;
    uintptr_t address = (uintptr_t)&marker;
    if(!mutual_calls || address < mutual_low) mutual_low = address;
    if(!mutual_calls || address > mutual_high) mutual_high = address;
    mutual_calls++;
}
void __attribute__((no_instrument_function)) __cyg_profile_func_exit(void *fn, void *caller) {
    (void)fn; (void)caller;
}
'''
    for level in ["O0", "O2"]:
        case = {"level": level, "variants": {}, "controls": [], "accepted": False}
        report["cases"].append(case)
        for name in ["ordinary", "grouped", "explicit"]:
            original = (root / f"{name}.c").read_text()
            signature = "int main(int argc, char **argv)"
            if original.count(signature) != 1:
                raise ValueError(f"missing unique CLI main: {name}")
            original = original.replace(signature, "int unused_cli_main(int argc, char **argv)")
            entry = (root / f"{name}.entry").read_text().strip()
            code = original + harness.replace("@ENTRY@", entry).replace("@START@", "").replace("@STOP@", "")
            stem = f"{name}-{level}"
            cfile, binary = root / f"{stem}.c", root / f"{stem}.exe"
            cfile.write_text(code)
            flags = [f"-{level}", "-std=gnu11", "-ffp-contract=off", "-fno-fast-math", "-fstack-usage"]
            run([args.cc, *flags, cfile, "-o", binary, "-lm", "-lpthread"])
            listing = run([args.objdump, "-d", binary]).stdout
            if not listing.strip():
                raise ValueError(f"empty binary listing: {stem}")
            (root / f"{stem}.asm").write_text(listing)
            sections = run([args.objdump, "-h", binary]).stdout
            text_bytes = next(int(line.split()[2], 16) for line in sections.splitlines()
                              if len(line.split()) >= 3 and line.split()[1] == ".text")
            variant = {"binary": binary.name, "sha256": hashlib.sha256(binary.read_bytes()).hexdigest(),
                       "fileBytes": binary.stat().st_size, "textBytes": text_bytes,
                       "stackReports": {p.name: p.read_text() for p in root.glob(f"{stem}*.su")},
                       "profiles": [], "seconds": []}
            if not variant["stackReports"]:
                raise ValueError(f"missing stack-use report: {stem}")
            case["variants"][name] = variant
            marker = "typedef uint64_t V;"
            measured = original.replace(marker, marker + "\n" + profile)
            for marker, condition in [
                ("static inline void *fwp_alloc_init(size_t n) {", "1"),
                ("static inline void *fwp_heap_alloc(size_t n, int kind) {", "kind != 0"),
            ]:
                if measured.count(marker) != 1:
                    raise ValueError(f"missing allocation observer: {marker}")
                measured = measured.replace(marker, marker + f"if(mutual_active && ({condition})) mutual_allocations++;")
            measured += harness.replace("@ENTRY@", entry).replace("@START@", "mutual_active = 1;").replace(
                "@STOP@", 'mutual_active = 0; fprintf(stderr, "%llu %llu %llu\\n", mutual_calls, mutual_allocations, (unsigned long long)(mutual_high - mutual_low));')
            profile_c, profile_bin = root / f"{stem}-profile.c", root / f"{stem}-profile.exe"
            profile_c.write_text(measured)
            run([args.cc, *flags, "-finstrument-functions", profile_c, "-o", profile_bin, "-lm", "-lpthread"])
            for n in [16, args.iterations]:
                result = run([profile_bin, n, 2])
                if result.stdout != "1\n":
                    raise ValueError(f"wrong parity: {stem}: {result.stdout}")
                calls, allocations, stack = map(int, result.stderr.split())
                variant["profiles"].append({"input": n, "calls": calls, "allocations": allocations, "stackRange": stack})
            save()

        def timed(name):
            result = run([root / case["variants"][name]["binary"], args.iterations, args.repeats])
            # Evidence serialization and disk writes occur after the subprocess
            # timer stops; their growing cost is not program execution time.
            elapsed = commands[-1]["seconds"]
            if result.stdout != f"{args.repeats // 2}\n" or result.stderr:
                raise ValueError(f"wrong timed output: {name}: {result}")
            return elapsed

        for _ in range(args.warmups):
            for name in case["variants"]:
                timed(name)
        # Identical-binary alternating samples establish runner noise first.
        for _ in range(args.samples):
            case["controls"].append([timed("explicit"), timed("explicit")])
        names = list(case["variants"])
        for round_index in range(args.samples):
            offset = round_index % len(names)
            for name in names[offset:] + names[:offset]:
                case["variants"][name]["seconds"].append(timed(name))
        case.update(assess(case, report["budgets"]))
        save()
    # A measured rejection is evidence for the design decision, not a passing
    # implementation budget. The PR must explicitly accept or remove the prototype.
    print(json.dumps([{k: c[k] for k in ["level", "controlRatio", "groupedOverExplicit", "decision"]}
                      for c in report["cases"]], indent=2))


if __name__ == "__main__":
    main()
