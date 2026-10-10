#!/usr/bin/env python3
"""Retain exact effects golden compiler inputs without changing compilation."""
from pathlib import Path
import json, os, shutil, subprocess, sys
args = sys.argv[1:]
sources = [Path(arg) for arg in args if arg.endswith("-effects.c")]
out = Path(os.environ["FWP_EFFECTS_CAPTURE"])
if sources:
    assert len(sources) == 1
    out.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(sources[0], out / "effects.c")
    (out / "compiler-args.json").write_text(json.dumps(args, indent=2) + "\n")
result = subprocess.run(["/usr/bin/clang", *args])
if sources and result.returncode == 0:
    target = Path(args[args.index("-o") + 1])
    shutil.copyfile(target, out / "effects-original")
    (out / "effects-original").chmod(target.stat().st_mode)
sys.exit(result.returncode)
