#!/usr/bin/env python3
"""Retain original nominal-match fixtures, machine code and compiled layouts."""
import hashlib
import json
import os
from pathlib import Path
import platform
import re
import subprocess

root = Path(os.environ['FWP_LAYOUT_CAPTURE'])
cc = os.environ.get('FWP_LAYOUT_REAL_CC', 'clang')
machine = platform.machine()
headers = {'arm64': 'cffaedfe0c0000010000000002000000',
           'x86_64': 'cffaedfe070000010300000002000000'}
assert machine in headers
report = {
    'head': subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip(),
    'machine': machine,
    'hardware': subprocess.check_output(['sysctl', '-n', 'machdep.cpu.brand_string'], text=True).strip(),
    'os': subprocess.check_output(['sw_vers'], text=True),
    'compiler': subprocess.check_output([cc, '--version'], text=True),
    'limits': 'Original instrumented fixtures; static instructions are not dynamic execution, allocation counts or speed. No general ABI, cache or frame guarantee.',
}
folders = sorted(p for p in (root / 'match').iterdir() if p.is_dir())
assert len(folders) == 6
records = []
for folder in folders:
    binary = folder / 'probe'
    code = (folder / 'probe.c').read_text()
    assert binary.read_bytes()[:16].hex() == headers[machine]
    source = '/* string.repeat :' in code
    start = code.index('/* discard :')
    end = code.index('/* other :' if source else '/* repeat :', start)
    body = code[start:end]
    assert 'fwp_data(0, 2' not in body
    typed = len(re.findall(r'\bfwp_drop[0-9]+\(', body))
    assembly = subprocess.check_output(['otool', '-tvV', str(binary)], text=True)
    (folder / 'disassembly.txt').write_text(assembly)
    (folder / 'symbols.txt').write_text(subprocess.check_output(['nm', '-nm', str(binary)], text=True))
    lines = assembly.splitlines()
    functions = {}
    for name in ['_main:', *[line for line in lines if re.fullmatch(r'_f[0-9]+:', line)]]:
        if name not in lines:
            continue
        a = lines.index(name)
        b = next((i for i in range(a + 1, len(lines)) if re.match(r'^\S.*:$', lines[i])), len(lines))
        block = lines[a:b]
        (folder / (name[1:-1] + '.txt')).write_text('\n'.join(block) + '\n')
        functions[name] = {'instructions': sum(bool(re.match(r'^[0-9a-f]{16}\s+', line)) for line in block), 'prologue': block[1:14]}
    record = json.loads((folder / 'header.json').read_text())
    assert record['sourceSha256'] == hashlib.sha256(code.encode()).hexdigest()
    record.update(directory=folder.name, binaryBytes=binary.stat().st_size,
                  fixture='source' if source else 'IR', typedDiscardCalls=typed, functions=functions)
    records.append(record)
for opt in ['O1', 'O2']:
    selected = [r for r in records if r['directory'].startswith(opt + '-')]
    assert len(selected) == 3
    assert sum(r['fixture'] == 'source' for r in selected) == 1
    ir = [r for r in selected if r['fixture'] == 'IR']
    assert len(ir) == 2
    assert len({r['typedDiscardCalls'] for r in ir}) == 2
positive = next(r for r in records if r['directory'].startswith('O2-') and r['fixture'] == 'source')
selected = root / 'match' / positive['directory']
code = (selected / 'probe.c').read_text()
layout = root / 'match' / 'layout.c'
layout.write_text('#define main original_probe_main\n' + code + '\n#undef main\n#include <stddef.h>\nint main(void){printf("V=%zu align=%zu object_header=%zu object_align=%zu payload=%zu cleanup=%zu\\n",sizeof(V),_Alignof(V),sizeof(fwp_obj),_Alignof(fwp_obj),offsetof(fwp_obj,f),sizeof(fwp_cleanup));return 0;}\n')
args = json.loads((selected / 'args.json').read_text())
args = [str(layout) if arg.endswith('.c') else arg for arg in args]
args[args.index('-o') + 1] = str(root / 'match' / 'layout')
subprocess.run([cc, *args], check=True)
report['binaries'] = records
report['layoutSourceSha256'] = positive['sourceSha256']
report['layout'] = subprocess.check_output([str(root / 'match' / 'layout')], text=True).strip()
(root / 'inspection.json').write_text(json.dumps(report, indent=2) + '\n')
print(machine, report['layout'])
