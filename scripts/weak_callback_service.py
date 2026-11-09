"""Matched service results and actual delivery/release fault sources."""
import json

CASES = tuple((population, mode) for population in (64, 4096) for mode in range(4))


def expected(population, mode):
    accepted = [index for index in range(population)
                if mode != 2 and (mode != 1 or index % 4 != 0)
                and (mode != 3 or index <= population // 2)]
    checksum = sum(sum(range(index, index + 16)) for index in accepted)
    return dict(population=population, mode=mode, calls=len(accepted),
                cancelled=sum(index % 4 == 0 for index in range(population)) if mode == 1 else 0,
                expired=population if mode == 2 else 0, errors=int(mode == 3),
                sent=len(accepted), received=len(accepted), sum=checksum, received_sum=checksum)


def unique_fields(pairs):
    result = dict(pairs)
    assert len(result) == len(pairs), 'duplicate service result field'
    return result


def decode_output(output):
    rows = [json.loads(line, object_pairs_hook=unique_fields) for line in output.splitlines()]
    assert len(rows) == len(CASES), 'missing service cases'
    for row, (population, mode) in zip(rows, CASES):
        assert isinstance(row, dict) and all(type(value) is int for value in row.values()), row
        assert row == expected(population, mode), (row, expected(population, mode))
    return rows


def decode_missing_delivery(output):
    rows = [json.loads(line, object_pairs_hook=unique_fields) for line in output.splitlines()]
    assert len(rows) == len(CASES)
    for row, case in zip(rows, CASES):
        assert isinstance(row, dict) and all(type(value) is int for value in row.values())
        assert row == expected(*case) | dict(received=0, received_sum=0), row
    try:
        decode_output(output)
    except AssertionError:
        return rows
    raise AssertionError('missing delivery accepted by ordinary oracle')


def replace_once(source, before, after):
    assert source.count(before) == 1, ('changed service fault boundary', before)
    return source.replace(before, after)


def variants(language, source):
    delivery = {
        'c': ('active->inbox[active->length++] = entry->values;',
              '(void)active; drop_payload(entry->values);'),
        'rs': ('active.inbox.borrow_mut().push(payload);', 'let _ = active; drop(payload);'),
        'swift': ('active.inbox.append(payload)', 'withExtendedLifetime(payload) {}'),
        'fwp': ('channel.send owner payload', '(owner, payload) | ignore'),
    }
    result = {'ordinary': source, 'missing-delivery': replace_once(source, *delivery[language])}
    if language == 'c':
        result.update({
            'omitted-payload-release': replace_once(source, '    payloads--;\n    free(payload);', ''),
            'omitted-registration-release': replace_once(source, '    drop_weak(entry->weak);', ''),
        })
    return result
