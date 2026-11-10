"""Frozen four-way service timing order, copy controls and runtime acceptance."""
import statistics

from weak_callback_timing import COPY_LIMIT, MINIMUM_NS, ROUNDS

LABELS = ('reference', 'reference-copy', 'candidate', 'candidate-copy')


def order(round_number):
    assert type(round_number) is int and round_number >= 0
    return [LABELS[(index + round_number) % 4] for index in (0, 1, 3, 2)]


def summarize(samples, population):
    assert population in (64, 4096) and len(samples) == ROUNDS * 4
    values = {duration: {label: [] for label in LABELS} for duration in ('service', 'process')}
    for index, row in enumerate(samples):
        round_number, position = divmod(index, 4)
        assert (row['round'], row['position'], row['label']) == (round_number, position, order(round_number)[position])
        assert set(row['ns']) == set(values)
        assert all(type(value) is int and value >= 0 for value in row['ns'].values())
        assert 0 < row['ns']['process'] and row['ns']['service'] <= row['ns']['process']
        for duration, value in row['ns'].items():
            values[duration][row['label']].append(value)
    result = {}
    for duration, rows in values.items():
        medians = {label: statistics.median(readings) for label, readings in rows.items()}
        copies = {}
        for role in ('reference', 'candidate'):
            low, high = sorted((medians[role], medians[role + '-copy']))
            copies[role] = high / low if low else None
        qualified = min(medians.values()) >= MINIMUM_NS and all(value is not None and value <= COPY_LIMIT for value in copies.values())
        ratio = medians['candidate'] / medians['reference'] if medians['reference'] else None
        result[duration] = dict(medianNs=medians, copyRatios=copies, qualified=qualified,
                                candidateOverReference=ratio,
                                timingTargetMet=qualified and ratio <= (.90 if population == 4096 else 1.02))
    return result
