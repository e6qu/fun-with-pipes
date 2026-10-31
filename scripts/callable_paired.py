"""Compare invocation modes within one process with balanced batch order."""
import json
from pathlib import Path
import statistics

from callable_context import LABELS, ROUNDS, audit_files, durations, order, prepare

MODES = ("reference", "current")
PHASES = ("construction", "invocation", "release")


def parse(stdout, kind, passes):
    fields = stdout.split()
    assert len(fields) == 8
    return {mode: durations(" ".join(fields[i * 4:(i + 1) * 4]), kind, passes)
            for i, mode in enumerate(MODES)}


def summarize(samples, passes):
    assert len(samples) == 4 * ROUNDS
    values = {phase: {mode: {label: [] for label in LABELS} for mode in MODES} for phase in PHASES}
    ratios = {phase: {label: [] for label in LABELS} for phase in PHASES}
    for i, row in enumerate(samples):
        r, p = divmod(i, 4)
        assert (row["round"], row["position"], row["label"]) == (r, p, order(r)[p])
        ns, label = row["ns"], row["label"]
        assert set(ns) == {*MODES, "process"}
        assert type(ns["process"]) is int and ns["process"] > 0
        for mode in MODES:
            assert set(ns[mode]) == set(PHASES)
            assert all(type(v) is int and v > 0 for v in ns[mode].values())
        assert sum(sum(ns[mode].values()) for mode in MODES) <= ns["process"]
        for phase in PHASES:
            for mode in MODES:
                values[phase][mode][label].append(ns[mode][phase])
            ratios[phase][label].append(ns["current"][phase] / ns["reference"][phase])
    result = {}
    for phase, modes in values.items():
        medians = {mode: {label: statistics.median(rows) for label, rows in labels.items()}
                   for mode, labels in modes.items()}
        copies = {mode: {first: max(rows[first], rows[first + "-copy"]) / min(rows[first], rows[first + "-copy"])
                         for first in MODES} for mode, rows in medians.items()}
        paired = {label: statistics.median(rows) for label, rows in ratios[phase].items()}
        qualified = all(v <= 1.02 for row in copies.values() for v in row.values()) and all(
            v >= 5_000_000 for row in medians.values() for v in row.values())
        result[phase] = dict(medianNs=medians, copyRatios=copies, pairedCurrentOverReference=paired,
                             qualified=qualified,
                             identicalWorkWithinLimit=all(1 / 1.02 <= v <= 1.02 for v in paired.values())
                             if passes == 0 and qualified else None)
    return result


def audit(folder, source, architecture):
    report, commands, original = audit_files(folder, source, architecture)
    assert report["settings"] == dict(population=4096, batchesPerMode=256, calls=[0, 1, 16],
                                      rounds=20, warmups=2, copyLimit=1.02, minimumPhaseNs=5_000_000,
                                      batchOrders=["ABBA", "BAAB"])
    assert [row["session"] for row in report["sessions"]] == [1, 2]
    index = 4
    for session in report["sessions"]:
        assert [(row["kind"], row["passes"]) for row in session["cases"]] == [
            (kind, passes) for kind in (0, 1) for passes in (0, 1, 16)]
        for case in session["cases"]:
            assert case["summary"] == summarize(case["samples"], case["passes"])
            assert len(case["warmups"]) == 8
            observations = [(number, order(i // 4)[i % 4], None) for i, number in enumerate(case["warmups"])]
            observations += [(row["command"], row["label"], row["ns"]) for row in case["samples"]]
            for number, label, expected in observations:
                assert number == index
                cmd = commands[index]
                binary = original / ("copy/program" if label.endswith("-copy") else "program")
                assert cmd["argv"] == list(map(str, [binary, case["kind"], 4096, 256,
                                                      case["passes"], label.removesuffix("-copy")]))
                ns = parse(cmd["stdout"], case["kind"], case["passes"])
                assert type(cmd["elapsedNs"]) is int and sum(sum(v.values()) for v in ns.values()) <= cmd["elapsedNs"]
                ns["process"] = cmd["elapsedNs"]
                if expected is not None:
                    assert ns == expected
                index += 1
    assert index == len(commands)
    actual_model = next(line.split(":", 1)[1].strip() for line in report["cpu"].splitlines() if line.startswith("Model name:"))
    assert report["cpuModel"] == actual_model
    assert report["matchesOriginalCpu"] == (actual_model == report["originalCpuModel"])
    return report


def collect(args, root, out, original):
    observer = (Path(__file__).resolve().parent.parent / "tests/fixtures/returned_callable_paired_time.c").read_text()
    saved, commands, run, binary, copy = prepare(args, root, out, original, observer)
    cpu = commands[run(["lscpu"])]["stdout"]
    model = lambda text: next(line.split(":", 1)[1].strip() for line in text.splitlines() if line.startswith("Model name:"))
    report = dict(source=args.source, architecture=args.arch, compilerVersion=saved["versions"]["cc"],
                  binarySha256=original.BINARY.digest(binary), cpu=cpu, cpuModel=model(cpu),
                  originalCpuModel=model(saved["cpu"]), matchesOriginalCpu=model(cpu) == model(saved["cpu"]),
                  settings=dict(population=4096, batchesPerMode=256, calls=[0, 1, 16], rounds=20,
                                warmups=2, copyLimit=1.02, minimumPhaseNs=5_000_000, batchOrders=["ABBA", "BAAB"]),
                  scope="Both modes in one process and allocator; per-process paired phase ratios. Diagnostic only.", sessions=[])
    (out / "report.json").write_text(json.dumps(report, indent=2) + "\n")
    print("PAIRED_HOST", args.arch, json.dumps({key: report[key] for key in ("cpuModel", "originalCpuModel", "matchesOriginalCpu")}), flush=True)
    for session in (1, 2):
        cases = []
        report["sessions"].append(dict(session=session, cases=cases))
        for kind in (0, 1):
            for passes in (0, 1, 16):
                row = dict(kind=kind, passes=passes, warmups=[], samples=[])
                cases.append(row)
                for r in range(-2, ROUNDS):
                    for position, label in enumerate(order(r + 2 if r < 0 else r)):
                        index = run([copy if label.endswith("-copy") else binary, kind, 4096, 256,
                                     passes, label.removesuffix("-copy")])
                        ns = parse(commands[index]["stdout"], kind, passes)
                        ns["process"] = commands[index]["elapsedNs"]
                        if r < 0:
                            row["warmups"].append(index)
                        else:
                            row["samples"].append(dict(round=r, position=position, label=label, command=index, ns=ns))
                    (out / "report.json").write_text(json.dumps(report, indent=2) + "\n")
                row["summary"] = summarize(row["samples"], passes)
                print("PAIRED", args.arch, session, kind, passes, json.dumps(row["summary"]), flush=True)
                (out / "report.json").write_text(json.dumps(report, indent=2) + "\n")
    manifest = {str(p.relative_to(out)): original.BINARY.digest(p) for p in out.rglob("*") if p.is_file()}
    (out / "manifest.json").write_text(json.dumps(manifest, indent=2) + "\n")
    audit(out, args.source, args.arch)
