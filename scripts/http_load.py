"""Read every closed-loop HTTP attempt, with explicit warmup and late outcomes."""
import gzip
import math
from pathlib import Path
import struct

REQUEST = b'GET /items/42 HTTP/1.1\r\nhost: test\r\ncontent-length: 0\r\nconnection: keep-alive\r\n\r\n'
BODY = b'{"id":42,"name":"item 42"}'
ROW = struct.Struct('<QQIIII')


def response_ok(wire):
    header, separator, body = wire.partition(b'\r\n\r\n')
    if not separator or body != BODY:
        return False
    lines = header.split(b'\r\n')
    if lines[0] != b'HTTP/1.1 200 OK':
        return False
    headers = {}
    for line in lines[1:]:
        key, separator, value = line.partition(b':')
        key = key.lower()
        if not separator or key in headers:
            return False
        headers[key] = value.strip().lower()
    return (headers.get(b'content-length') == str(len(BODY)).encode()
            and b'transfer-encoding' not in headers and headers.get(b'connection') != b'close')


def wires(path):
    data = path.read_bytes()
    result = []
    offset = 0
    while offset < len(data):
        assert len(data) - offset >= 4, 'truncated response dictionary length'
        length, = struct.unpack_from('<I', data, offset)
        offset += 4
        assert length <= 9216 and offset + length <= len(data), 'truncated/oversized response'
        result.append(data[offset:offset + length])
        offset += length
    return result


def percentiles(values):
    if not values:
        return None
    values.sort()
    return {name: values[max(0, math.ceil(len(values) * p) - 1)] / 1e6
            for name, p in [('medianMs', .5), ('p95Ms', .95), ('p99Ms', .99)]}


def audit(directory, header, compressed):
    directory = Path(directory)
    assert (directory / 'request.bin').read_bytes() == REQUEST
    start = header['warmupNs']
    end = start + header['durationNs']
    assert start >= 0 and end > start and header['deadlineNs'] > 0
    result = dict(totalAttempts=0, warmupAttempts=0, measuredAttempts=0,
                  correctInWindow=0, correctLate=0, measuredFailures=0,
                  allFailures=0, requestBytes=0, responseBytes=0, workers=[])
    successes = []
    outcomes = []
    for worker in range(header['connections']):
        dictionary = wires(directory / f'worker-{worker}.wire')
        counts = dict(id=worker, attempts=0, failures=0, lastEndNs=0)
        used = set()
        sample_path = directory / (f'worker-{worker}.bin.gz' if compressed else f'worker-{worker}.bin')
        stream = gzip.open(sample_path, 'rb') if compressed else sample_path.open('rb')
        with stream:
            while chunk := stream.read(ROW.size * 32768):
                assert len(chunk) % ROW.size == 0, 'truncated attempt record'
                for begun, finished, sent, received, outcome, wire_id in ROW.iter_unpack(chunk):
                    assert 0 <= counts['lastEndNs'] <= begun <= finished and begun < end
                    assert outcome in range(5) and sent <= len(REQUEST)
                    assert wire_id < len(dictionary) and received == len(dictionary[wire_id])
                    assert counts['failures'] == 0, 'a failed connection was retried'
                    used.add(wire_id)
                    counts['lastEndNs'] = finished
                    counts['attempts'] += 1
                    counts['failures'] += outcome != 0
                    result['totalAttempts'] += 1
                    result['allFailures'] += outcome != 0
                    result['requestBytes'] += sent
                    result['responseBytes'] += received
                    if outcome == 0:
                        assert sent == len(REQUEST) and response_ok(dictionary[wire_id]), 'incorrect successful response'
                    if begun < start:
                        result['warmupAttempts'] += 1
                        continue
                    result['measuredAttempts'] += 1
                    latency = finished - begun
                    outcomes.append(latency)
                    if outcome == 0:
                        successes.append(latency)
                        result['correctInWindow' if finished <= end else 'correctLate'] += 1
                    else:
                        result['measuredFailures'] += 1
        assert used == set(range(len(dictionary))), 'unreferenced response bytes'
        result['workers'].append(counts)
    assert result['totalAttempts'] == header['attempts']
    assert result['allFailures'] == header['failures']
    assert result['measuredAttempts'] == result['correctInWindow'] + result['correctLate'] + result['measuredFailures']
    result.update(completedPerSecond=result['correctInWindow'] / (header['durationNs'] / 1e9),
                  failureFraction=result['measuredFailures'] / result['measuredAttempts'] if result['measuredAttempts'] else None,
                  successfulResponseLatency=percentiles(successes), timeToResponseOrFailure=percentiles(outcomes),
                  setupErrors=header['setupErrors'], windowNs=header['durationNs'])
    return result
