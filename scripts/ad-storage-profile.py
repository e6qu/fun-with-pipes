"""Instrument raw derivative allocation sites in generated C, for experiments."""
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent


def replace_once(source, old, new):
    if source.count(old) != 1:
        raise ValueError(f'Expected one derivative observation site: {old!r}')
    return source.replace(old, new)


def instrument(source, layout):
    """Observe physical allocation/free operations without changing timed code."""
    marker = '/* ------------------------------------------------------------------ tapes */'
    probe = (ROOT / 'tests/fixtures/ad_raw_storage_probe.c').read_text()
    if layout == 'records':
        allocations = [('parents', '(size_t)cap * sizeof(fwp_tape_parents)', 'AD_PARENTS'),
                       ('ops', '(size_t)cap * sizeof(fwp_tape_op)', 'AD_OPERATIONS')]
        fields = ['ops', 'parents', 'adj']
    elif layout == 'columns':
        allocations = [('pa', '(size_t)cap * (2 * sizeof(int32_t))', 'AD_PARENTS'),
                       ('da', '(size_t)cap * (2 * sizeof(double))', 'AD_PARTIALS')]
        fields = ['pa', 'da', 'adj']
        probe = probe.replace('AD_OPERATIONS', 'AD_PARTIALS').replace('"operations"', '"partials"')
    else:
        raise ValueError(f'Unknown tape layout: {layout!r}')
    source = replace_once(source, marker, probe + '\n' + marker)
    for field, size, kind in allocations:
        source = replace_once(source, f'realloc(t->{field}, {size})',
                              f'ad_raw_realloc(t->{field}, {size}, {kind})')
    for old, new in [
        ('realloc(fwp_tapes, (size_t)cap * sizeof(fwp_tape))',
         'ad_raw_realloc(fwp_tapes, (size_t)cap * sizeof(fwp_tape), AD_REGISTRY)'),
        ('realloc(buffers.adj, (size_t)capacity * sizeof(double))',
         'ad_raw_realloc(buffers.adj, (size_t)capacity * sizeof(double), AD_ADJOINTS)'),
        ('calloc((size_t)capacity, sizeof(double))',
         'ad_raw_calloc((size_t)capacity, sizeof(double), AD_ADJOINTS)'),
    ]:
        source = replace_once(source, old, new)
    for pointer in [owner + '->' + field for owner in ('b', 't') for field in fields] + ['fwp_tapes']:
        source = replace_once(source, f'free({pointer});', f'ad_raw_free({pointer});')
    source = replace_once(source, '} else fwp_tape_buffers_dispose(b);\n}',
                          '} else fwp_tape_buffers_dispose(b);\n'
                          '    ad_raw_sample((size_t)fwp_tapes_cap * sizeof(fwp_tape), fwp_tape_cached_bytes);\n}')
    # Typed/nested backward passes dispose their parent buffers directly. Sample
    # after both typed values and raw buffers are released, while enclosing tapes
    # may still be live. Do not add cleanup or count the final shutdown as a pass.
    owned_release = '    fwp_cleanup_pop(&tape_cleanup); fwp_tape_buffers_dispose(&buffers);\n'
    source = replace_once(source, owned_release, owned_release +
                          '    ad_raw_sample((size_t)fwp_tapes_cap * sizeof(fwp_tape), fwp_tape_cached_bytes);\n')
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


def record_layout_failures(current, reference):
    """Compare raw numeric storage with the declared column-layout peer."""
    checks = []
    kinds, old = current['kinds'], reference['kinds']
    assert set(kinds) == {'registry', 'parents', 'operations', 'adjoints'}
    assert set(old) == {'registry', 'parents', 'partials', 'adjoints'}
    for key in ('requests', 'requestedBytes', 'peakBytes'):
        checks.append(('unused typed parents/' + key, kinds['parents'][key], 0, False))
        checks.append(('adjoints/' + key, kinds['adjoints'][key], old['adjoints'][key], False))
    checks.append(('numeric growth requests', kinds['operations']['requests'], old['parents']['requests'], False))
    checks.append(('reference paired growth requests', old['parents']['requests'], old['partials']['requests'], False))
    for key in ('requestedBytes', 'peakBytes'):
        checks.append(('numeric payload/' + key, kinds['operations'][key], old['parents'][key] + old['partials'][key], False))
        checks.append(('registry/' + key, kinds['registry'][key], old['registry'][key], True))
    checks.append(('registry requests', kinds['registry']['requests'], old['registry']['requests'], False))
    for key in ('peakBytes', 'beforeShutdownBytes'):
        checks.append((key, current[key], reference[key], True))
    for label, report in [('candidate', current), ('reference', reference)]:
        checks.append((label + ' final bytes', report['finalBytes'], 0, False))
    return [dict(metric=metric, actual=actual, expected=expected, requirement='at most' if upper else 'equal')
            for metric, actual, expected, upper in checks
            if (actual > expected if upper else actual != expected)]
