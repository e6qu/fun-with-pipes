#!/usr/bin/env python3
"""Inspect the unchanged boxed-record conversion test's real Mach-O outputs."""
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
assert machine in headers, machine
report = {
    'head': subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip(),
    'machine': machine,
    'hardware': subprocess.check_output(['sysctl', '-n', 'machdep.cpu.brand_string'], text=True).strip(),
    'os': subprocess.check_output(['sw_vers'], text=True),
    'compiler': subprocess.check_output([cc, '--version'], text=True),
    'limits': 'Original fault/observer fixtures; no production frame, ABI, speed or cache claim. Context sizes are not summed into a frame.',
}
folders = sorted(p for p in (root / 'conversion').iterdir() if p.is_dir())
assert len(folders) == 8
assert {p.name.split('-')[0] for p in folders} == {'O1', 'O2'}
records = []
for folder in folders:
    binary = folder / 'probe'
    code = (folder / 'probe.c').read_text()
    assert binary.read_bytes()[:16].hex() == headers[machine]
    assembly = subprocess.check_output(['otool', '-tvV', str(binary)], text=True)
    (folder / 'disassembly.txt').write_text(assembly)
    (folder / 'symbols.txt').write_text(subprocess.check_output(['nm', '-nm', str(binary)], text=True))
    lines = assembly.splitlines()
    functions = {}
    for name in ['_main:', *[line for line in lines if re.fullmatch(r'_(?:fwp_vdup|fwp_vunbox|f)[0-9]+:', line)]]:
        if name not in lines:
            continue
        start = lines.index(name)
        end = next((i for i in range(start + 1, len(lines)) if re.match(r'^\S.*:$', lines[i])), len(lines))
        block = lines[start:end]
        (folder / (name[1:-1] + '.txt')).write_text('\n'.join(block) + '\n')
        functions[name] = {'instructions': sum(bool(re.match(r'^[0-9a-f]{16}\s+', line)) for line in block), 'prologue': block[1:14]}
    holder = re.search(r'static V f([0-9]+)\(', code[code.index('/* holder :'):]).group(1)
    start = code.index('static V f' + holder + '(V l0, V l1) {')
    worker = code[start:code.index('\n}', start)]
    retained = [line for line in worker.splitlines() if '= {0, 0}' in line and 'fwp_rc_dup(' in line]
    assert len(retained) == 1
    line_start = worker.index(retained[0])
    point = worker.index('fwp_rc_dup(', line_start)
    active = []
    for operation, node in re.findall(r'fwp_cleanup_(push|pop)\(&([A-Za-z_][A-Za-z_0-9]*)', worker[:point]):
        if operation == 'push':
            active.append(node)
        else:
            assert active and active[-1] == node, (operation, node, active)
            active.pop()
    record = json.loads((folder / 'header.json').read_text())
    record.update(directory=folder.name, binaryBytes=binary.stat().st_size,
                  functions=functions, holder='f' + holder, activeConversionScopes=active)
    records.append(record)
maximum = max(len(record['activeConversionScopes']) for record in records)
assert maximum >= 3
positive = next(record for record in records if len(record['activeConversionScopes']) == maximum)
scopes = positive['activeConversionScopes']
assert {tuple(record['activeConversionScopes']) for record in records} == {
    tuple(scopes), *[tuple(scopes[:i] + scopes[i + 1:]) for i in range(len(scopes) - 3, len(scopes))]}
assert all(sum(record['directory'].startswith(opt + '-') and len(record['activeConversionScopes']) == maximum for record in records) == 1 for opt in ['O1', 'O2'])
selected = next(root / 'conversion' / record['directory'] for record in records
                if record['directory'].startswith('O2-') and len(record['activeConversionScopes']) == maximum)
code = (selected / 'probe.c').read_text()
start = code.index('static V ' + positive['holder'] + '(V l0, V l1) {')
worker = code[start:code.index('\n}', start)]
contexts = sorted(set(re.findall(r'\b(fwp_owner_ctx[0-9]+)\b', worker)), key=lambda name: int(name.removeprefix('fwp_owner_ctx')))
assert len(contexts) >= 2
printing = 'printf("V=%zu align=%zu object_header=%zu payload=%zu cleanup=%zu wide_entry=%zu wide_count=%zu\\n",sizeof(V),_Alignof(V),sizeof(fwp_obj),offsetof(fwp_obj,f),sizeof(fwp_cleanup),sizeof(gc_rc_wide),offsetof(gc_rc_wide,count));'
for context in contexts:
    printing += 'printf("' + context + '=%zu align=%zu\\n",sizeof(' + context + '),_Alignof(' + context + '));'
layout = root / 'conversion' / 'layout.c'
layout.write_text('#define main original_probe_main\n' + code + '\n#undef main\n#include <stddef.h>\nint main(void){' + printing + 'return 0;}\n')
args = json.loads((selected / 'args.json').read_text())
args = [str(layout) if arg.endswith('.c') else arg for arg in args]
args[args.index('-o') + 1] = str(root / 'conversion' / 'layout')
subprocess.run([cc, *args], check=True)
report['binaries'] = records
report['holderOwnerContexts'] = contexts
report['layoutSourceSha256'] = __import__('hashlib').sha256(code.encode()).hexdigest()
report['layout'] = subprocess.check_output([str(root / 'conversion' / 'layout')], text=True).strip()
(root / 'inspection.json').write_text(json.dumps(report, indent=2) + '\n')
print(machine, report['layout'])
