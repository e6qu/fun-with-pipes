#!/usr/bin/env python3
"""Verify six live recording sites share one lookup state in each objective worker."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import re

SPEC = importlib.util.spec_from_file_location('scalar_selection', Path(__file__).with_name('check-scalar-constant-selection.py'))
SCALAR = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(SCALAR)
STATE = 'fwp_ad_recording recording = {-1, NULL};'


def instrument(source):
    declarations = list(re.finditer(
        r'^static (?:inline __attribute__\(\(always_inline\)\) )?V fwp_p_ad_push\(', source, re.M))
    assert len(declarations) == 1, 'expected exactly one scalar append declaration'
    start = declarations[0].start()
    end = source.index('/* the adjoints', start)
    body = source[start:end]
    for marker, counter in (
            ('        t = fwp_tape_of(id);', 'lookups'),
            ('    int64_t idx = t->len;', 'parents'),
            ('    fwp_tape_reserve(t, op + 1);', 'capacities'),
            ('    t->len = idx + 1;', 'nodes')):
        assert body.count(marker) == 1, marker
        body = body.replace(marker, '    recording_' + counter + '++;\n' + marker)
    declarations = 'static uint64_t recording_lookups, recording_parents, recording_capacities, recording_nodes;\n'
    source = source[:start] + declarations + body + source[end:]
    marker = '    /* Ownership observation point: before runtime teardown. */\n'
    assert source.count(marker) == 1
    report = r'''    fprintf(stderr, "{\"lookups\":%llu,\"parents\":%llu,\"capacities\":%llu,\"nodes\":%llu}\n",
        (unsigned long long)recording_lookups, (unsigned long long)recording_parents,
        (unsigned long long)recording_capacities, (unsigned long long)recording_nodes);
'''
    return source.replace(marker, report + marker)


def check_inline_declaration(source, forced):
    plain = 'static V fwp_p_ad_push('
    inline = 'static inline __attribute__((always_inline)) V fwp_p_ad_push('
    expected, excluded = (inline, plain) if forced else (plain, inline)
    assert source.count(expected) == 1 and excluded not in source, 'wrong scalar append inlining'
    return dict(forced=forced)


def check_capacity_gate(source, split):
    plain = 'static void fwp_tape_reserve(fwp_tape *t, int64_t n) {'
    inline = 'static inline __attribute__((always_inline)) void fwp_tape_reserve(fwp_tape *t, int64_t n) {'
    expected, excluded = (inline, plain) if split else (plain, inline)
    assert source.count(expected) == 1 and excluded not in source, 'wrong reserve gate declaration'
    body = source.split(expected, 1)[1].split('\n}', 1)[0]
    # Historical column evidence and current record evidence have different
    # allocation bounds. Identify the actual representation, then require its
    # entire gate; a missing record bound must not pass as a column gate.
    record = 'typedef struct { int32_t pa, pb; double da, db; } fwp_tape_op;'
    prefix = '\n    int64_t limit = fwp_tape_limit();\n'
    if 'fwp_tape_op' in source:
        assert source.count(record) == 1, 'missing or altered numeric record layout'
        prefix += '''    size_t stride = t->owned ? 2 * sizeof(V) : sizeof(fwp_tape_op);
    size_t records = (size_t)PTRDIFF_MAX / stride;
    if ((uint64_t)limit > records) limit = (int64_t)records;
'''
    prefix += '''
    if (n < 0 || n > limit) fwp_trap("autodiff: the tape is full");
    if (n <= t->cap) return;
'''.lstrip('\n')
    assert body.startswith(prefix), 'reserve checks missing or reordered'
    grow = 'static void fwp_tape_grow(fwp_tape *t, int64_t n, int64_t limit) {'
    if split:
        assert body == prefix + '    fwp_tape_grow(t, n, limit);'
        assert source.count(grow) == 1 and source.count('fwp_tape_grow(') == 2
    else:
        assert 'fwp_tape_grow(' not in source
        assert body[len(prefix):].startswith('    int64_t cap = t->cap ? t->cap : (limit < 64 ? limit : 64);')
    check_inline_declaration(source, True)
    return dict(split=split)


def check_counts(observed, dimensions, updates, solves, enabled):
    pairs = (dimensions - 1) * updates * solves
    expected = dict(lookups=(3 if enabled else 8) * pairs,
                    parents=8 * pairs, capacities=8 * pairs, nodes=8 * pairs)
    assert observed == expected, (observed, expected)


def check(source, enabled):
    preserved = SCALAR.check(source, 'literal')
    bodies, reached = SCALAR.PAIR.STORAGE.reachable_bodies(source)
    workers = {}
    for name in reached:
        body = bodies[name]
        if STATE not in body:
            assert ', &recording)' not in body, ('lookup state without initialization', name)
            continue
        assert body.count(STATE) == 1, name
        calls = re.findall(r'\bfwp_p_ad_push\([^;\n]*, &recording\)', body)
        assert len(calls) == 6, (name, len(calls))
        workers[name] = len(calls)
    assert bool(workers) == enabled, ('wrong lookup selection', enabled, workers)
    if not enabled:
        assert STATE not in source and ', &recording)' not in source
    return dict(enabled=enabled, liveWorkers=workers, preservedScalarAndStorage=preserved)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', type=Path, required=True)
    parser.add_argument('--selection', choices=('enabled', 'disabled'), required=True)
    args = parser.parse_args()
    manifest_path = args.input / 'manifest.json'
    manifest = json.loads(manifest_path.read_text())
    for name, expected in manifest['files'].items():
        assert hashlib.sha256((args.input / name).read_bytes()).hexdigest() == expected, name
    observed = {}
    for name in ('descent-small', 'descent-large', 'current-large'):
        source = (args.input / (name + '-optimized.c')).read_text()
        observed[name] = check(source, args.selection == 'enabled')
    output = args.input / 'recording-lookup-selection.json'
    output.write_text(json.dumps(observed, indent=2) + '\n')
    manifest['files'][output.name] = hashlib.sha256(output.read_bytes()).hexdigest()
    manifest_path.write_text(json.dumps(manifest, indent=2) + '\n')
    print('Live objective recording sites checked in three complete programs')


if __name__ == '__main__':
    main()
