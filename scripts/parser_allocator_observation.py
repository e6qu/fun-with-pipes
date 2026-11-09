"""Validate actual allocator resize events, not endpoint-only overlap estimates."""


def check_observation(report):
    assert report['exitCode'] == 0 and report['errors'] == []
    libraries = [obj for obj in report['objects'] if obj['path'].endswith('/libc.so.6')]
    assert len(libraries) == 1 and libraries[0]['buildId'], 'missing loaded libc identity'
    libc = libraries[0]
    debug = [obj for obj in report['objects'] if obj['debugOwner'] == libc['path']]
    assert len(debug) == 1 and debug[0]['buildId'] == libc['buildId'], 'libc/debug build IDs differ'
    assert report['sourceLocations'] and all(row['file'] and row['line'] > 0 for row in report['sourceLocations'])
    events = report['events']
    assert {row['case'] for row in events} == {1, 2, 3, 4}
    assert [row['case'] for row in events] == sorted(row['case'] for row in events)
    for case, requested in ((1, 72), (2, 8192), (3, 4096), (4, (1 << 64) - 1)):
        rows = [row for row in events if row['case'] == case]
        assert rows[0]['kind'] == 'resize-enter' and rows[-1]['kind'] == 'resize-return'
        assert rows[0]['requested'] == requested and rows[0]['pointer'] > 0
        assert sum(row['kind'] == 'resize-enter' for row in rows) == 1
        assert sum(row['kind'] == 'resize-return' for row in rows) == 1
        allocations = [(index, row) for index, row in enumerate(rows) if row['kind'] == 'internal-allocation-return']
        releases = [(index, row) for index, row in enumerate(rows) if row['kind'] == 'internal-free-enter' and row['releasesOld']]
        if case == 2:
            assert rows[-1]['pointer'] != rows[0]['pointer'] and rows[-1]['pointer'] > 0
            assert len(allocations) == len(releases) == 1, 'moving resize lacked actual allocation/free boundaries'
            entered = [(index, row) for index, row in enumerate(rows) if row['kind'] == 'internal-allocation-enter']
            assert len(entered) == 1 and entered[0][0] < allocations[0][0]
            assert entered[0][1]['requested'] >= requested
            assert allocations[0][1]['pointer'] == rows[-1]['pointer']
            assert allocations[0][0] < releases[0][0] < len(rows) - 1, 'replacement must exist before old release'
            arena = [row for row in rows if row['kind'] == 'arena-resize-enter']
            assert len(arena) == 1 and arena[0]['oldChunk'] == releases[0][1]['chunk']
            assert rows[0]['pointer'] > arena[0]['oldChunk']
        else:
            assert not allocations and not releases
            assert rows[-1]['pointer'] == (0 if case == 4 else rows[0]['pointer'])
    return dict(growthInPlace=True, movingAllocationBeforeRelease=True,
                shrinkInPlace=True, failedResizePreservesOld=True,
                movingExternalRequestedOverlapBytes=128 + 8192)
