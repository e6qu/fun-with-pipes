#!/usr/bin/env python3
"""Recompute a callable comparison from its retained files; never rerun it."""
import argparse
import base64
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess


SPEC = importlib.util.spec_from_file_location(
    "callable_collection", Path(__file__).with_name("check-returned-callables.py"))
COLLECT = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(COLLECT)


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def audit(folder, source, machine):
    report = json.loads((folder / "report.json").read_text())
    assert report["source"] == source and report["machine"] == machine
    assert report["scope"].startswith("No elapsed-time acceptance.")
    assert report["commands"] == "commands.jsonl"
    expected_programs = {f"{name}-O{level}{suffix}" for level in (1, 2)
                         for name, suffix in (("c", ""), ("rust", ""), ("fwp", ""), ("fwp", "-profile"))}
    assert set(report["programs"]) == expected_programs
    for path in (folder / "fixtures").iterdir():
        expected = subprocess.check_output(["git", "show", f"{source}:tests/fixtures/{path.name}"])
        assert path.read_bytes() == expected, path
    original = (folder / "generated.c").read_text()
    ordinary = COLLECT.SOURCE.boundary(original)
    profile = COLLECT.SOURCE.profile(ordinary)
    records = [json.loads(line) for line in (folder / "commands.jsonl").read_text().splitlines()]
    assert records and all(not row["timedOut"] for row in records)
    for record in records:
        assert isinstance(record["command"], list) and record["command"]
        assert all(isinstance(argument, str) for argument in record["command"])
        assert type(record["status"]) is int and type(record["rawInterpreter"]) is bool
        record["output"] = base64.b64decode(record["stdout"], validate=True)
        record["diagnostic"] = base64.b64decode(record["stderr"], validate=True)
    consumed = set()

    def one(predicate):
        matches = [index for index, row in enumerate(records) if predicate(row["command"])]
        assert len(matches) == 1, matches
        index, = matches
        assert index not in consumed
        consumed.add(index)
        return records[index]

    head = one(lambda command: command == ["git", "rev-parse", "HEAD"])
    assert head["output"].decode().strip() == source
    assert len(source) == 40 and all(c in "0123456789abcdef" for c in source)
    tools = {"cc": {row["command"][0] for row in records if "-fstack-usage" in row["command"]},
             "rustc": {row["command"][0] for row in records if "--emit=obj" in row["command"]},
             "objdump": {row["command"][4] for row in records if row["command"][1:3] == ["disassemble", "--json"]},
             "nm": {row["command"][0] for row in records if "--defined-only" in row["command"]},
             "size": {row["command"][0] for row in records if "--format=sysv" in row["command"]}}
    assert set(report["versions"]) == set(tools)
    for tool, commands in tools.items():
        assert len(commands) == 1
        executable, = commands
        record = one(lambda command: command == [executable, "--version"])
        assert record["output"].decode() == report["versions"][tool]
    host = one(lambda command: len(command) == 2 and command[1] == "-vV")
    assert host["output"].decode() == report["rustHost"]
    interpreters = [(i, row) for i, row in enumerate(records) if row["command"][1:3] == ["run", "--interp"]]
    assert len(interpreters) == 2 and {row["rawInterpreter"] for _, row in interpreters} == {False, True}
    for index, row in interpreters:
        consumed.add(index)
        assert row["output"] == b"(0, 0)\n(7, 14)\n(232, 464)\n(8415232, 16830464)\n"
    emit = one(lambda command: "--emit-c" in command)
    origin = Path(emit["command"][-1]).parent
    assert Path(emit["command"][-1]).name == "generated.c"
    assert emit["command"][1:] == ["build", "--fn", "callable-values", "--memory", "dynamic", "--emit-c", "-O2",
                                    str(origin / "fixtures/returned_callable_peer.fwp"), "-o", str(origin / "generated.c")]
    assert not emit["output"]
    summaries = {}
    for label in sorted(expected_programs):
        row = report["programs"][label]
        directory = folder / label
        language = label.split("-")[0]
        profiled = label.endswith("-profile")
        level = label.split("-")[1]
        implementation = directory / ("callable.rs" if language == "rust" else "callable.c")
        assert digest(implementation) == row["sourceSha256"]
        if language == "fwp":
            assert implementation.read_text() == (profile if profiled else ordinary)
        else:
            assert implementation.read_bytes() == (folder / "fixtures" / f"returned_callable_peer{implementation.suffix}").read_bytes()
        binary = directory / "callable"
        assert digest(binary) == row["binarySha256"] and binary.stat().st_size == row["binaryBytes"]
        assert COLLECT.binary_architecture(binary.read_bytes()) == machine
        c_frames = [frame for path in sorted(directory.glob("*.su")) for frame in COLLECT.FRAMES.c_frames(path.read_text())]
        assert c_frames and row["cFrames"] == c_frames
        if language == "rust":
            compile_record = one(lambda command: "--emit=obj" in command and str(origin / label / "callable.o") in command)
            command = compile_record["command"]
            assert "lto=no" in command and f"opt-level={level[1:]}" in command
            pass_names = [argument.removeprefix("remark=") for argument in command if argument.startswith("remark=")]
            assert len(pass_names) == 1
            assert compile_record["diagnostic"] == (directory / "rust-frames.jsonl").read_bytes()
            assert row["rustFrames"] == COLLECT.FRAMES.rust_frames(compile_record["diagnostic"].decode(), pass_names[0])
        else:
            compile_record = one(lambda command: "-c" in command and str(origin / label / "callable.o") in command)
            assert not row["rustFrames"]
        observer = one(lambda command: "-c" in command and str(origin / label / "observer.o") in command)
        link = one(lambda command: "-o" in command and command[-1] == str(origin / label / "callable"))
        for record in ([compile_record] if language != "rust" else []) + [observer]:
            assert f"-{level}" in record["command"] and "-fno-lto" in record["command"]
            assert "-fstack-usage" in record["command"]
            assert f"-DRETURNED_FWP={int(language == 'fwp')}" in record["command"]
            assert f"-DRETURNED_PROFILE={int(profiled)}" in record["command"]
        assert "-fno-lto" in link["command"]
        for record in (compile_record, observer, link):
            assert not record["output"] and record["status"] == 0
        expected = "".join(f"{kind} {n} {(kind+1)*(7*n+n*(n-1)//2)} {8 if language == 'fwp' else 16} 8\n"
                           for kind in range(2) for n in COLLECT.RESULTS.COUNTS)
        controls = {"success": dict(status=0, stdout=expected)}
        if language == "fwp":
            controls["omit-release"] = dict(status=78, stdout=expected)
            controls["recovery"] = dict(status=0, stdout="".join(f"recovered {kind} {n}\n" for kind in range(2) for n in (0, 8)))
        for case, message in (("add-max", "addition overflow"), ("add-min", "addition overflow"),
                              ("composition-add", "addition overflow"), ("mul-max", "multiplication overflow"),
                              ("mul-min", "multiplication overflow"), ("invalid-kind", "invalid callable kind")):
            for prefix in ("", "direct-"):
                status = 71 if case == "invalid-kind" else (101 if language == "fwp" else 70)
                stderr = ("fwp: trap: arithmetic overflow in I64" if status == 101 else message) + "\n"
                controls[prefix + case] = dict(status=status, stderr=stderr)
        assert row["controls"] == controls
        phases = {}
        for case, expected_result in controls.items():
            record = one(lambda command: command == [str(origin / label / "callable"), case])
            assert record["status"] == expected_result["status"]
            assert record["output"].decode() == expected_result.get("stdout", "")
            if "stdout" in expected_result:
                assert record["output"] == (directory / f"{case}.stdout").read_bytes()
                assert record["diagnostic"] == (directory / f"{case}.stderr").read_bytes()
                if profiled:
                    phases[case] = COLLECT.RESULTS.phases(record["diagnostic"].decode(), case)
                else:
                    assert not record["diagnostic"]
            else:
                assert record["diagnostic"].decode() == expected_result["stderr"]
        assert row["phases"] == phases
        if not profiled:
            listing = one(lambda command: command[1:3] == ["disassemble", "--json"] and command[-1] == str(origin / label / "callable"))
            decoded = json.loads(listing["output"])
            assert json.loads((directory / "instructions.json").read_text()) == decoded
            assert row["code"] == COLLECT.RESULTS.code_sizes(decoded["instructions"], language)
            for flag, filename in (("--format=sysv", "sections.txt"), ("--defined-only", "symbols.txt"), ("--undefined-only", "undefined.txt")):
                record = one(lambda command: len(command) == 3 and command[1] == flag
                             and Path(command[2]).parent == origin / label)
                assert record["output"] == (directory / filename).read_bytes()
                if flag == "--format=sysv":
                    assert row["sections"] == record["output"].decode()
                elif flag == "--undefined-only":
                    assert row["undefinedImplementationSymbols"] == record["output"].decode()
            summaries[label] = dict(code=row["code"], largestCFrameBytes=max(frame["bytes"] for frame in c_frames),
                                    largestRustFrameBytes=max(frame["bytes"] for frame in row["rustFrames"]) if language == "rust" else None)
    assert consumed == set(range(len(records))), "unexamined or duplicate command records"
    # Successful tool commands must stay diagnostic-free, except the exact Rust
    # frame remarks and explicitly inspected program phase streams above.
    for record in records:
        if Path(record["command"][0]).name == "callable":
            continue
        assert record["status"] == 0
        if not any(argument.startswith("remark=") for argument in record["command"]):
            assert not record["diagnostic"]
    return dict(source=source, machine=machine, programs=summaries,
                commandCount=len(records), decision="Correctness and storage baseline; no timing acceptance")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--input", type=Path, required=True)
    parser.add_argument("--source", required=True)
    parser.add_argument("--machine", choices=("aarch64", "x86_64"), required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    result = audit(args.input, args.source, args.machine)
    args.output.write_text(json.dumps(result, indent=2) + "\n")
    print(f"{result['commandCount']} commands and all eight programs recomputed; no timing claim")


if __name__ == "__main__":
    main()
