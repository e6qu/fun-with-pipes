#!/usr/bin/env python3
"""Inspect actual native stream-client binaries without executing them.

Retain disassembly and fingerprints for the typed cache destructor, receiving
function and iterator code. Review instructions to distinguish a cleanup loop
from recursive calls; stack-address samples alone do not show total frame size.
"""
import argparse
import hashlib
import json
from pathlib import Path
import re
import subprocess


def fingerprint(path):
    data = path.read_bytes()
    return {"bytes": len(data), "sha256": hashlib.sha256(data).hexdigest()}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--artifacts", type=Path, required=True)
    parser.add_argument("--objdump", required=True, help="LLVM objdump executable")
    parser.add_argument("--clients", nargs="+", choices=["unique", "full", "retained", "partial"], required=True)
    args = parser.parse_args()
    observations = []
    for client in args.clients:
        source = args.artifacts / f"{client}.c"
        code = source.read_text()
        drops = re.findall(r"static void (fwp_drop\d+)\(V v\) \{ g_cell_drop\(v, NULL\); \}", code)
        assert len(drops) == 1, (source, drops)
        iterator = re.search(r"/\* grpc\._iter :[^\n]*\*/\nstatic V (f\d+)\(", code)
        assert iterator, source
        symbols = [drops[0], iterator[1], "g_cell_drop", "g_force", "fwp_p_grpc_force", "fwp_apply_owned",
                   "g_stream_drop", "g_stream_reader_release", "g_unlink",
                   "g_sender_peer_finish", "g_conn_dead"]
        files = [args.artifacts / client, args.artifacts / f"{client}.exe"]
        files = [path for path in files if path.is_file()]
        assert len(files) == 1, files
        binary = files[0]
        header = subprocess.check_output([args.objdump, "--file-headers", str(binary)], text=True)
        if "Mach-O" in header or "mach-o" in header:
            command = [args.objdump, "--macho", "--disassemble", "--no-show-raw-insn",
                       "--disassemble-symbols=" + ",".join("_" + symbol for symbol in symbols), str(binary)]
        else:
            command = [args.objdump, "--no-show-raw-insn",
                       "--disassemble-symbols=" + ",".join(symbols), str(binary)]
        result = subprocess.run(command, capture_output=True, text=True, check=True)
        assembly = args.artifacts / f"{client}.asm"
        assembly.write_text(result.stdout)
        assert re.search(r"(?:<|_)" + re.escape(drops[0]) + r"(?:>|:)", result.stdout), (
            "typed cache cleanup symbol missing", binary, result.stderr)
        observations.append({"client": client, "source": fingerprint(source),
                             "binary": fingerprint(binary), "header": header,
                             "symbols": symbols, "command": command,
                             "assembly": {"file": assembly.name, **fingerprint(assembly)},
                             "diagnostics": result.stderr})
        print(f"{client}: {header.strip()}; saved {assembly.name}")
    output = {"source_revision": (args.artifacts / "source.txt").read_text().strip(),
              "tool": args.objdump, "observations": observations,
              "limits": "Static inspection only. No downloaded executable ran. Symbols inlined by the compiler can be absent; the typed cache destructor must be present. Disassembly requires human review for loops, frame sizes and register use. No timing claim."}
    (args.artifacts / "binary-observations.json").write_text(json.dumps(output, indent=2) + "\n")


if __name__ == "__main__":
    main()
