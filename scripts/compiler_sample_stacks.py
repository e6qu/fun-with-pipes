"""Attribute compiler CPU stacks to type checking, keeping unmatched samples."""
import re

from cpu_samples import unknown_frame


def attribute(samples, flat):
    assert len(samples) == sum(row['samples'] for row in flat), 'stack sample count differs from flat report'
    assert sum(sample['period'] for sample in samples) == sum(row['period'] for row in flat), 'stack periods differ from flat report'
    groups = {}
    unresolved = 0
    unavailable = 0
    for sample in samples:
        frames = sample['frames']
        if frames:
            leaf = frames[0]
            parent = next((frame['symbol'] for frame in frames
                           if re.search(r'::infer::Infer>?::check_(binding|effects)\b', frame['symbol'])), '[other]')
            key = (parent, leaf['dso'], leaf['symbol'])
        else:
            # perf can emit a sample header with an empty unwind cursor. Keep
            # its period, but do not invent an instruction, symbol or caller.
            unavailable += 1
            key = ('[unavailable]', '[unavailable]', '[no decoded frame]')
        row = groups.setdefault(key, dict(parent=key[0], dso=key[1], symbol=key[2], samples=0, period=0))
        row['samples'] += 1
        row['period'] += sample['period']
        if any(unknown_frame(frame) for frame in frames):
            unresolved += 1
    rows = sorted(groups.values(), key=lambda row: (-row['period'], row['parent'], row['symbol']))
    total = sum(row['period'] for row in rows)
    for row in rows:
        row['overheadPercent'] = row['period'] * 100 / total
    assert any(re.search(r'::infer::Infer>?::check_binding\b', row['parent']) for row in rows), 'no decoded body-checking caller stacks'
    return dict(samples=len(samples), period=total, samplesWithUnknownFrames=unresolved,
                samplesWithoutFrames=unavailable, rows=rows)
