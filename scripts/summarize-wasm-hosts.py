#!/usr/bin/env python3
"""Inspect saved Wasm files as data and check the task ownership evidence."""
import argparse
import hashlib
import json
from pathlib import Path
import re


def integer(data, offset):
    value = 0
    for shift in range(0, 35, 7):
        byte = data[offset]
        offset += 1
        value |= (byte & 127) << shift
        if byte < 128:
            return value, offset
    raise ValueError("invalid varuint32")


def string(data, offset):
    size, offset = integer(data, offset)
    end = offset + size
    assert end <= len(data)
    return data[offset:end].decode("utf8"), end


def module(path):
    data = path.read_bytes()
    assert data[:8] == b"\0asm\1\0\0\0", path
    sections, exports, producers, names, memories = [], [], {}, [], []
    offset = 8
    while offset < len(data):
        kind = data[offset]
        size, start = integer(data, offset + 1)
        end = start + size
        assert end <= len(data)
        payload = data[start:end]
        section = {"id": kind, "payload_bytes": size, "offset": offset}
        if kind == 0:
            name, at = string(payload, 0)
            section["name"] = name
            if name == "producers":
                count, at = integer(payload, at)
                for _ in range(count):
                    field, at = string(payload, at)
                    entries, at = integer(payload, at)
                    producers[field] = {}
                    for _ in range(entries):
                        tool, at = string(payload, at)
                        version, at = string(payload, at)
                        producers[field][tool] = version
                assert at == len(payload)
            if name == "name":
                while at < len(payload):
                    subsection = payload[at]
                    length, begin = integer(payload, at + 1)
                    finish = begin + length
                    assert finish <= len(payload)
                    if subsection == 1:
                        count, position = integer(payload, begin)
                        for _ in range(count):
                            _, position = integer(payload, position)
                            name, position = string(payload, position)
                            names.append(name)
                        assert position == finish
                    at = finish
        elif kind == 5:
            count, at = integer(payload, 0)
            for _ in range(count):
                flags, at = integer(payload, at)
                assert flags & ~3 == 0, "expected 32-bit memory limits"
                minimum, at = integer(payload, at)
                maximum = None
                if flags & 1:
                    maximum, at = integer(payload, at)
                memories.append({"minimum_pages": minimum, "maximum_pages": maximum,
                                 "minimum_bytes": minimum * 65536, "shared": bool(flags & 2)})
            assert at == len(payload)
        elif kind == 7:
            count, at = integer(payload, 0)
            for _ in range(count):
                name, at = string(payload, at)
                export_kind = payload[at]
                index, at = integer(payload, at + 1)
                exports.append({"name": name, "kind": export_kind, "index": index})
            assert at == len(payload)
        sections.append(section)
        offset = end
    assert {"_start", "memory"} <= {entry["name"] for entry in exports}
    assert names and any(name.startswith("fwp_") for name in names), (
        path, "runtime function names are required for tracing inspection")
    collectors = [name for name in names if name.startswith(
        ("fwp_heap_scan", "fwp_heap_mark_all", "fwp_heap_sweep"))]
    assert not collectors, (path, collectors)
    return {"format": "WebAssembly 1, 32-bit memory", "bytes": len(data),
            "sha256": hashlib.sha256(data).hexdigest(), "sections": sections,
            "code_bytes": sum(s["payload_bytes"] for s in sections if s["id"] == 10),
            "memories": memories, "exports": exports, "producers": producers,
            "named_functions": len(names), "named_tracing_functions": collectors}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--artifacts", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--audit", type=Path, required=True)
    args = parser.parse_args()
    audit = json.loads(args.audit.read_text())
    assert re.fullmatch(r"[0-9a-f]{40}", audit["head"])
    assert args.artifacts.name == str(audit["run"])
    assert len(audit["jobs"]) == 2 and all(job["conclusion"] == "success" for job in audit["jobs"])
    expected_files = {f"tasks-{target}-{mode}-{label}{opt}.wasm"
                      for target in ["Wasi", "Browser"] for mode in ["jspi", "asyncify"]
                      for label in ["ordinary", "measured", "omitted", "missing-state"]
                      for opt in ["-O1", "-O2"]}
    expected_files |= {f"browser-{fixture}-{label}.wasm"
                       for fixture in ["json_exact_numbers", "browser_host_task"]
                       for label in ["ordinary", "measured"]}
    expected = (Path(__file__).resolve().parent.parent /
                "tests/fixtures/task_channel_ownership.out").read_bytes() * 16
    hosts = []
    for runner in ["ubuntu-latest", "ubuntu-24.04-arm"]:
        folder = args.artifacts / f"wasi-arc-{runner}"
        assert (folder / "revision.txt").read_text().strip() == audit["head"]
        toolchains = {name: (folder / f"{name}.txt").read_text().strip()
                      for name in ["host", "rust", "clang", "target", "binaryen", "node"]}
        assert all(toolchains.values())
        binaries = []
        for path in sorted(folder.glob("*.wasm")):
            entry = {"file": path.name, **module(path)}
            code = path.with_suffix(".c").read_bytes()
            assert b"FWP_ARC_ONLY" not in code
            assert b"FWP_RESOURCE_OWNERS" not in code
            entry["c_sha256"] = hashlib.sha256(code).hexdigest()
            if path.name.startswith("tasks-"):
                assert path.with_suffix(".stdout").read_bytes() == expected
                error = path.with_suffix(".stderr").read_text()
                control = "missing-state" if "missing-state" in path.name else (
                    "omitted" if "omitted" in path.name else None)
                entry["control"] = control
                if control:
                    match = re.search(r"unreleased: (\d+)/(\d+) allocations, (\d+)/(\d+) bytes, (\d+)/(\d+) counts", error)
                    assert match, (path, error)
                    live, base, size, base_size, counts, base_counts = map(int, match.groups())
                    entry["unreleased"] = {"allocations": live - base,
                                           "requested_bytes": size - base_size,
                                           "reference_count_entries": counts - base_counts}
                    if control == "missing-state":
                        assert live - base == 16 and size - base_size == 2048
                        assert b"fwp_leave(t); /* completed fiber storage */" not in code
                    else:
                        assert size - base_size > 64 * 1024**2
                        assert b"    fwp_fiber_tasks_finish();" not in code
                else:
                    assert not error, (path, error)
            binaries.append(entry)
        assert {entry["file"] for entry in binaries} == expected_files, runner
        hosts.append({"runner": runner, "toolchains": toolchains, "modules": binaries})
    assert {item["file"]: item["sha256"] for item in hosts[0]["modules"]} == {
        item["file"]: item["sha256"] for item in hosts[1]["modules"]}
    report = {"source": audit["head"], "run": audit["run"], "audit": audit,
              "compiler_flags": ["--target=wasm32-wasi", "-O1 or -O2", "-std=gnu11", "-ffp-contract=off", "-mllvm -wasm-enable-sjlj", "-Wl,-z,stack-size=33554432"],
              "asyncify_flags": ["--asyncify", "--debuginfo", "--pass-arg=asyncify-imports@fwp.none", "-O1 or -O2"],
              "scope": "Actual Wasm execution on AMD64 and ARM64 Linux hosts. Sixteen task/channel rounds match the raw interpreter and original golden. Ordinary and allocation-instrumented O1/O2 modules run through WASI and the generated browser loader, each with JSPI and Asyncify. Instrumented shutdown must hold no more malloc/calloc/realloc storage or count entries than the initialized baseline. Two deliberately broken controls must exceed that baseline. Four additional ordinary/measured modules exercise exact JSON and a suspended child through sequential, concurrent, reentrant and throwing output sinks. These are Node loader checks, not browser-engine coverage. No elapsed-time, C/Rust speed comparison, or host resident-memory measurement. Modules are inspected locally as data, never executed.",
              "limits": "The allocation ledger counts requested C allocation bytes, not JavaScript engine storage or resident RAM. WebAssembly linear memory retains its high-water capacity after free. JSPI uses host-managed continuation stacks; Asyncify additionally grows a 16 MiB plus one page unwind workspace. Ordinary task modules start with a 32 MiB main stack; individual task shadow stacks request 1 MiB and the runtime pools at most 64 until command cleanup. A JavaScript host still manages instances, promises and strings with its own memory system. Named-symbol inspection alone does not prove reclamation; the allocation checks and failing controls supply that evidence.",
              "matching_binaries_across_hosts": True, "hosts": hosts}
    args.output.write_text(json.dumps(report, indent=2) + "\n")
    print("72 modules inspected; 32 deliberate leak controls verified; host binaries match")


if __name__ == "__main__":
    main()
