"""Account for service samples with explicit source phases and unresolved work."""
import json
import re

from cpu_samples import unknown_frame

PHASES = {'pending': 'construction', 'expired-pending': 'construction',
          'receiving': 'construction', 'dispatch': 'dispatch', 'deliver': 'dispatch',
          'drain': 'drain'}
ENTRY = {
    'c': re.compile(r'^service_run(?:\.(?:constprop|isra|part)\.\d+)?$'),
    'fwp': re.compile(r'^service_run(?:\.(?:constprop|isra|part)\.\d+)?$'),
    'rs': re.compile(r'^weak_callback_service(?:\[[0-9a-f]+\])?::service_run\b'),
    'swift': re.compile(r'^WeakCallbackService\.serviceRun\('),
}
PEER_DISPATCH = {
    'c': re.compile(r'^(?:callback)(?:\.(?:constprop|isra|part)\.\d+)?$'),
    'rs': re.compile(r'^weak_callback_service(?:\[[0-9a-f]+\])?::callback\b'),
    'swift': re.compile(r'^WeakCallbackService\.(?:dispatch|callback)\('),
}
OPERATIONS = (
    ('allocation', re.compile(r'^(?:_+)?(?:malloc|calloc|realloc)(?:$|\b)|^fwp_(?:alloc(?:_leaf|_unique)?|heap_alloc(?:_big|_slow)?|mem_alloc)\b|^swift_(?:allocObject|slowAlloc)\b')),
    ('release', re.compile(r'^(?:_+)?(?:free|cfree)(?:$|\b)|^fwp_(?:drop\d*|owner_release\d*|rc_free\w*|mem_free|value_release)\b|^swift_(?:release|dealloc\w*|slowDealloc)\b')),
    ('ownership', re.compile(r'^fwp_(?:rc_(?:dup|drop(?:_slot)?|retain|release_last|fresh|share[ds]?|slot|unique(?:_mut)?|last|wide_\w+)|(?:p_)?weak_\w+)\b|^swift_(?:retain|weak\w*|unknownObject\w*)\b')),
    ('channel/queue', re.compile(r'^fwp_(?:(?:p_)?channel|chan)_\w+\b')),
    ('error handling', re.compile(r'^fwp_(?:fail|attempt|handle_error)\b|^(?:_+)?(?:longjmp|setjmp|sigsetjmp)\b|^swift_(?:willThrow|error\w*)\b')),
    ('synchronization', re.compile(r'^(?:_+)?pthread_\w+\b|^(?:_+)?futex\w*\b')),
    ('memory movement', re.compile(r'^(?:_+)?(?:memcpy|memmove|memset)\w*\b')),
)


def fwp_functions(source):
    """Read the actual emitted ID/name table; anonymous functions stay anonymous."""
    tables = re.findall(r'static const fwp_fninfo fwp_fn_table\[\] = \{\n(.*?)\n\};', source, re.S)
    assert len(tables) == 1, 'missing or ambiguous emitted function table'
    names = []
    for line in tables[0].splitlines():
        row = re.fullmatch(r'\s*\{\d+, (?:0|e\d+), ("(?:[^"\\]|\\.)*"), (?:0|&fwp_owned_info\d+)\},', line)
        assert row, f'unrecognized function-table row: {line}'
        names.append(json.loads(row[1]))
    assert names.count('service') == 1, 'missing or ambiguous source service function'
    return names


def source_name(symbol, names):
    match = re.fullmatch(r'(?:[few]|fwp_owned_entry)(\d+)(?:\.(?:constprop|isra|part)\.\d+)*', symbol)
    if match is None:
        return None
    index = int(match[1])
    assert index < len(names), f'function symbol outside retained source table: {symbol}'
    return names[index]


def attribute(samples, flat, *, peer, functions):
    assert peer in ENTRY
    assert (functions is not None) == (peer == 'fwp')
    assert len(samples) == sum(row['samples'] for row in flat), 'sample count changed'
    assert sum(s['period'] for s in samples) == sum(row['period'] for row in flat), 'sample periods changed'
    groups = {}
    service_samples = 0
    unknown_frames = 0
    empty_stacks = 0
    for sample in samples:
        frames = sample['frames']
        service = any(ENTRY[peer].search(frame['symbol']) for frame in frames)
        service_samples += service
        empty_stacks += not frames
        unknown_frames += any(unknown_frame(frame) for frame in frames)
        phase = 'remaining service' if service else 'caller/runtime/unresolved'
        phase_symbol = None
        operation_symbol = None
        if service:
            for frame in frames:
                symbol = frame['symbol']
                if peer == 'fwp':
                    name = source_name(symbol, functions)
                    if name in PHASES:
                        phase = PHASES[name]
                        phase_symbol = symbol
                        break
                elif PEER_DISPATCH[peer].search(symbol):
                    phase = 'dispatch'
                    phase_symbol = symbol
                    break
        operation = 'remaining operation' if frames else 'unavailable'
        matched = False
        for frame in frames:
            for label, pattern in OPERATIONS:
                if pattern.search(frame['symbol']):
                    operation = label
                    operation_symbol = frame['symbol']
                    matched = True
                    break
            if matched:
                break
        leaf = frames[0] if frames else dict(dso='[unavailable]',symbol='[no decoded frame]')
        key = (phase, operation, phase_symbol, operation_symbol, leaf['dso'], leaf['symbol'])
        row = groups.setdefault(key, dict(phase=phase, operation=operation, phaseSymbol=phase_symbol, operationSymbol=operation_symbol, dso=leaf['dso'], symbol=leaf['symbol'], samples=0, period=0))
        row['samples'] += 1
        row['period'] += sample['period']
    assert service_samples > 0, 'no resolved service entry frames'
    rows = sorted(groups.values(),key=lambda r:(-r['period'],r['phase'],r['operation'],r['symbol']))
    total = sum(row['period'] for row in rows)
    for row in rows:
        row['overheadPercent'] = 100*row['period']/total
    return dict(samples=len(samples),period=total,serviceSamples=service_samples,
                samplesWithUnknownFrames=unknown_frames,samplesWithoutFrames=empty_stacks,rows=rows)
