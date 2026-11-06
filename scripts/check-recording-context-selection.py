#!/usr/bin/env python3
"""Check borrowed recording state through live numeric calls and two loop scopes."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import re

SPEC = importlib.util.spec_from_file_location('lookup_selection', Path(__file__).with_name('check-recording-lookup-selection.py'))
LOOKUP = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(LOOKUP)
STATE = LOOKUP.STATE


def check_counts(observed, dimensions, updates, solves, enabled):
    assert dimensions >= 2 and updates >= 0 and solves > 0
    pairs = (dimensions - 1) * updates * solves
    expected = dict(lookups=2 * updates * solves if enabled else 3 * pairs,
                    parents=8 * pairs, capacities=8 * pairs, nodes=8 * pairs)
    assert observed == expected, (observed, expected)


def check(source, enabled):
    LOOKUP.check_capacity_gate(source, True)
    if not enabled:
        return dict(enabled=False, localLookup=LOOKUP.check(source, True))
    preserved = LOOKUP.SCALAR.check(source, 'literal')
    bodies, reached = LOOKUP.SCALAR.PAIR.STORAGE.reachable_bodies(source)
    workers = set(re.findall(r'^static [^\n]*?\b(w\d+)\([^;\n]*fwp_ad_recording \*recording\) \{', source, re.M)) & reached
    assert workers, 'no live recording worker receives borrowed state'
    scopes, direct, edges = {}, {}, {}
    for name in reached:
        body = bodies[name]
        if STATE in body:
            assert body.count(STATE) == 1, name
            assert ('/* Consume private overlapping windows;' in body
                    or '/* Fold after the complete packed map;' in body), ('unexpected scope', name)
            assert body.index(STATE) < body.index('    for ('), ('late scope', name)
            calls = re.findall(r'\b(w\d+)\([^;\n]*, &recording\)', body)
            assert len(calls) == 1 and calls[0] in workers, ('unproved loop callback', name, calls)
            scopes[name] = calls[0]
        elif ', &recording)' in body:
            raise AssertionError(('scope without initialization', name))
        if name in workers:
            calls = re.findall(r'\bfwp_p_ad_push\([^;\n]*, recording\)', body)
            assert len(calls) == body.count('fwp_p_ad_push('), ('uncached append', name)
            assert STATE not in body, ('worker resets borrowed state', name)
            children = re.findall(r'\b(w\d+)\([^;\n]*, recording\)', body)
            assert set(children) <= workers, ('unproved forwarded callee', name, children)
            assert '&(fwp_ad_recording)' not in body, ('fresh state inside borrowed graph', name)
            direct[name], edges[name] = len(calls), children
    assert len(scopes) == 2, ('expected one pair-map and one fold scope', scopes)
    assert sorted(count for count in direct.values() if count) == [1, 6], ('wrong live append sites', direct)
    assert any(edges.values()), 'nested addition does not borrow the caller state'
    pending, scoped = list(scopes.values()), set()
    while pending:
        name = pending.pop()
        if name not in scoped:
            scoped.add(name)
            pending.extend(edges[name])
    assert workers == scoped, ('recording worker outside proved loop graph', workers - scoped)
    return dict(enabled=True, loopScopes=scopes, liveWorkers=direct, forwardedCalls=edges,
                preservedScalarAndStorage=preserved)


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
    output = args.input / 'recording-context-selection.json'
    output.write_text(json.dumps(observed, indent=2) + '\n')
    manifest['files'][output.name] = hashlib.sha256(output.read_bytes()).hexdigest()
    manifest_path.write_text(json.dumps(manifest, indent=2) + '\n')
    print('Live loop scopes and borrowed recording calls checked in three programs')


if __name__ == '__main__':
    main()
