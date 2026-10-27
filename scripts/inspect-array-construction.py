#!/usr/bin/env python3
"""Inspect list-to-array moves, shared tails and interruption cleanup."""
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
            ('fwp_heap_alloc', 'array_probe_allocate', 'size_t n, int kind', 'n, kind'),
            ('fwp_alloc_init', 'array_probe_allocate_init', 'size_t n', 'n')]:
        definition = f'static inline void *{name}({header}) {{'
        assert code.count(definition) == 1
        renamed = f'static inline void *{replacement}({header}) {{'
        code = code.replace(definition, renamed)
        start = code.index(renamed)
        end = code.index('\n}\n', start) + 3
        body = code[start:end].replace('fwp_heap_alloc(n, 0)', 'array_probe_allocate(n, 0)')
        wrapper = f'\nstatic inline void *{name}({header}) {{ array_probe_tick(); void *p = {replacement}({arguments}); array_probe_record(p); return p; }}\n'
        code = code[:start] + body + wrapper + code[end:]
    for before, after, count in [
            ('static inline void fwp_rc_dup(V v) {\n', 'static inline void fwp_rc_dup(V v) { array_probe_tick();\n', 1),
            ('static void fwp_mem_free(void *p) {\n', 'static void fwp_mem_free(void *p) { array_probe_release(p);\n', 1),
            ('static int fwp_cmp(V a, V b, const fwp_desc *d) {', 'static int fwp_cmp(V a, V b, const fwp_desc *d) { array_probe_tick();', 1)]:
        assert code.count(before) == count
        code = code.replace(before, after)
    for prefix, kind in [('STRING', 'K_STR'), ('QUAD', 'K_F128')]:
        matches = []
        for match in re.finditer(r'return fwp_p_array_from_list_typed\(([^)]+)\);', program):
            arguments = match[1].split(', ')
            assert len(arguments) == 4
            descriptor = arguments[3].removeprefix('&')
            if f'static const fwp_desc {descriptor} = {{{kind},' not in program:
                continue
            function = program[:match.start()].rsplit('static V ', 1)[1].split('(', 1)[0]
            matches.append((function, arguments[2], arguments[3]))
        (function, drop, descriptor), = matches
        drops = [match[1].split(', ')[2] for match in re.finditer(r'return fwp_p_array_sort_typed\(([^)]+)\);', program)
                 if match[1].split(', ')[3] == descriptor]
        array_drop, = drops
        fixture = fixture.replace(prefix + '_CONSTRUCT', function).replace(prefix + '_LIST_DROP', drop).replace(prefix + '_ARRAY_DROP', array_drop).replace(prefix + '_DESCRIPTOR', descriptor)
    retain = 'static inline void fwp_rc_dup(V v) { array_probe_tick();'
    assert code.count(retain) == 1
    code = code.replace(retain, 'static inline void fwp_rc_dup(V v) { array_probe_retains++; array_probe_tick();')
    return 'static unsigned array_probe_retains;\nstatic void array_probe_tick(void); static void array_probe_record(void *); static void array_probe_release(void *);\n' + code + '\n' + fixture


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
fixture = subprocess.check_output(['git', 'show', args.source + ':tests/fixtures/array_construction_probe.c'], text=True)
changes = {
    'shared-tail': ('move_prefix = 0;', 'move_prefix = 1;', 205),
    'missing-retain': ('if (dup && elem->kind != K_F128) dup(value);', '(void)dup;', 205),
    'missing-input': ('fwp_value_owner input = {xs, drop_list};', 'fwp_value_owner input = {xs, NULL};', 211),
    'missing-result': ('static void fwp_array_builder_release(void *arg) {', 'static void fwp_array_builder_release(void *arg) { (void)arg; return;', 211),
    'missing-node': ('fwp_rc_free_obj(node);', '(void)node;', 211),
    'missing-wide-release': ('fwp_array_store_owned(result.value, i, value, elem);', 'fwp_array_store(result.value, i, value, elem);', 211),
}
expected = set()
images = []
observations = []
program_output = None
for optimization in ['-O1', '-O2']:
    program = (args.input / f'counted{optimization}-program.c').read_text()
    assert program.count(runtime) == 1
    balanced = instrument(program, fixture)
    start = balanced.index('static V fwp_p_array_from_list_typed(')
    end = balanced.index('\n}\n', start) + 3
    for case in ['program', 'balanced', 'no-reuse', *changes]:
        label = f'counted{optimization}-{case}'
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
            if case == 'missing-result':
                assert balanced.count(before) == 1
                changed = balanced.replace(before, after)
            else:
                body = balanced[start:end]
                assert body.count(before) == 1
                changed = balanced[:start] + body.replace(before, after) + balanced[end:]
            assert code == changed
        assert 'FWP_ARC_ONLY' not in code
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
                match = re.fullmatch(rb'array construction: 208 alias/bit-pattern cases and (\d+) allocation/retain interruptions cleaned\r?\n', stdout)
                assert match and int(match[1]) >= 64
                observations.append(dict(label=label, cases=208, interruptions=int(match[1])))
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
        assert not re.search(rb'(?<![A-Za-z0-9])_?fwp_heap_(?:scan|mark_all|sweep)\b', sections)
        images.append(dict(label=label, machine=machine, fileBytes=len(raw),
            instructionBytes=sum(int(size, 16) for size in sizes),
            sourceSha256=hashlib.sha256(code.encode()).hexdigest(),
            binarySha256=hashlib.sha256(raw).hexdigest(),
            disassemblySha256=hashlib.sha256(assembly).hexdigest(),
            sectionsSha256=hashlib.sha256(sections).hexdigest(),
            stdout=stdout.decode(), stderr=stderr.decode(), status=status))
assert {path.stem for path in args.input.glob('*.exe')} == expected
assert len(images) == 18 and len(observations) == 4
report = dict(source=args.source, system=args.system, architecture=args.arch,
    scope='Current generated program, exact source-derived instrumentation, unique-prefix moves, shared-tail and wide-bit checks, and interrupted ownership. No timing comparison.',
    images=images, observations=observations)
args.output.parent.mkdir(parents=True, exist_ok=True)
args.output.write_text(json.dumps(report, indent=2) + '\n')
print('Inspected 18 array-construction executables, four repeated observations and twelve broken controls')
