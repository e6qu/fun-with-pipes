#!/usr/bin/env python3
"""Exact reference construction and independent string-cost acceptance rules."""
import hashlib
import json
from pathlib import Path
import re
import statistics

ROOT = Path(__file__).resolve().parent.parent
NAMES = ('fwp_p_replace', 'fwp_p_str_repeat')
REFERENCE = 'f3eb507280e5a71083190ec1e26bbbdbe555dae8'
MANAGED = {
    '4096:64': dict(requests=14153, requestedBytes=463856, retains=4362,
                    peakChargedBytes=341617, finalChargedBytes=0),
    '65536:1024': dict(requests=225937, requestedBytes=7420304, retains=69642,
                       peakChargedBytes=5465713, finalChargedBytes=0),
}


def function(code, name):
    matches = list(re.finditer(r'^static V ' + re.escape(name)
                              + r'\([^\n]*\) \{\n.*?^\}', code, re.M | re.S))
    assert len(matches) == 1, (name, len(matches))
    return matches[0].group()


def reference_source(candidate, runtime, frozen):
    """Restore only the two declared bodies, with an exact reversible edit."""
    assert frozen['source'] == REFERENCE
    assert set(frozen['functions']) == set(NAMES)
    reference = candidate
    changes = []
    for name in NAMES:
        before = function(candidate, name)
        assert before == function(runtime, name), name
        after = frozen['functions'][name]
        assert function(after, name) == after and before != after, name
        assert reference.count(before) == 1
        reference = reference.replace(before, after)
        changes.append(dict(name=name, candidate=before, reference=after))
    restored = reference
    for change in changes:
        assert restored.count(change['reference']) == 1
        restored = restored.replace(change['reference'], change['candidate'])
    assert restored == candidate
    return reference, dict(source=REFERENCE, changes=changes,
        candidateSha256=hashlib.sha256(candidate.encode()).hexdigest(),
        referenceSha256=hashlib.sha256(reference.encode()).hexdigest())


def replace_once(code, before, after):
    assert code.count(before) == 1, before
    return code.replace(before, after)


def instrument_raw(code):
    """Count libc buffers only inside these two operations, after const setup.

    The managed profiler supplies iteration_active. This is measurement-only C;
    the ordinary candidate and reference binaries contain none of these hooks.
    """
    code = replace_once(code, 'static int iteration_active;', '''static int iteration_active;
static int direct_scope;
static uint64_t direct_requests, direct_bytes, direct_live, direct_peak;
static uint64_t direct_replace_calls, direct_repeat_calls;''')
    for name, arguments, counter in [
            ('fwp_p_replace', 'from, to, s', 'direct_replace_calls'),
            ('fwp_p_str_repeat', 'n, s', 'direct_repeat_calls')]:
        body = function(code, name)
        signature = body[:body.index('{') + 1]
        measured = body.replace(name + '(', name + '_measured(', 1)
        wrapper = signature + f'''
    int previous = direct_scope;
    direct_scope = iteration_active;
    if (direct_scope) {counter}++;
    V result = {name}_measured({arguments});
    direct_scope = previous;
    return result;
}}'''
        code = replace_once(code, body, measured + '\n' + wrapper)
    allocation = '        char *data = (char *)realloc(b->d, cap);'
    code = replace_once(code, allocation, '''        if (direct_scope) {
            direct_requests++; direct_bytes += cap;
            direct_live += cap - b->cap;
            if (direct_live > direct_peak) direct_peak = direct_live;
        }
''' + allocation)
    code = replace_once(code, '    free(b->d);\n    return r;', '''    if (direct_scope) direct_live -= b->cap;
    free(b->d);
    return r;''')
    marker = '    /* Ownership observation point: before runtime teardown. */\n'
    report = r'''    fprintf(stderr,"{\"rawRequests\":%llu,\"rawRequestedBytes\":%llu,\"rawPeakBytes\":%llu,\"rawFinalBytes\":%llu,\"replaceCalls\":%llu,\"repeatCalls\":%llu}\n",(unsigned long long)direct_requests,(unsigned long long)direct_bytes,(unsigned long long)direct_peak,(unsigned long long)direct_live,(unsigned long long)direct_replace_calls,(unsigned long long)direct_repeat_calls);
'''
    return replace_once(code, marker, marker + report)


def profile_failures(case, label, managed, raw):
    assert label in ('reference', 'candidate')
    failures = []
    limits = MANAGED[case]
    assert set(managed) == set(limits)
    assert all(type(value) is int and value >= 0 for value in managed.values())
    for key, limit in limits.items():
        if managed[key] > limit:
            failures.append(f'{case} {label} managed {key}: {managed[key]} > {limit}')
    tokens = int(case.split(':')[0])
    requests = 2 * ((tokens + 4) // 5) if label == 'reference' else 0
    expected = dict(rawRequests=requests, rawRequestedBytes=64 * requests,
                    rawPeakBytes=64 if requests else 0, rawFinalBytes=0,
                    replaceCalls=2 * tokens, repeatCalls=0)
    if raw != expected or any(type(value) is not int for value in raw.values()):
        failures.append(f'{case} {label} raw counts: {raw} != {expected}')
    return failures


def timing_decision(case, paired, contextual):
    """Use medians of all 16 round totals, never a selected subset or pooled phase."""
    assert set(paired) == {'reference', 'reference-copy', 'candidate', 'candidate-copy'}
    assert set(contextual) == {'c', 'rust', 'candidate', 'candidate-copy'}
    for totals in (paired, contextual):
        assert all(len(values) == 16 and all(type(v) is int and v > 0 for v in values)
                   for values in totals.values())
    p = {key: statistics.median(values) for key, values in paired.items()}
    c = {key: statistics.median(values) for key, values in contextual.items()}
    limit = {'4096:64': 1.05, '65536:1024': 1.01}[case]
    controls = {name: max(a / b, b / a) for name, a, b in [
        ('paired-reference', p['reference'], p['reference-copy']),
        ('paired-candidate', p['candidate'], p['candidate-copy']),
        ('context-candidate', c['candidate'], c['candidate-copy'])]}
    failures = [f'{case} {name} identical-copy ratio {ratio} > {limit}'
                for name, ratio in controls.items() if ratio > limit]
    ratio = p['candidate'] / p['reference']
    if ratio > limit:
        failures.append(f'{case} candidate/reference {ratio} > {limit}')
    speed_limit = {'4096:64': .90, '65536:1024': .95}[case]
    if case == '65536:1024' and ratio > speed_limit:
        failures.append(f'{case} candidate/reference {ratio} misses required {speed_limit}')
    return dict(pairedMediansNs=p, contextMediansNs=c, copyRatios=controls,
        candidateOverReference=ratio, candidateOverC=c['candidate'] / c['c'],
        candidateOverRust=c['candidate'] / c['rust'], failures=failures,
        speedClaim=not failures and ratio <= speed_limit)


def stack_frames(text):
    frames = {}
    for line in text.splitlines():
        source, size, kind = line.split('\t')
        name = source.rsplit(':', 1)[1]
        assert name not in frames, name
        frames[name] = dict(bytes=int(size), kind=kind)
    assert frames
    return frames


def representation_decision(reference_sections, candidate_sections, reference_stack, candidate_stack):
    def sections(text):
        return {match[1]: int(match[2]) for match in
                re.finditer(r'^(\.[\w.]+)\s+(\d+)\s+\d+\s*$', text, re.M)}
    r, c = sections(reference_sections), sections(candidate_sections)
    assert '.text' in r and '.text' in c
    costs = {prefix: sum(v for k, v in c.items() if k == prefix or k.startswith(prefix + '.'))
             - sum(v for k, v in r.items() if k == prefix or k.startswith(prefix + '.'))
             for prefix in ('.text', '.rodata')}
    failures = [f'{prefix} growth {costs[prefix]} > {limit}'
                for prefix, limit in [('.text', 4096), ('.rodata', 1024)] if costs[prefix] > limit]
    r, c = stack_frames(reference_stack), stack_frames(candidate_stack)
    changes = {name: dict(reference=r.get(name), candidate=c.get(name))
               for name in sorted(r.keys() | c.keys()) if r.get(name) != c.get(name)}
    for name, frame in c.items():
        old = r.get(name)
        if frame['kind'] != 'static' and (old is None or old['kind'] != frame['kind']):
            failures.append(f'new dynamic stack: {name}')
        if old and frame['bytes'] - old['bytes'] > 256:
            failures.append(f'stack frame grows beyond 256 bytes: {name}')
    largest = {key: max(frame['bytes'] for frame in values.values())
               for key, values in [('reference', r), ('candidate', c)]}
    if largest['candidate'] > largest['reference']:
        failures.append('largest stack frame grows')
    return dict(sectionGrowthBytes=costs, frameChanges=changes,
                largestFrameBytes=largest, failures=failures)
