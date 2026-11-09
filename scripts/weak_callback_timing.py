"""Frozen service timing inputs, exact outputs and copy-noise qualification."""
import json
import statistics

from weak_callback_service import CASES, expected, unique_fields

PEERS = ('c', 'rs', 'swift', 'fwp')
LABELS = tuple(peer + suffix for peer in PEERS for suffix in ('', '-copy'))
BATCHES = (16, 64, 256, 1024, 4096, 16384)
ROUNDS = 16
PILOT_NS = 50_000_000
MINIMUM_NS = 5_000_000
COPY_LIMIT = 1.02
DURATIONS = ('service', 'process')


def decode_output(text, population, mode, batches):
    assert (population, mode) in CASES and batches in (1, *BATCHES)
    row = json.loads(text, object_pairs_hook=unique_fields)
    assert isinstance(row, dict) and all(type(value) is int for value in row.values())
    want = expected(population, mode)
    want = {key: value if key in ('population', 'mode') else value * batches for key, value in want.items()}
    assert set(row) == {*want, 'batches', 'serviceNs'} and row['serviceNs'] >= 0
    assert row == want | dict(batches=batches, serviceNs=row['serviceNs']), row
    return row


def order(round_number):
    assert type(round_number) is int and round_number >= 0
    return [LABELS[(index + round_number) % 8] for index in (0, 1, 7, 2, 6, 3, 5, 4)]


def select_pilot(observations, population, mode):
    assert (population, mode) in CASES and 1 <= len(observations) <= len(BATCHES)
    for index, observation in enumerate(observations):
        assert observation['batches'] == BATCHES[index]
        row = decode_output(observation['stdout'], population, mode, BATCHES[index])
        if index < len(observations) - 1:
            assert row['serviceNs'] < PILOT_NS, 'pilot continued after first qualifying trial'
        else:
            assert row['serviceNs'] >= PILOT_NS or index == len(BATCHES) - 1, 'pilot stopped early'
    return observations[-1]['batches']


def summarize(samples):
    assert len(samples) == ROUNDS * len(LABELS)
    values = {duration: {label: [] for label in LABELS} for duration in DURATIONS}
    for index, row in enumerate(samples):
        round_number, position = divmod(index, len(LABELS))
        assert (row['round'], row['position'], row['label']) == (round_number, position, order(round_number)[position])
        assert set(row['ns']) == set(DURATIONS)
        assert all(type(value) is int and value >= 0 for value in row['ns'].values())
        assert 0 < row['ns']['process'] and row['ns']['service'] <= row['ns']['process']
        for duration, value in row['ns'].items():
            values[duration][row['label']].append(value)
    result = {}
    for duration, rows in values.items():
        medians = {label: statistics.median(values) for label, values in rows.items()}
        copies, qualified = {}, {}
        for peer in PEERS:
            low, high = sorted((medians[peer], medians[peer + '-copy']))
            copies[peer] = high / low if low else None
            qualified[peer] = low >= MINIMUM_NS and copies[peer] <= COPY_LIMIT
        result[duration] = dict(medianNs=medians, copyRatios=copies, qualified=qualified,
            fwpOverPeer={peer: medians['fwp'] / medians[peer] if medians[peer] else None for peer in PEERS[:-1]},
            peerQualified={peer: qualified['fwp'] and qualified[peer] for peer in PEERS[:-1]})
    return result
