"""Inputs and accounting checks for the compiler-growth experiment."""
import hashlib
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
FAMILIES = {'definitions': (16, 64, 256, 1024), 'generic': (8, 32, 128, 512),
            'nesting': (8, 32, 128, 512)}


def cases():
    for family, sizes in FAMILIES.items():
        for size in sizes:
            yield family, size


def program(family, size):
    if family == 'definitions':
        definitions = ''.join(f'f{i} : I64 -> I64\nf{i} = add {i}\n' for i in range(size))
        uses = ',\n'.join(f'    1 | f{i} | echo' for i in range(size))
        return definitions + 'main = [\n' + uses + '\n] | ignore\n', ''.join(f'{i+1}\n' for i in range(size))
    if family == 'generic':
        # Distinct structural record labels force distinct concrete helper uses.
        uses = ',\n'.join(f'    {{field{i} = {i}}} | keep | .field{i} | echo' for i in range(size))
        return 'keep : a -> a\nkeep = id\nmain = [\n' + uses + '\n] | ignore\n', ''.join(f'{i}\n' for i in range(size))
    if family == 'nesting':
        bindings = 'let value0 = 0 in ' + ''.join(
            f'let value{i} = value{i-1} + 1 in ' for i in range(1, size))
        return f'main = ({bindings}value{size-1}) | echo\n', f'{size-1}\n'
    raise ValueError(f'unknown family: {family}')


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def profile(path, status):
    report = json.loads(path.read_text())
    assert report['format'] == 'fwp-compile-profile' and report['version'] == 1
    assert report['status'] == status and report['wall_ns'] >= 0
    events = report['phases']
    assert events
    children = [0] * len(events)
    for index, event in enumerate(events):
        assert event['id'] == index
        assert 0 <= event['start_ns'] <= event['end_ns'] <= report['wall_ns']
        assert event['inclusive_ns'] == event['end_ns'] - event['start_ns']
        parent = event['parent']
        if parent is not None:
            assert 0 <= parent < index
            assert events[parent]['start_ns'] <= event['start_ns']
            assert event['end_ns'] <= events[parent]['end_ns']
            children[parent] += event['inclusive_ns']
    for event, child_ns in zip(events, children):
        assert event['exclusive_ns'] >= 0
        assert event['exclusive_ns'] + child_ns == event['inclusive_ns']
    assert report['unassigned_ns'] >= 0
    assert sum(e['exclusive_ns'] for e in events) + report['unassigned_ns'] == report['wall_ns']
    assert not any(e['phase'] == 'debug-ownership-verification' for e in events), 'requires release compiler'
    return report


def resources(text):
    fields = {}
    for label, key, convert in (
        ('Maximum resident set size (kbytes)', 'maxRssKiB', int),
        ('User time (seconds)', 'userSeconds', float),
        ('System time (seconds)', 'systemSeconds', float),
    ):
        value, = re.findall(r'^\s*' + re.escape(label) + r':\s*(\S+)\s*$', text, re.M)
        fields[key] = convert(value)
    return fields


def phase_totals(report):
    totals = {}
    for event in report['phases']:
        phase = totals.setdefault(event['phase'], {'exclusiveNs': 0, 'inclusiveNs': 0, 'calls': 0, 'counts': {}})
        phase['exclusiveNs'] += event['exclusive_ns']
        phase['inclusiveNs'] += event['inclusive_ns']
        phase['calls'] += 1
        for name, value in event['counts'].items():
            phase['counts'][name] = phase['counts'].get(name, 0) + value
    return totals
