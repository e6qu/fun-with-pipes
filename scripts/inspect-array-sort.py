#!/usr/bin/env python3
"""Inspect array-sort owners, wide-value permutations and interruption controls."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import struct
import subprocess


def instrument(program, fixture):
    code = program.replace('int main(int argc, char **argv)', 'int original_main(int argc, char **argv)')
    for name, replacement, header, arguments in [
            ('fwp_gc_alloc', 'array_probe_allocate', 'size_t n, int leaf', 'n, leaf'),
            ('fwp_alloc_init', 'array_probe_allocate_init', 'size_t n', 'n')]:
        definition = f'static inline void *{name}({header}) {{'
        assert code.count(definition) == 1
        renamed = f'static inline void *{replacement}({header}) {{'
        code = code.replace(definition, renamed)
        start = code.index(renamed)
        end = code.index('\n}\n', start) + 3
        body = code[start:end].replace('fwp_gc_alloc(n, 0)', 'array_probe_allocate(n, 0)')
        wrapper = f'\nstatic inline void *{name}({header}) {{ array_probe_tick(); void *p = {replacement}({arguments}); array_probe_record(p); return p; }}\n'
        code = code[:start] + body + wrapper + code[end:]
    for before, after, count in [
            ('static inline void fwp_rc_dup(V v) {\n', 'static inline void fwp_rc_dup(V v) { array_probe_tick();\n', 1),
            ('static void fwp_mem_free(void *p) {\n', 'static void fwp_mem_free(void *p) { array_probe_release(p);\n', 1),
            ('    if (!fwp_rc_last(v)) return;', '    if (!fwp_rc_last(v)) return;\n    array_probe_release((void *)(uintptr_t)v);', 2),
            ('static int fwp_cmp(V a, V b, const fwp_desc *d) {', 'static int fwp_cmp(V a, V b, const fwp_desc *d) { array_probe_tick();', 1)]:
        assert code.count(before) == count
        code = code.replace(before, after)
    for prefix, kind in [('STRING', 'K_STR'), ('QUAD', 'K_F128')]:
        matches = []
        for match in re.finditer(r'return fwp_p_array_sort_typed\(([^)]+)\);', program):
            arguments = match[1].split(', ')
            assert len(arguments) == 4
            descriptor = arguments[3].removeprefix('&')
            if f'static const fwp_desc {descriptor} = {{{kind},' not in program:
                continue
            function = program[:match.start()].rsplit('static V ', 1)[1].split('(', 1)[0]
            matches.append((function, arguments[2], arguments[3]))
        (function, drop, descriptor), = matches
        fixture = fixture.replace(prefix + '_SORT', function).replace(prefix + '_DROP', drop).replace(prefix + '_DESCRIPTOR', descriptor)
    return 'static void array_probe_tick(void); static void array_probe_record(void *); static void array_probe_release(void *);\n' + code + '\n' + fixture


parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--input', type=Path, required=True)
parser.add_argument('--source', required=True)
parser.add_argument('--system', choices=['Linux', 'macOS', 'Windows'], required=True)
parser.add_argument('--arch', choices=['X64', 'ARM64'], required=True)
parser.add_argument('--objdump', required=True)
parser.add_argument('--output', type=Path, required=True)
args = parser.parse_args()
assert re.fullmatch(r'[0-9a-f]{40}', args.source)
runtime = subprocess.check_output(['git', 'show', args.source + ':runtime/fwp_rt_prims.c'], text=True)
fixture = subprocess.check_output(['git', 'show', args.source + ':tests/fixtures/array_sort_probe.c'], text=True)
changes = {
    'shared-write': ('int unique = fwp_array_is_view(a) ? 0 : fwp_rc_unique_mut(a);', 'int unique = 1;', 205),
    'wide-overwrite': ('if (result == a && fwp_array_stride(elem) == 16)', 'if (0)', 206),
    'missing-input': ('fwp_value_owner input = {a, drop_array};', 'fwp_value_owner input = {a, NULL};', 211),
    'missing-result': ('fwp_value_owner owner = {result, drop_array};', 'fwp_value_owner owner = {result, NULL};', 211),
    'missing-scratch': ('static void fwp_scratch_release(void *arg) {', 'static void fwp_scratch_release(void *arg) { (void)arg; return;', 211),
    'missing-retain': ('fwp_array_typed_copy(a, 0, unique ? NULL : dup, elem)', 'fwp_array_typed_copy(a, 0, NULL, elem)', 207),
}
expected = set()
images = []
observations = []
program_output = None
for memory in ['arc', 'tracing']:
    for optimization in ['-O1', '-O2']:
        program = (args.input / f'{memory}{optimization}-program-reuse0.c').read_text()
        assert program.count(runtime) == 1
        balanced = instrument(program, fixture)
        start = balanced.index('static V fwp_p_array_sort_typed(')
        end = balanced.index('\n}\n', start) + 3
        for case in ['program', 'balanced', 'no-reuse', *changes]:
            reuses = ['0', '1'] if memory == 'tracing' and case not in changes else ['0']
            for reuse in reuses:
                label = f'{memory}{optimization}-{case}-reuse{reuse}'
                expected.add(label)
                prefix = args.input / label
                code = prefix.with_suffix('.c').read_text()
                if case == 'program':
                    assert code == program
                elif case == 'balanced':
                    assert code == balanced
                elif case == 'no-reuse':
                    assert code == '#define FWP_NO_REUSE 1\n' + balanced
                else:
                    before, after, failure = changes[case]
                    if case == 'missing-scratch':
                        assert balanced.count(before) == 1
                        changed = balanced.replace(before, after)
                    else:
                        body = balanced[start:end]
                        assert body.count(before) == 1
                        changed = balanced[:start] + body.replace(before, after) + balanced[end:]
                    assert code == changed
                assert ('#define FWP_ARC_ONLY 1' in code) == (memory == 'arc')
                stdout = prefix.with_suffix('.stdout').read_bytes()
                stderr = prefix.with_suffix('.stderr').read_bytes()
                status = prefix.with_suffix('.status').read_text().strip()
                if case in changes:
                    assert status == f'Some({changes[case][2]})' and not stdout
                else:
                    assert status == 'Some(0)' and not stderr
                    if case == 'program':
                        if program_output is None:
                            program_output = stdout
                        assert stdout == program_output and b'Err "probe"' in stdout
                    else:
                        match = re.fullmatch(rb'array sort: 540 stable alias/bit-pattern cases and (\d+) allocation/retain/comparison interruptions cleaned\r?\n', stdout)
                        assert match and int(match[1]) >= 100
                        observations.append(dict(label=label, cases=540, interruptions=int(match[1])))
                binary = prefix.with_suffix('.exe')
                raw = binary.read_bytes()
                if args.system == 'Linux':
                    assert raw[:6] == b'\x7fELF\x02\x01'
                    assert struct.unpack_from('<H', raw, 16)[0] in [2, 3]
                    machine = struct.unpack_from('<H', raw, 18)[0]
                    assert machine == (183 if args.arch == 'ARM64' else 62)
                elif args.system == 'macOS':
                    assert raw[:4] == b'\xcf\xfa\xed\xfe'
                    assert struct.unpack_from('<I', raw, 12)[0] == 2
                    machine = struct.unpack_from('<I', raw, 4)[0]
                    assert machine == (0x100000c if args.arch == 'ARM64' else 0x1000007)
                else:
                    assert raw[:2] == b'MZ'
                    offset = struct.unpack_from('<I', raw, 60)[0]
                    assert raw[offset:offset+4] == b'PE\0\0'
                    machine = struct.unpack_from('<H', raw, offset+4)[0]
                    assert machine == (0xaa64 if args.arch == 'ARM64' else 0x8664)
                sections = subprocess.check_output([args.objdump, '--section-headers', '--syms', str(binary)])
                assembly = subprocess.check_output([args.objdump, '-d', str(binary)])
                assert len(assembly) > 1000
                sizes = re.findall(rb'^\s*\d+\s+(?:\.text|__text)\s+([0-9a-fA-F]+)\s', sections, re.M)
                assert sizes
                if memory == 'arc':
                    assert not re.search(rb'(?<![A-Za-z0-9])_?fwp_gc_(?:scan|mark_all|sweep)\b', sections)
                images.append(dict(label=label, machine=machine, fileBytes=len(raw),
                    instructionBytes=sum(int(size, 16) for size in sizes),
                    sourceSha256=hashlib.sha256(code.encode()).hexdigest(),
                    binarySha256=hashlib.sha256(raw).hexdigest(),
                    disassemblySha256=hashlib.sha256(assembly).hexdigest(),
                    sectionsSha256=hashlib.sha256(sections).hexdigest(),
                    stdout=stdout.decode(), stderr=stderr.decode(), status=status))
assert {path.stem for path in args.input.glob('*.exe')} == expected
assert len(images) == 42 and len(observations) == 12
report = dict(source=args.source, system=args.system, architecture=args.arch,
    scope='Current generated program, exact source-derived instrumentation, alias/bit checks and interrupted ownership. No timing comparison.',
    images=images, observations=observations)
args.output.parent.mkdir(parents=True, exist_ok=True)
args.output.write_text(json.dumps(report, indent=2) + '\n')
print('Inspected 42 array-sort executables, twelve repeated observations and 24 broken controls')
