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
folders = sorted(p for p in (root / 'retain').iterdir() if p.is_dir())
assert len(folders) == 6
assert {p.name.split('-')[0] for p in folders} == {'O1', 'O2'}
records = []
for folder in folders:
    binary = folder / 'probe'; code = (folder / 'probe.c').read_text()
    assert binary.read_bytes()[:16].hex() == headers[machine]
    assembly = subprocess.check_output(['otool', '-tvV', str(binary)], text=True)
    (folder / 'disassembly.txt').write_text(assembly)
    (folder / 'symbols.txt').write_text(subprocess.check_output(['nm', '-nm', str(binary)], text=True))
    lines = assembly.splitlines(); functions = {}
    names = ['_main:', *[line for line in lines if re.fullmatch(r'_(?:fwp_vdup|w)[0-9]+:', line)]]
    for name in names:
        if name not in lines: continue
        start = lines.index(name)
        end = next((i for i in range(start + 1, len(lines)) if re.match(r'^\S.*:$', lines[i])), len(lines))
        block = lines[start:end]
        (folder / (name[1:-1] + '.txt')).write_text('\n'.join(block) + '\n')
        functions[name] = {'instructions': sum(bool(re.match(r'^[0-9a-f]{16}\s+', line)) for line in block), 'prologue': block[1:14]}
    outcome = code.index('/* Outcome */\nstatic V fwp_vbox')
    match = re.search(r'static void fwp_vdup[0-9]+\(fwp_u3 \*u\) \{', code[outcome:]); assert match
    start = outcome + match.start(); end = code.index('\n}\n', start); retaining = code[start:end]
    repeat = re.search(r'static V f([0-9]+)\(', code[code.index('/* repeat :'):]).group(1)
    start = code.index('static fwp_r2 w' + repeat + '(V l0) {'); end = code.index('\n}', start); worker = code[start:end]
    record = json.loads((folder / 'header.json').read_text())
    record.update(directory=folder.name, binaryBytes=binary.stat().st_size, functions=functions, repeatWorker='w'+repeat, partialScopeRegistered='fwp_cleanup_push(&retaining_cleanup,' in retaining, callerScopeRegistered='fwp_cleanup_push(' in worker[:worker.index('fwp_rc_dup(l0);')])
    records.append(record)
    if folder.name.startswith('O2-') and record['partialScopeRegistered'] and record['callerScopeRegistered']:
        selected = folder
        retained_type = re.search(r'(fwp_owner_ctx[0-9]+) retained =', retaining).group(1)
assert {(r['partialScopeRegistered'], r['callerScopeRegistered']) for r in records} == {(True,True),(False,True),(True,False)}
layout = root / 'retain' / 'layout.c'
printing = 'printf("V=%zu align=%zu variant=%zu payload=%zu pair=%zu partial_owner=%zu cleanup=%zu wide_entry=%zu wide_count=%zu\\n",sizeof(V),_Alignof(V),sizeof(fwp_u3),offsetof(fwp_u3,f),sizeof(fwp_r2),sizeof(' + retained_type + '),sizeof(fwp_cleanup),sizeof(gc_rc_wide),offsetof(gc_rc_wide,count));'
layout.write_text('#define main original_probe_main\n' + (selected / 'probe.c').read_text() + '\n#undef main\n#include <stddef.h>\nint main(void){' + printing + 'return 0;}\n')
args = json.loads((selected / 'args.json').read_text())
args = [str(layout) if arg.endswith('.c') else arg for arg in args]; args[args.index('-o') + 1] = str(root / 'retain' / 'layout')
subprocess.run([cc, *args], check=True)
output = subprocess.check_output([str(root / 'retain' / 'layout')], text=True).strip()
report['binaries'] = records; report['layout'] = output
(root / 'inspection.json').write_text(json.dumps(report, indent=2) + '\n')
print(machine, output)
