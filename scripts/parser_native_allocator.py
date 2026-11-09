"""Reconstruct parser-owned libc chunks, including observed resize overlap."""


def extent_bytes(chunks):
    """Union addresses so nested allocator returns cannot double-count a chunk."""
    ranges = sorted((row['address'], row['address'] + row['bytes']) for row in chunks)
    end = total = 0
    for start, following in ranges:
        assert 0 < start < following
        total += max(0, following - max(start, end))
        end = max(end, following)
    return total


def check_parser_events(report, nodes):
    expected = []
    capacities = []
    for stride in (16, 24):
        capacity = 0
        while capacity < nodes:
            following = 8 if capacity == 0 else capacity * 2
            expected.append([capacity * stride, following * stride])
            capacity = following
        capacities.append(capacity * stride)
    expected.extend(([capacities[1], 0], [capacities[0], 0]))
    return check_allocation_events(report, expected, 1)


def check_allocation_events(report, expected, threads):
    assert threads in (1, 2)
    assert report['exitCode'] == 0 and not report['errors']
    assert report['chunkHeaderBytes'] == 16
    libc, = [row for row in report['objects'] if row['path'].endswith('/libc.so.6')]
    debug, = [row for row in report['objects'] if row['debugOwner'] == libc['path']]
    assert libc['buildId'] and debug['buildId'] == libc['buildId']
    assert report['sourceLocations'] and all(row['file'] and row['line'] > 0 for row in report['sourceLocations'])
    events = report['events']
    assert [row['phase'] for row in events if row['kind'] == 'checkpoint'] == list(range(5))
    assert events[0]['kind'] == events[-1]['kind'] == 'checkpoint'
    assert len({tuple(row['thread']) for row in events}) == threads
    assert [row['phase'] for row in events] == sorted(row['phase'] for row in events)
    live = {}
    transitions = []
    operations = []
    peak_chunks = peak_requested = overlap_requested = 0
    index = 0
    while index < len(events):
        first = events[index]
        if first['kind'] == 'checkpoint':
            assert first['operation'] is None
            index += 1
            continue
        assert first['kind'] == 'api-enter' and first['operation'] == len(operations) + 1
        end = index + 1
        while end < len(events) and events[end]['kind'] != 'api-return':
            assert events[end]['kind'] in ('internal-enter', 'internal-return')
            end += 1
        assert end < len(events)
        rows = events[index:end + 1]
        assert all(row['operation'] == first['operation'] and row['phase'] == first['phase']
                   and row['thread'] == first['thread'] for row in rows)
        last = rows[-1]
        function = first['function']
        assert function == last['function'] and function in ('__libc_malloc', '__libc_realloc', '__libc_free')
        pointer = first.get('pointer', 0)
        old = live.get(pointer)
        assert not pointer or old is not None, 'untracked parser allocation'
        if pointer:
            assert first['chunk'] == old['chunk']
        before = old['requested'] if old else 0
        after = first.get('requested', 0)
        requested_live = sum(row['requested'] for row in live.values())
        temporary = {row['chunk']['address']: row['chunk'] for row in live.values()}
        old_address = old['chunk']['address'] if old else None
        releases, acquisitions, remaps = [], [], []
        mapping = None
        mapping_returned = False
        for offset, row in enumerate(rows[1:-1], 1):
            kind, name = row['kind'], row['function']
            layout = row.get('chunk')
            if name == '__mremap':
                assert old and old['chunk']['mapped'] and row['mapping']['flags'] == 1
                if kind == 'internal-enter':
                    assert mapping is None
                    mapping = row['mapping']
                    assert mapping['address'] <= old_address
                    assert mapping['address'] + mapping['oldBytes'] == old_address + old['chunk']['bytes']
                else:
                    assert kind == 'internal-return' and mapping == row['mapping'] and layout is None and not mapping_returned
                    mapping_returned = True
                    if row['pointer'] != (1 << 64) - 1:
                        displacement = old_address - mapping['address']
                        # A successful remap gives the new extent immediately;
                        # libc's final live header must confirm its chunk layout.
                        layout = dict(address=row['pointer'] + displacement,
                                      bytes=mapping['newBytes'] - displacement, mapped=True)
                        assert layout == last['chunk']
                        temporary.pop(old_address)
                        temporary[layout['address']] = layout
                        remaps.append(offset)
                        peak_chunks = max(peak_chunks, extent_bytes(temporary.values()))
            elif kind == 'internal-enter' and name in ('_int_free', 'munmap_chunk', '__libc_free') and layout:
                if layout['address'] == old_address:
                    releases.append(offset)
                temporary.pop(layout['address'], None)
            elif kind == 'internal-return' and layout:
                assert name in ('_int_malloc', '__libc_malloc', '_int_realloc')
                if name in ('_int_malloc', '__libc_malloc'):
                    acquisitions.append((offset, layout['address']))
                    if old_address in temporary and last['chunk'] == layout and last['pointer'] != pointer:
                        overlap_requested = max(overlap_requested, requested_live + after)
                temporary[layout['address']] = layout
                peak_chunks = max(peak_chunks, extent_bytes(temporary.values()))
        assert mapping is None or mapping_returned, 'mapped resize lacks its actual return'
        if function == '__libc_free':
            assert pointer and last['pointer'] is None and last['chunk'] is None
            assert len(releases) == 1, 'free lacked its actual allocator release'
            del live[pointer]
            path = 'release'
        else:
            result, layout = last['pointer'], last['chunk']
            assert result and layout and result == layout['address'] + report['chunkHeaderBytes']
            if remaps:
                assert pointer and len(remaps) == 1 and not releases
                path = 'mapped-remap'
            elif pointer and result != pointer:
                allocated = [offset for offset, address in acquisitions if address == layout['address']]
                assert allocated and len(releases) == 1 and min(allocated) < releases[0], 'moving resize lacks allocation-before-release'
                path = 'mapped-copy' if old['chunk']['mapped'] else 'arena-move'
                if any(row['kind'] == 'internal-return' and row['function'] == '_int_realloc'
                       and row['pointer'] == 0 for row in rows):
                    path = 'arena-retry-copy'
            else:
                path = 'in-place' if pointer else ('mapped-allocation' if layout['mapped'] else 'arena-allocation')
            if pointer:
                del live[pointer]
            assert result not in live
            live[result] = dict(requested=after, chunk=layout)
            peak_chunks = max(peak_chunks, extent_bytes(row['chunk'] for row in live.values()))
        final_chunks = [row['chunk'] for row in live.values()]
        assert extent_bytes([*temporary.values(), *final_chunks]) == extent_bytes(final_chunks), 'unattributed allocator-internal storage'
        transitions.append([before, after])
        operations.append(dict(operation=first['operation'], phase=first['phase'], path=path,
                               before=before, after=after))
        peak_requested = max(peak_requested, sum(row['requested'] for row in live.values()))
        index = end + 1
    assert not live, 'parser allocations remain live'
    assert transitions == expected, 'actual allocator calls disagree with the parser vector ledger'
    return dict(operations=operations, endpointRequestedPeakBytes=peak_requested,
                requestedPeakWithObservedResizeOverlapBytes=max(peak_requested, overlap_requested),
                observedOwnedChunkPeakBytes=peak_chunks, finalLiveAllocations=0,
                scope='Owned libc chunk extents and requested bytes; not allocator retained pages, metadata, RSS or a kernel transient peak')
