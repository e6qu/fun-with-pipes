"""Fixed populations and strict output checks for returned-buffer phases."""
import json

CASES = ((0, 4096), (16, 4096), (4096, 256), (262144, 4))
BATCHES = (16, 64, 256, 1024)


def decode_output(text, length, population, batches, shared):
    assert (length, population) in CASES and batches in BATCHES and shared in (0, 1)
    row = json.loads(text)
    assert isinstance(row, dict) and set(row) == {'checksum', 'construction', 'reading', 'release'}, row
    assert all(type(value) is int and value >= 0 for value in row.values()), row
    # Require the actual one-line producer format, including no duplicated keys.
    assert text == json.dumps(row, separators=(',', ':')) + '\n', text
    assert row['checksum'] == length * (length - 1) // 2 * population * batches * (shared + 1), row
    return row
