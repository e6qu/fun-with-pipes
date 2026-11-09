"""Strict weak-operation results and frozen paired timing protocol."""
import json
import statistics

PHASES = ('targetCreation', 'weakCreation', 'liveLookup', 'ownerRelease', 'expiredLookup', 'weakRelease')
CASES = ((1, 1), (64, 16), (4096, 1), (4096, 64))
BATCHES = (16, 64, 256, 1024)
PEERS = ('c', 'rs', 'swift', 'fwp')
LABELS = tuple(peer + suffix for peer in PEERS for suffix in ('', '-copy'))
DURATIONS = (*PHASES, 'process')
ROUNDS = 16
PILOT_NS = 50_000_000
MIN_PHASE_NS = 5_000_000
COPY_LIMIT = 1.02


def decode_output(text, population, lookups, batches):
    row = json.loads(text)
    assert isinstance(row, dict) and set(row) == {'live', 'expired', *PHASES}
    assert all(type(value) is int and value >= 0 for value in row.values())
    assert text == json.dumps(row, separators=(',', ':')) + '\n'
    assert row['live'] == population * lookups * batches and row['expired'] == 0
    return row



def order(round_number):
    assert type(round_number) is int and round_number >= 0
    return [LABELS[(index + round_number) % 8] for index in (0, 1, 7, 2, 6, 3, 5, 4)]


def select_pilot(observations, population, lookups):
    assert (population, lookups) in CASES and 1 <= len(observations) <= len(BATCHES)
    for index, observation in enumerate(observations):
        assert observation['batches'] == BATCHES[index]
        row = decode_output(observation['stdout'], population, lookups, BATCHES[index])
        duration = sum(row[phase] for phase in PHASES)
        if index < len(observations) - 1:
            assert duration < PILOT_NS, 'pilot continued after first qualifying trial'
        else:
            assert duration >= PILOT_NS or index == len(BATCHES) - 1, 'pilot stopped early'
    return observations[-1]['batches']


def summarize(samples):
    assert len(samples) == ROUNDS * len(LABELS)
    values = {phase: {label: [] for label in LABELS} for phase in DURATIONS}
    for index, row in enumerate(samples):
        round_number, position = divmod(index, len(LABELS))
        assert (row['round'], row['position'], row['label']) == (round_number, position, order(round_number)[position])
        assert set(row['ns']) == set(DURATIONS)
        for phase, value in row['ns'].items():
            assert type(value) is int and value >= 0, row
            values[phase][row['label']].append(value)
        assert row['ns']['process'] > 0 and sum(row['ns'][phase] for phase in PHASES) <= row['ns']['process']
    result = {}
    for phase, rows in values.items():
        medians = {label: statistics.median(durations) for label, durations in rows.items()}
        copies, qualified = {}, {}
        for peer in PEERS:
            low = min(medians[peer], medians[peer + '-copy'])
            high = max(medians[peer], medians[peer + '-copy'])
            copies[peer] = high / low if low else None
            qualified[peer] = low >= MIN_PHASE_NS and copies[peer] <= COPY_LIMIT
        result[phase] = dict(medianNs=medians, copyRatios=copies, qualified=qualified,
                            fwpOverPeer={peer: medians['fwp'] / medians[peer] if medians[peer] else None
                                         for peer in PEERS[:-1]},
                            peerQualified={peer: qualified['fwp'] and qualified[peer] for peer in PEERS[:-1]})
    return result
