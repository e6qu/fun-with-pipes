"""Inspect binaries and compare the same emitted C across targets/optimizations.

Cross-target objects are inspected, not executed. Each target needs its own
working C compiler and headers/sysroot. The caller selects these explicitly.
"""
from __future__ import annotations

from dataclasses import dataclass
import hashlib
import json
from pathlib import Path
import re
import subprocess


@dataclass(frozen=True)
class Target:
    name: str
    compiler: str
    triple: str | None = None
    sysroot: str | None = None


class Disassembler:
    def __init__(self, *, fwp: str = "fwp", llvm_objdump: str = "llvm-objdump", timeout: float = 180):
        if timeout <= 0:
            raise ValueError("timeout must be positive")
        self.fwp = fwp
        self.llvm_objdump = llvm_objdump
        self.timeout = timeout

    def _run(self, command):
        result = subprocess.run(command, capture_output=True, text=True, encoding="utf-8", timeout=self.timeout)
        if result.returncode:
            raise RuntimeError(f"command failed ({result.returncode}): {command!r}\n{result.stdout}{result.stderr}")
        return result.stdout

    def inspect(self, binary: str | Path):
        """Structured addresses, raw encoding spelling, C locations and assembly."""
        return json.loads(self._run([self.fwp, "disassemble", "--json", "--tool", self.llvm_objdump, str(binary)]))

    def compare(self, source: str | Path, directory: str | Path, *, targets: list[Target],
                levels: tuple[str, ...] = ("O0", "O1", "O2", "O3")):
        """Compile debug objects, retain emitted C and inspect every requested pair.

        Generated objects contain the emitted C translation unit. External float,
        TLS and other linked libraries are not folded into this object's listing;
        inspect a fully linked executable separately to inspect those components.
        Target.triple selects Clang's --target; a cross-GCC executable instead
        selects its target itself and should leave triple unset.
        """
        if not targets or not levels or len(set(levels)) != len(levels):
            raise ValueError("choose at least one target and distinct optimization levels")
        if any(level not in {"O0", "O1", "O2", "O3"} for level in levels):
            raise ValueError("optimization levels are O0, O1, O2 or O3")
        if len({target.name for target in targets}) != len(targets):
            raise ValueError("target names must be distinct")
        if any(not re.fullmatch(r"[A-Za-z0-9_-]+", target.name) for target in targets):
            raise ValueError("target names use letters, digits, underscores and hyphens")
        source = Path(source).resolve()
        directory = Path(directory).resolve()
        directory.mkdir(parents=True, exist_ok=False)
        generated = directory / "generated.c"
        self._run([self.fwp, "build", "--emit-c", str(source), "-o", str(generated)])
        c_source = generated.read_text()
        report = {"source": str(source), "source_text": source.read_text(), "generated_c": c_source,
                  "c_sha256": hashlib.sha256(generated.read_bytes()).hexdigest(),
                  "executed": False, "kind": "relocatable objects", "variants": []}
        for target in targets:
            version = self._run([target.compiler, "--version"])
            for level in levels:
                binary = directory / f"{target.name}-{level}.o"
                command = [target.compiler, f"-{level}", "-g", "-std=gnu11", "-ffp-contract=off", "-fno-fast-math", "-c"]
                if target.triple:
                    command += ["--target=" + target.triple]
                if target.sysroot:
                    command += ["--sysroot=" + target.sysroot]
                command += [str(generated), "-o", str(binary)]
                self._run(command)
                listing = self.inspect(binary)
                report["variants"].append({"target": target.name, "triple": target.triple,
                                           "optimization": level, "compiler_version": version,
                                           "command": command, "binary_sha256": hashlib.sha256(binary.read_bytes()).hexdigest(),
                                           **listing})
                (directory / "report.json").write_text(json.dumps(report, indent=2) + "\n")
        return report
