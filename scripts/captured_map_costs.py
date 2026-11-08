"""Frozen programs and ordinary driver for captured scalar map measurements."""
from pathlib import Path
import re
import struct

ROOT = Path(__file__).resolve().parent.parent


def program(kind):
    ty = {'sensor': 'F64', 'pixels': 'U8'}[kind]
    return f'''export measure : {ty} -> {ty} -> I64 -> Array[{ty}] -> Array[{ty}]
measure = fn scale -> fn offset -> fn updates -> fn values ->
    (updates, values) | loop (fn (remaining, current) ->
        remaining == 0 | match
            True -> Stop current
            False -> Again (remaining - 1,
                current | array.map (fn value -> value * scale + offset)))
'''


def cases():
    for kind in ('sensor', 'pixels'):
        for count in (0, 16, 65537, 262145):
            for updates in (1, 199):
                for sharing in (0, 1, 2):
                    repeats = 256 if count <= 16 else (8 if updates == 1 else 1)
                    yield dict(name=f'{kind}-{count}-{updates}-{sharing}', kind=kind,
                               count=count, updates=updates, sharing=sharing, repeats=repeats)


def expected(kind, count, updates):
    values = [i % 17 for i in range(count)]
    if kind == 'sensor':
        return [struct.unpack('>Q', struct.pack('>d', float(value) + updates * 0.25))[0]
                for value in values]
    assert kind == 'pixels' and max(values, default=0) + updates <= 255
    return [value + updates for value in values]


def raw_program(case):
    suffix, coefficients = ('', '1.0 0.25') if case['kind'] == 'sensor' else ('u8', '1u8 1u8')
    values = ', '.join(str(i % 17) + ('.0' if case['kind'] == 'sensor' else suffix) for i in range(case['count']))
    return program(case['kind']) + f'main = [{values}] | array.from-list | measure {coefficients} {case["updates"]} | array.to-list | echo\n'


def driver(generated, case):
    marker = '/* measure :'
    assert generated.count(marker) == 1
    entry = re.search(r'static V (f\d+)\(([^)]*)\)', generated.split(marker)[1])
    assert entry and entry[2] == 'V l0, V l1, V l2, V l3', 'require the declared four-argument native entry'
    main = 'int main(int argc, char **argv)'
    assert generated.count(main) == 1
    harness = (ROOT / 'tests/fixtures/captured_map_timing.c').read_text()
    sensor = case['kind'] == 'sensor'
    replacements = dict(SENSOR=str(int(sensor)), ELEMENT_KIND='K_F64' if sensor else 'K_U8',
        INPUT_COUNT=str(case['count']), REPEAT_COUNT=str(case['repeats']),
        UPDATE_COUNT=str(case['updates']), SHARING=str(case['sharing']),
        SCALE_WORD='fwp_from_f64(1.0)' if sensor else '(V)1',
        OFFSET_WORD='fwp_from_f64(0.25)' if sensor else '(V)1', MEASURE_ENTRY=entry[1])
    for key, value in replacements.items():
        assert key in harness
        harness = harness.replace(key, value)
    return generated.replace(main, 'int original_main(int argc, char **argv)') + '\n' + harness
