"""Instrument raw derivative allocation sites in generated C, for experiments."""
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent


def replace_once(source, old, new):
    if source.count(old) != 1:
        raise ValueError(f'Expected one derivative observation site: {old!r}')
    return source.replace(old, new)


def instrument(source):
    """Observe physical allocation/free operations without changing timed code."""
    marker = '/* ------------------------------------------------------------------ tapes */'
    probe = (ROOT / 'tests/fixtures/ad_raw_storage_probe.c').read_text()
    source = replace_once(source, marker, probe + '\n' + marker)
    for old, new in [
        ('realloc(t->pa, (size_t)cap * (2 * sizeof(int32_t)))',
         'ad_raw_realloc(t->pa, (size_t)cap * (2 * sizeof(int32_t)), AD_PARENTS)'),
        ('realloc(t->da, (size_t)cap * (2 * sizeof(double)))',
         'ad_raw_realloc(t->da, (size_t)cap * (2 * sizeof(double)), AD_PARTIALS)'),
        ('realloc(fwp_tapes, (size_t)cap * sizeof(fwp_tape))',
         'ad_raw_realloc(fwp_tapes, (size_t)cap * sizeof(fwp_tape), AD_REGISTRY)'),
        ('realloc(buffers.adj, (size_t)capacity * sizeof(double))',
         'ad_raw_realloc(buffers.adj, (size_t)capacity * sizeof(double), AD_ADJOINTS)'),
        ('calloc((size_t)capacity, sizeof(double))',
         'ad_raw_calloc((size_t)capacity, sizeof(double), AD_ADJOINTS)'),
    ]:
        source = replace_once(source, old, new)
    for pointer in ['b->pa', 'b->da', 'b->adj', 't->pa', 't->da', 't->adj', 'fwp_tapes']:
        source = replace_once(source, f'free({pointer});', f'ad_raw_free({pointer});')
    source = replace_once(source, '} else fwp_tape_buffers_dispose(b);\n}',
                          '} else fwp_tape_buffers_dispose(b);\n'
                          '    ad_raw_sample((size_t)fwp_tapes_cap * sizeof(fwp_tape), fwp_tape_cached_bytes);\n}')
    # The observer runs after the real atexit tape cleanup. Register it first;
    # atexit executes in reverse order. No extra cleanup is introduced here.
    source = replace_once(source, 'iteration_active=1;\n',
                          'iteration_active=1;\n'
                          '    if (atexit(ad_raw_report)) ad_raw_fail("atexit registration failed");\n')
    source = replace_once(source, '    iteration_active=0;',
                          '    ad_raw_before_shutdown=ad_raw_total();\n    iteration_active=0;')
    return source


def check_profile(report, updates, workspace):
    """Require bounded idle storage and real shutdown release for this workload."""
    assert report['finalBytes'] == 0
    checkpoints = report['afterBackward']
    assert len(checkpoints) == updates, (len(checkpoints), updates)
    if not checkpoints:
        assert report['peakBytes'] == report['beforeShutdownBytes'] == 0
        return
    assert all(point == checkpoints[0] for point in checkpoints), checkpoints
    point = checkpoints[-1]
    assert point['otherBytes'] == 0, point
    assert 0 <= point['workspaceBytes'] <= 512 * 1024, point
    assert bool(point['workspaceBytes']) == workspace, point
    assert report['beforeShutdownBytes'] == point['registryBytes'] + point['workspaceBytes']
