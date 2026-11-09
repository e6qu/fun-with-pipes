"""Fixed populations and strict output checks for returned-buffer phases."""
import json
import statistics

CASES = ((0, 4096), (16, 4096), (4096, 256), (262144, 4))
BATCHES = (16, 64, 256, 1024)
PEERS = ('c', 'rs', 'swift', 'fwp')
LABELS = tuple(peer + suffix for peer in PEERS for suffix in ('', '-copy'))
PHASES = ('construction', 'reading', 'release', 'process')
ROUNDS = 16
PILOT_NS = 50_000_000
MIN_PHASE_NS = 5_000_000
COPY_LIMIT = 1.02


def decode_output(text, length, population, batches, shared):
    assert (length, population) in CASES and batches in BATCHES and shared in (0, 1)
    row = json.loads(text)
    assert isinstance(row, dict) and set(row) == {'checksum', 'construction', 'reading', 'release'}, row
    assert all(type(value) is int and value >= 0 for value in row.values()), row
    # Require the actual one-line producer format, including no duplicated keys.
    assert text == json.dumps(row, separators=(',', ':')) + '\n', text
    assert row['checksum'] == length * (length - 1) // 2 * population * batches * (shared + 1), row
    return row


def order(round_number):
    assert type(round_number) is int and round_number >= 0
    return [LABELS[(index + round_number) % 8] for index in (0, 1, 7, 2, 6, 3, 5, 4)]


def select_pilot(observations, length, population, shared):
    """Require the first qualifying C trial, or every trial through the cap."""
    assert 1 <= len(observations) <= len(BATCHES)
    for index, observation in enumerate(observations):
        assert observation['batches'] == BATCHES[index]
        row = decode_output(observation['stdout'], length, population, BATCHES[index], shared)
        duration = sum(row[phase] for phase in PHASES[:3])
        if index < len(observations) - 1:
            assert duration < PILOT_NS, 'pilot continued after its first qualifying trial'
        else:
            assert duration >= PILOT_NS or index == len(BATCHES) - 1, 'pilot stopped early'
    return observations[-1]['batches']


def summarize(samples):
    assert len(samples) == ROUNDS * len(LABELS)
    values = {phase: {label: [] for label in LABELS} for phase in PHASES}
    for index, row in enumerate(samples):
        round_number, position = divmod(index, len(LABELS))
        assert (row['round'], row['position'], row['label']) == (round_number, position, order(round_number)[position])
        assert set(row['ns']) == set(PHASES)
        for phase, value in row['ns'].items():
            assert type(value) is int and value >= 0, row
            values[phase][row['label']].append(value)
        assert row['ns']['process'] > 0 and sum(row['ns'][phase] for phase in PHASES[:3]) <= row['ns']['process']
    result = {}
    for phase, rows in values.items():
        medians = {label: statistics.median(durations) for label, durations in rows.items()}
        copies = {}
        qualified = {}
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
