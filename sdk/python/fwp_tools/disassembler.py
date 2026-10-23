"""Inspect binaries and compare target-specific C across optimization levels.

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
    fwp_target: str
    triple: str | None
    sysroot: str | None


class Disassembler:
    def __init__(self, *, fwp: str, llvm_objdump: str, timeout: float):
        if timeout <= 0:
            raise ValueError("timeout must be positive")
        self.fwp = fwp
        self.llvm_objdump = llvm_objdump
        self.timeout = timeout

    def _run(self, command):
        result = subprocess.run(command, capture_output=True, text=True, encoding="utf-8", timeout=self.timeout)
        if result.returncode:
            raise RuntimeError(f"command failed ({result.returncode}): {command!r}\n{result.stdout}{result.stderr}")
        return result

    def inspect(self, binary: str | Path):
        """Structured addresses, raw encoding spelling, C locations and assembly."""
        return json.loads(self._run([self.fwp, "disassemble", "--json", "--tool", self.llvm_objdump, str(binary)]).stdout)

    def compare(self, source: str | Path, directory: str | Path, *, targets: list[Target],
                levels: tuple[str, ...], ownership: str):
        """Compile debug objects, retain emitted C and inspect every requested pair.

        Generated objects contain the emitted C translation unit. External float,
        TLS and other linked libraries are not folded into this object's listing;
        inspect a fully linked executable separately to inspect those components.
        ownership selects checked "arc" or explicit "tracing" generation and is
        recorded with the compiler command; no compiler default is inferred.
        Target.fwp_target selects fwp's C generation target (native or a supported
        Linux triple). Target.triple selects Clang's --target; a cross-GCC executable instead
        selects its target itself and should use triple=None. sysroot=None uses
        the selected compiler's header search configuration.
        """
        if ownership not in {"arc", "tracing"}:
            raise ValueError("ownership must be arc or tracing")
        if not targets or not levels or len(set(levels)) != len(levels):
            raise ValueError("choose at least one target and distinct optimization levels")
        if any(level not in {"O0", "O1", "O2", "O3", "Os", "Oz", "Og"} for level in levels):
            raise ValueError("optimization levels are O0, O1, O2, O3, Os, Oz or Og")
        if len({target.name for target in targets}) != len(targets):
            raise ValueError("target names must be distinct")
        if any(not re.fullmatch(r"[A-Za-z0-9_-]+", target.name) for target in targets):
            raise ValueError("target names use letters, digits, underscores and hyphens")
        source = Path(source).resolve()
        directory = Path(directory).resolve()
        directory.mkdir(parents=True, exist_ok=False)
        report = {"source": str(source), "source_text": source.read_text(encoding="utf-8"),
                  "executed": False, "ownership": ownership, "kind": "relocatable objects", "targets": [], "variants": []}
        for target in targets:
            generated = directory / f"{target.name}.c"
            emit_command = [self.fwp, "build", "--gc", ownership, "--emit-c", "--target", target.fwp_target,
                            str(source), "-o", str(generated)]
            emitted = self._run(emit_command)
            report["targets"].append({"name": target.name, "fwp_target": target.fwp_target,
                "generated_c": generated.read_text(encoding="utf-8"), "c_file": str(generated),
                "c_sha256": hashlib.sha256(generated.read_bytes()).hexdigest(),
                "emit_command": emit_command, "emit_stdout": emitted.stdout, "emit_stderr": emitted.stderr})
            version = self._run([target.compiler, "--version"]).stdout
            for level in levels:
                binary = directory / f"{target.name}-{level}.o"
                command = [target.compiler, f"-{level}", "-g", "-std=gnu11", "-ffp-contract=off", "-fno-fast-math", "-c"]
                if target.triple:
                    command += ["--target=" + target.triple]
                if target.sysroot:
                    command += ["--sysroot=" + target.sysroot]
                command += [str(generated), "-o", str(binary)]
                compiled = self._run(command)
                listing = self.inspect(binary)
                report["variants"].append({"target": target.name, "triple": target.triple,
                                           "optimization": level, "compiler_version": version,
                                           "compiler_stdout": compiled.stdout, "compiler_stderr": compiled.stderr,
                                           "command": command, "binary_sha256": hashlib.sha256(binary.read_bytes()).hexdigest(),
                                           **listing})
                (directory / "report.json").write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
        return report
