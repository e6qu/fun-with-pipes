#!/usr/bin/env python3
"""Inspect captured Mach-O outputs and compile layout drivers from their C."""
import json
import os
from pathlib import Path
import platform
import re
import subprocess

root = Path(os.environ['FWP_LAYOUT_CAPTURE'])
cc = os.environ.get('FWP_LAYOUT_REAL_CC', 'clang')
machine = platform.machine()
headers = {
    'arm64': 'cffaedfe0c0000010000000002000000',
    'x86_64': 'cffaedfe070000010300000002000000',
}
assert machine in headers, machine
report = {
    'head': subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip(),
    'machine': machine,
    'hardware': subprocess.check_output(['sysctl', '-n', 'machdep.cpu.brand_string'], text=True).strip(),
    'os': subprocess.check_output(['sw_vers'], text=True),
    'compiler': subprocess.check_output([cc, '--version'], text=True),
    'limits': 'Original fault/observer fixtures; frames are not production ABI or speed guarantees. Allocation requests exclude allocator and collector metadata.',
    'groups': {},
}

folders = sorted(p for p in (root / 'constructor').iterdir() if p.is_dir())
assert len(folders) == 4
assert {p.name.split('-')[0] for p in folders} == {'O1', 'O2'}
records = []
for folder in folders:
    binary = folder / 'probe'; code = (folder / 'probe.c').read_text()
    assert binary.read_bytes()[:16].hex() == headers[machine]
    assembly = subprocess.check_output(['otool', '-tvV', str(binary)], text=True)
    (folder / 'disassembly.txt').write_text(assembly)
    (folder / 'symbols.txt').write_text(subprocess.check_output(['nm', '-nm', str(binary)], text=True))
    offset = code.index('/* Inner */\nstatic void fwp_drop')
    drop = re.search(r'static void (fwp_drop[0-9]+)\(', code[offset:]).group(1)
    needle = drop + '(c->'
    contexts = []
    for ctx, body in re.findall(r'static void fwp_owner_release[0-9]+\(void \*arg\) \{ (fwp_owner_ctx[0-9]+) \*c = arg; ([^\n]+) \}', code):
        if needle in body: contexts.append(ctx)
    assert bool(contexts) == (needle in code)
    lines = assembly.splitlines(); functions = {}
    for name in ['_main:', '_' + drop + ':']:
        if name not in lines: continue
        start = lines.index(name)
        end = next((i for i in range(start + 1, len(lines)) if re.match(r'^\S.*:$', lines[i])), len(lines))
        block = lines[start:end]
        (folder / (name[1:-1] + '.txt')).write_text('\n'.join(block) + '\n')
        functions[name] = {'instructions': sum(bool(re.match(r'^[0-9a-f]{16}\s+', line)) for line in block), 'prologue': block[1:14]}
    record = json.loads((folder / 'header.json').read_text())
    record.update(directory=folder.name, binaryBytes=binary.stat().st_size, functions=functions, typedInnerCleanup=bool(contexts), innerDrop=drop, typedOwnerContexts=contexts)
    records.append(record)
    if folder.name.startswith('O2-') and contexts:
        selected = folder; owner_types = contexts
for opt in ['O1', 'O2']:
    assert {r['typedInnerCleanup'] for r in records if r['directory'].startswith(opt+'-')} == {False, True}
printing = 'printf("V=%zu align=%zu object_header=%zu object_payload=%zu cleanup=%zu\\n",sizeof(V),_Alignof(V),sizeof(fwp_obj),offsetof(fwp_obj,f),sizeof(fwp_cleanup));'
for ctx in owner_types:
    printing += 'printf("' + ctx + '=%zu align=%zu\\n",sizeof(' + ctx + '),_Alignof(' + ctx + '));'
layout = root / 'constructor' / 'layout.c'
layout.write_text('#define main original_probe_main\n' + (selected / 'probe.c').read_text() + '\n#undef main\n#include <stddef.h>\nint main(void){' + printing + 'return 0;}\n')
args = json.loads((selected / 'args.json').read_text())
args = [str(layout) if arg.endswith('.c') else arg for arg in args]; args[args.index('-o') + 1] = str(root / 'constructor' / 'layout')
subprocess.run([cc, *args], check=True)
output = subprocess.check_output([str(root / 'constructor' / 'layout')], text=True).strip()
report['binaries'] = records; report['layout'] = output
(root / 'inspection.json').write_text(json.dumps(report, indent=2) + '\n')
print(machine, output)
