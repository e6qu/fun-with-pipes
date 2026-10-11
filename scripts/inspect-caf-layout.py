#!/usr/bin/env python3
"""Inspect unchanged cache ownership and omission fixtures on both Macs."""
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
    'limits': 'Original fault/observer fixtures; static calls/instructions are not dynamic counts or speed. Cache global sizes exclude placement padding. No general ABI/cache/frame claim.',
}
records = []
for family, count in [('cache', 12), ('source', 4), ('trap', 4)]:
    folders = sorted(p for p in (root / family).iterdir() if p.is_dir())
    assert len(folders) == count, (family, len(folders))
    for folder in folders:
        binary = folder / 'probe'
        code = (folder / 'probe.c').read_text()
        assert binary.read_bytes()[:16].hex() == headers[machine]
        record = json.loads((folder / 'header.json').read_text())
        assert record['sourceSha256'] == hashlib.sha256(code.encode()).hexdigest()
        record.update(family=family, directory=folder.name, binaryBytes=binary.stat().st_size,
                      finishCalls=code.count('fwp_caf_finish();'))
        if family == 'cache':
            caf = code.split('static V caf0(void) {', 1)[1].split('\n', 1)[0]
            a = code.index('    V r = caf3();')
            root_body = code[a:code.index('    fflush(stdout);', a)]
            record.update(manualProbe='static jmp_buf overflow;' in code,
                          returnOwner='fwp_rc_dup(fwp_caf_value0);' in caf,
                          previousDrop=bool(re.search(r'\bfwp_drop[0-9]+\(previous\);', caf)),
                          rootDrop=bool(re.search(r'\bfwp_drop[0-9]+\(r\);', root_body)))
        if family == 'trap':
            a = code.index('/* holder :')
            holder = code[a:code.index('\n}\n', a)]
            point = holder.index(' = caf')
            active = []
            for operation, node in re.findall(r'fwp_cleanup_(push|pop)\(&([A-Za-z_][A-Za-z_0-9]*)', holder[:point]):
                if operation == 'push':
                    active.append(node)
                else:
                    assert active and active[-1] == node
                    active.pop()
            record['activeCallerScopes'] = active
        assembly = subprocess.check_output(['otool', '-tvV', str(binary)], text=True)
        (folder / 'disassembly.txt').write_text(assembly)
        (folder / 'symbols.txt').write_text(subprocess.check_output(['nm', '-nm', str(binary)], text=True))
        lines = assembly.splitlines()
        functions = {}
        for name in ['_main:', *[line for line in lines if re.fullmatch(r'_(?:caf|f)[0-9]+:', line)]]:
            if name not in lines:
                continue
            a = lines.index(name)
            b = next((i for i in range(a + 1, len(lines)) if re.match(r'^\S.*:$', lines[i])), len(lines))
            block = lines[a:b]
            (folder / (name[1:-1] + '.txt')).write_text('\n'.join(block) + '\n')
            functions[name] = {'instructions': sum(bool(re.match(r'^[0-9a-f]{16}\s+', line)) for line in block), 'prologue': block[1:14]}
        record['functions'] = functions
        records.append(record)
for opt in ['O1', 'O2']:
    cache = [r for r in records if r['family'] == 'cache' and r['directory'].startswith(opt + '-')]
    assert len(cache) == 6
    manual = [r for r in cache if r['manualProbe']]
    assert len(manual) == 4
    assert {(r['returnOwner'], r['previousDrop'], r['finishCalls']) for r in manual} == {
        (True, True, 4), (False, True, 4), (True, False, 4), (True, True, 1)}
    assert all(r['rootDrop'] for r in manual)
    executable = [r for r in cache if not r['manualProbe']]
    assert len(executable) == 2 and {r['rootDrop'] for r in executable} == {True, False}
    source = [r for r in records if r['family'] == 'source' and r['directory'].startswith(opt + '-')]
    assert len(source) == 2 and {r['finishCalls'] for r in source} == {0, 1}
    trap = [r for r in records if r['family'] == 'trap' and r['directory'].startswith(opt + '-')]
    sizes = sorted(len(r['activeCallerScopes']) for r in trap)
    assert len(sizes) == 2 and sizes[1] == sizes[0] + 1
positive = next(r for r in records if r['family'] == 'cache' and r['directory'].startswith('O2-') and r['manualProbe'] and r['returnOwner'] and r['previousDrop'] and r['finishCalls'] == 4)
selected = root / 'cache' / positive['directory']
code = (selected / 'probe.c').read_text()
layout = root / 'cache' / 'layout.c'
layout.write_text('#define main original_probe_main\n' + code + '\n#undef main\n#include <stddef.h>\nint main(void){printf("V=%zu align=%zu object_header=%zu payload=%zu cleanup=%zu cache_value=%zu cache_value_align=%zu cache_state=%zu cache_state_align=%zu\\n",sizeof(V),_Alignof(V),sizeof(fwp_obj),offsetof(fwp_obj,f),sizeof(fwp_cleanup),sizeof(fwp_caf_value0),_Alignof(V),sizeof(fwp_caf_state0),_Alignof(int));return 0;}\n')
args = json.loads((selected / 'args.json').read_text())
args = [str(layout) if arg.endswith('.c') else arg for arg in args]
args[args.index('-o') + 1] = str(root / 'cache' / 'layout')
subprocess.run([cc, *args], check=True)
report['binaries'] = records
report['layoutSourceSha256'] = positive['sourceSha256']
report['layout'] = subprocess.check_output([str(root / 'cache' / 'layout')], text=True).strip()
(root / 'inspection.json').write_text(json.dumps(report, indent=2) + '\n')
print(machine, report['layout'])
