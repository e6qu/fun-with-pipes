"""Attribute native reference storage and verify staged actual release controls."""
import json
import re

LANGUAGES = ('c', 'rs', 'swift')
GROUPS = ('target', 'weak', 'type-metadata')
COSTS = ('allocations', 'peak', 'leaked')
POPULATIONS = (64, 4096)


def decode_output(text, population, stage):
    expected = dict(population=population, stage=stage, live=population if stage >= 1 else 0, expired=0)
    row = json.loads(text)
    assert isinstance(row, dict) and set(row) == set(expected)
    assert all(type(value) is int for value in row.values()) and row == expected
    assert text == json.dumps(row, separators=(',', ':')) + '\n'
    return row


def allocation_kind(stack, language):
    assert language in LANGUAGES
    frames = [frame.split(' (', 1)[0] for frame in stack.split(';') if frame]
    if language == 'c':
        if 'reference_make' in frames:
            return 'target'
        return 'weak' if 'reference_downgrade' in frames else 'outside'
    if language == 'rs':
        for suffix, group in (('4make', 'target'), ('9downgrade', 'weak')):
            if any(re.fullmatch(r'_RNvC[A-Za-z0-9]+_14weak_operation' + suffix, frame) for frame in frames):
                return group
        return 'outside'
    target = any(frame.startswith(('$s13WeakOperation13referenceMake', '$s13WeakOperation15ReferenceTarget'))
                 for frame in frames)
    weak = any(frame.startswith('$s13WeakOperation18referenceDowngrade') for frame in frames)
    if not target and not weak:
        return 'outside'
    if any(frame.startswith(('__swift_instantiateConcreteTypeFromMangledName', 'swift_getTypeByMangledName',
                             'swift_getSingletonMetadata')) for frame in frames):
        return 'type-metadata'
    if target:
        assert 'swift_allocObject' in frames and 'swift_slowAlloc' in frames, stack
        return 'target'
    assert any('swift_weakInit' in frame or 'formWeakReference' in frame for frame in frames), stack
    return 'weak'


def check_stages(rows, language, population):
    """Each row is an independent process ending after the same lifetime prefix."""
    assert language in LANGUAGES and population in POPULATIONS and len(rows) == 4
    for row in rows:
        assert set(row) == set(GROUPS)
        for counters in row.values():
            assert set(counters) == set(COSTS)
            assert all(type(value) is int and value >= 0 for value in counters.values())
    targets = [row['target'] for row in rows]
    weak = [row['weak'] for row in rows]
    # Every prefix creates the same real targets; no factory attribution is a
    # failed observation, not proof of allocation-free construction.
    assert all(row['allocations'] == population for row in targets), targets
    assert targets[0]['leaked'] > 0 and targets[0]['leaked'] == targets[1]['leaked'], targets
    assert targets[3]['leaked'] == 0, targets
    assert weak[0] == dict(allocations=0, peak=0, leaked=0), weak
    if language == 'rs':
        # Rc's allocation contains the target and counters. Weak keeps this same
        # allocation after value destruction; no extra Box is introduced.
        assert targets[2]['leaked'] == targets[1]['leaked'], targets
        assert all(row == dict(allocations=0, peak=0, leaked=0) for row in weak), weak
    else:
        assert targets[2]['leaked'] == 0, targets
        assert all(row['allocations'] == population for row in weak[1:]), weak
        assert weak[1]['leaked'] > 0 and weak[1]['leaked'] == weak[2]['leaked'], weak
        assert weak[3]['leaked'] == 0, weak
    # One-time Swift type metadata is reported separately. It must not change
    # across the three prefixes that all construct a weak registration.
    for cost in ('allocations', 'leaked'):
        assert len({row['type-metadata'][cost] for row in rows[1:]}) == 1, rows
    if language != 'swift':
        assert all(row['type-metadata'] == dict(allocations=0, peak=0, leaked=0) for row in rows)
    # Stack-attributed bytes at the *process* peak are retained without claiming
    # a separate maximum for targets, weak metadata or their sum.
