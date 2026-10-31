"""Separate preceding-call effects from constructor code using one executable."""
import json
import os
import shutil
import statistics
import subprocess
import time

from process_wait import run_capture

LABELS = ("reference", "reference-copy", "current", "current-copy")
PHASES = ("construction", "invocation", "release", "process")
ROUNDS = 20


def order(round_number):
    return [LABELS[(i + round_number) % 4] for i in (0, 1, 3, 2)]


def durations(stdout, kind, passes):
    fields = stdout.split()
    assert len(fields) == 4 and all(v.isdecimal() for v in fields)
    checksum, *times = map(int, fields)
    n, cycles = 4096, 256
    assert checksum == (kind + 1) * cycles * (passes * (n * (n - 1) // 2 + 7 * n) + n * passes * (passes - 1) // 2)
    assert all(value > 0 for value in times)
    return dict(zip(PHASES[:3], times, strict=True))


def summarize(samples):
    assert len(samples) == 4 * ROUNDS
    values = {phase: {label: [] for label in LABELS} for phase in PHASES}
    for i, row in enumerate(samples):
        r, p = divmod(i, 4)
        assert (row["round"], row["position"], row["label"]) == (r, p, order(r)[p])
        assert set(row["ns"]) == set(PHASES)
        assert all(type(v) is int and v > 0 for v in row["ns"].values())
        assert sum(row["ns"][phase] for phase in PHASES[:3]) <= row["ns"]["process"]
        for phase, value in row["ns"].items():
            values[phase][row["label"]].append(value)
    result = {}
    for phase, data in values.items():
        medians = {label: statistics.median(rows) for label, rows in data.items()}
        copies = {mode: max(medians[mode], medians[mode + "-copy"]) / min(medians[mode], medians[mode + "-copy"])
                  for mode in ("reference", "current")}
        result[phase] = dict(medianNs=medians, copyRatios=copies, currentOverReference=medians["current"] / medians["reference"],
                             qualified=all(v <= 1.02 for v in copies.values()) and all(v >= 5_000_000 for v in medians.values()))
    return result


def collect(args, root, out, original):
    assert os.environ.get("GITHUB_ACTIONS") == "true"
    out.mkdir(parents=True, exist_ok=False)
    saved = json.loads((root / "report.json").read_text())
    env = {key: value for key, value in os.environ.items() if not key.startswith("FWP_") and key not in ("GH_TOKEN", "GITHUB_TOKEN")}
    env.update(CC=args.cc, FWP_STACK="1", FWP_LTO="0", LC_ALL="C")
    commands = []

    def run(argv):
        argv = list(map(str, argv))
        started = time.perf_counter_ns()
        try:
            result = run_capture(argv, timeout=180, env=env, cwd=None, input_data=None, input_stream=None,
                                 text=True, encoding="utf-8", check=False)
        except subprocess.TimeoutExpired as error:
            (out / "timeout.json").write_text(json.dumps(dict(argv=argv, timeoutSeconds=180,
                stdout=repr(error.stdout), stderr=repr(error.stderr))) + "\n")
            raise
        row = dict(argv=argv, status=result.returncode, stdout=result.stdout, stderr=result.stderr,
                   elapsedNs=time.perf_counter_ns() - started)
        commands.append(row)
        with (out / "commands.jsonl").open("a") as log:
            log.write(json.dumps(row) + "\n")
        assert result.returncode == 0 and not result.stderr, row
        return len(commands) - 1

    code = (root / "fwp/implementation.c").read_text()
    signature = "static V fwp_apply_borrowed_span("
    assert code.count(signature) == 1
    start = code.index(signature)
    opening = code.index("{", start)
    end = original.SOURCE.OWNERSHIP.function_end(code, opening)
    reference = original.reference(code[start:end]).replace(signature, "static V returned_reference_span(", 1)
    code += "\n" + reference + "\nV returned_apply_reference(V f, uint32_t n, V *a) { return returned_reference_span(f,n,a,0,0); }\n"
    implementation = out / "implementation.c"
    implementation.write_text(code)
    observer = (root / "fixtures/returned_callable_time.c").read_text()
    replacements = (
        ('if (argc != 5 ||', 'if (argc != 6 ||'),
        ('|| strcmp(argv[4], "16")) return 73;', '|| (strcmp(argv[4], "0") && strcmp(argv[4], "1") && strcmp(argv[4], "16"))) return 73;'),
        ('const int64_t population = 4096, cycles = 256, passes = 16;',
         'const int64_t population = 4096, cycles = 256, passes = strtoll(argv[4], NULL, 10);\n'
         '    if (strcmp(argv[5], "reference") && strcmp(argv[5], "current")) return 73;\n'
         '    uint64_t (*apply)(uint64_t, uint32_t, uint64_t *) = strcmp(argv[5], "reference") == 0 ? returned_apply_reference : fwp_apply_borrowed;'),
        ('fwp_apply_borrowed(values[i], 1, &input)', 'apply(values[i], 1, &input)'),
        ('#include "callable_phase_clock.h"', '#include "callable_phase_clock.h"\nuint64_t returned_apply_reference(uint64_t, uint32_t, uint64_t *);'),
    )
    for old, new in replacements:
        observer = original.SOURCE.replace_once(observer, old, new)
    caller = out / "observer.c"
    caller.write_text(observer)
    flags = [args.cc, *saved["settings"]["cFlags"], "-DRETURNED_FWP=1"]
    for source, obj in ((implementation, out / "implementation.o"), (caller, out / "observer.o")):
        index = run([*flags, "-c", source, "-o", obj])
        assert not commands[index]["stdout"]
    binary = out / "program"
    index = run([args.cc, "-fno-lto", out / "implementation.o", out / "observer.o", root / "clock.o", "-lm", "-lpthread", "-o", binary])
    assert not commands[index]["stdout"]
    original.BINARY.native(binary, args.arch)
    copy = out / "copy/program"
    copy.parent.mkdir()
    shutil.copy2(binary, copy)
    assert original.BINARY.digest(copy) == original.BINARY.digest(binary)
    report = dict(source=args.source, architecture=args.arch, compilerVersion=saved["versions"]["cc"],
                  binarySha256=original.BINARY.digest(binary), cpu=commands[run(["lscpu"])]["stdout"],
                  scope="One binary, two invocation entries, identical constructor/allocator. Diagnostic only; original acceptance remains unchanged.", sessions=[])
    for session in (1, 2):
        cases = []
        report["sessions"].append(dict(session=session, cases=cases))
        for kind in (0, 1):
            for passes in (0, 1, 16):
                row = dict(kind=kind, passes=passes, warmups=[], samples=[])
                cases.append(row)
                for r in range(-2, ROUNDS):
                    for position, label in enumerate(order(r + 2 if r < 0 else r)):
                        mode = label.removesuffix("-copy")
                        index = run([copy if label.endswith("-copy") else binary, kind, 4096, 256, passes, mode])
                        ns = durations(commands[index]["stdout"], kind, passes)
                        ns["process"] = commands[index]["elapsedNs"]
                        if r < 0:
                            row["warmups"].append(index)
                        else:
                            row["samples"].append(dict(round=r, position=position, label=label, command=index, ns=ns))
                    (out / "report.json").write_text(json.dumps(report, indent=2) + "\n")
                row["summary"] = summarize(row["samples"])
                print("CONTEXT", args.arch, session, kind, passes, json.dumps(row["summary"]), flush=True)
                (out / "report.json").write_text(json.dumps(report, indent=2) + "\n")
    # Recheck every retained sample against its invocation and original output.
    for session in report["sessions"]:
        for row in session["cases"]:
            assert row["summary"] == summarize(row["samples"])
            for sample in row["samples"]:
                cmd = commands[sample["command"]]
                label = sample["label"]
                assert cmd["argv"] == list(map(str, [copy if label.endswith("-copy") else binary,
                    row["kind"], 4096, 256, row["passes"], label.removesuffix("-copy")]))
                ns = durations(cmd["stdout"], row["kind"], row["passes"])
                ns["process"] = cmd["elapsedNs"]
                assert sample["ns"] == ns
    manifest = {str(p.relative_to(out)): original.BINARY.digest(p) for p in out.rglob("*") if p.is_file()}
    (out / "manifest.json").write_text(json.dumps(manifest, indent=2) + "\n")
