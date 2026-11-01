"""Observe successful scalar F64 derivative phases without timing each tape node."""
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
PHASES = ('setup', 'forwardWithRecording', 'reverseSetup', 'reverseTraversal',
          'resultArray', 'retirement')
TIME_OBSERVER = (ROOT / 'tests/fixtures/descent_phases.c').read_text()


def instrument(source, observer):
    """Require exact runtime sites; reject unsupported/nested tapes in the probe."""
    changes = [
        ('/* ------------------------------------------------------------------ tapes */',
         observer + '\n/* ------------------------------------------------------------------ tapes */'),
        ('static V fwp_ad_tape_new(V nv, fwp_owned_tape *owned) {',
         'static V fwp_ad_tape_new(V nv, fwp_owned_tape *owned) {\n'
         '    if (owned) descent_phase_fail();\n'
         '    descent_phase_step(DESCENT_SETUP);'),
        ('    return (V)(id << 32);',
         '    descent_phase_step(DESCENT_FORWARD);\n    return (V)(id << 32);'),
        ('static V fwp_p_ad_backward(V base, V outs, V seeds) {',
         'static V fwp_p_ad_backward(V base, V outs, V seeds) {\n'
         '    descent_phase_step(DESCENT_REVERSE_SETUP);'),
        ('    for (int64_t i = active - 1; i >= tp.leaves; i--) {',
         '    descent_inputs += (uint64_t)tp.leaves;\n'
         '    descent_nodes += (uint64_t)(active - tp.leaves);\n'
         '    descent_phase_step(DESCENT_REVERSE);\n'
         '    for (int64_t i = active - 1; i >= tp.leaves; i--) {'),
        ('    V r = fwp_arr_new((size_t)tp.leaves);',
         '    descent_phase_step(DESCENT_RESULT);\n'
         '    V r = fwp_arr_new((size_t)tp.leaves);'),
        ('    for (int64_t i = 0; i < tp.leaves; i++) ARR(r)->d[i] = fwp_from_f64(adj[i]);',
         '    for (int64_t i = 0; i < tp.leaves; i++) ARR(r)->d[i] = fwp_from_f64(adj[i]);\n'
         '    descent_phase_step(DESCENT_RETIRE);'),
        ('    fwp_tape_buffers_release(&buffers);\n    return r;',
         '    fwp_tape_buffers_release(&buffers);\n'
         '    descent_phase_step(DESCENT_PHASES);\n    return r;'),
    ]
    for old, new in changes:
        if source.count(old) != 1:
            raise ValueError(f'Expected one derivative phase site: {old!r}')
        source = source.replace(old, new)
    # Register even for zero updates; the report must contain six zero totals.
    marker = 'static void *fwp_main_thread(void *arg) {'
    if source.count(marker) != 1:
        raise ValueError('Expected executable main thread')
    start = source.index(marker)
    prefix, main = source[:start], source[start:]
    marker = '    fwp_init_consts();\n'
    if main.count(marker) != 1:
        raise ValueError('Expected main constant initialization')
    return prefix + main.replace(marker, marker + '    descent_phase_init();\n')


def check(report, dimensions, updates):
    row = report['derivativePhases']
    assert set(row) == {'updates', 'inputs', 'nodes', 'nanoseconds'}
    assert row['updates'] == updates and row['inputs'] == dimensions * updates
    assert type(row['nodes']) is int and row['nodes'] >= 0
    assert bool(row['nodes']) == bool(updates)
    assert set(row['nanoseconds']) == set(PHASES)
    assert all(type(n) is int and n >= 0 for n in row['nanoseconds'].values())
    # Successful tiny phases may fall below the host clock's resolution.
    if not updates:
        assert not any(row['nanoseconds'].values())
