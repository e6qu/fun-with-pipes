#!/usr/bin/env python3
"""Delegate unchanged test compiler arguments and retain selected real outputs."""
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys

args = sys.argv[1:]
sources = [Path(arg) for arg in args if arg.endswith('.c')]
markers = {'retain': b'static volatile V first, last, scalar_word;'}
destination = None
if sources:
    data = sources[0].read_bytes()
    matches = [name for name, marker in markers.items() if marker in data]
    if matches:
        assert len(matches) == len(sources) == 1
        option = next(arg for arg in args if arg in ['-O1', '-O2'])
        digest = hashlib.sha256(data).hexdigest()
        destination = Path(os.environ['FWP_LAYOUT_CAPTURE']) / matches[0] / (option[1:] + '-' + digest[:12])
        destination.mkdir(parents=True, exist_ok=False)
        (destination / 'probe.c').write_bytes(data)
        (destination / 'args.json').write_text(json.dumps(args, indent=2) + '\n')
        target = Path(args[args.index('-o') + 1])
result = subprocess.run([os.environ.get('FWP_LAYOUT_REAL_CC', 'clang'), *args])
if destination and result.returncode == 0:
    shutil.copyfile(target, destination / 'probe')
    (destination / 'probe').chmod(target.stat().st_mode)
    (destination / 'header.json').write_text(json.dumps({
        'header': target.read_bytes()[:16].hex(), 'sourceSha256': digest,
    }, indent=2) + '\n')
sys.exit(result.returncode)
