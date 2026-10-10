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
layouts = {
    'tls': 'printf("TLS size=%zu align=%zu insecure=%zu key_len=%zu users=%zu; empty=%zu long=%zu\\n",sizeof(g_tls),_Alignof(g_tls),offsetof(g_tls,insecure),offsetof(g_tls,key_len),offsetof(g_tls,users),sizeof(g_tls)+4+1+4*sizeof(size_t),sizeof(g_tls)+4+1+4*sizeof(size_t)+2*(2+4096+4+3));',
    'address': 'printf("Connection size=%zu align=%zu authority=%zu; legacy size=%zu align=%zu authority=%zu; short request=%zu\\n",sizeof(g_conn),_Alignof(g_conn),offsetof(g_conn,authority),sizeof(struct legacy_g_conn),_Alignof(struct legacy_g_conn),offsetof(struct legacy_g_conn,authority),sizeof(g_conn)+6);',
}
for kind, expected in [('tls', 2), ('address', 4)]:
    folders = sorted(p for p in (root / kind).iterdir() if p.is_dir())
    assert len(folders) == expected
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
        names = ['_main:', '_g_tls_new:', '_g_tls_release:'] if kind == 'tls' else ['_main:', '_g_conn_new:', '_g_connect:']
        for name in names:
            if name not in lines:
                continue
            start = lines.index(name)
            end = next((i for i in range(start + 1, len(lines)) if re.match(r'^\S.*:$', lines[i])), len(lines))
            block = lines[start:end]
            (folder / (name[1:-1] + '.txt')).write_text('\n'.join(block) + '\n')
            functions[name] = {'instructions': sum(bool(re.match(r'^[0-9a-f]{16}\s+', line)) for line in block), 'prologue': block[1:12]}
        record = json.loads((folder / 'header.json').read_text())
        record.update(directory=folder.name, binaryBytes=binary.stat().st_size, functions=functions)
        if kind == 'address':
            record['fullAddress'] = 'memcpy(c->authority, authority, n + 1);' in code
        records.append(record)
    candidates = [p for p in folders if p.name.startswith('O2-') and (kind == 'tls' or 'memcpy(c->authority, authority, n + 1);' in (p / 'probe.c').read_text())]
    assert len(candidates) == 1
    selected = candidates[0]
    layout = root / kind / 'layout.c'
    layout.write_text('#define main original_probe_main\n' + (selected / 'probe.c').read_text() + '\n#undef main\n#include <stddef.h>\nint main(void){' + layouts[kind] + 'return 0;}\n')
    args = json.loads((selected / 'args.json').read_text())
    args = [str(layout) if arg.endswith('.c') else arg for arg in args]
    args[args.index('-o') + 1] = str(root / kind / 'layout')
    subprocess.run([cc, *args], check=True)
    output = subprocess.check_output([str(root / kind / 'layout')], text=True).strip()
    report['groups'][kind] = {'binaries': records, 'layout': output}
    print(machine, kind, output)
(root / 'inspection.json').write_text(json.dumps(report, indent=2) + '\n')
