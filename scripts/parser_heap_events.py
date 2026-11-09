"""Reconstruct fwp parser storage from actual allocation and region events."""


def check_events(events, nodes):
    checkpoints = [row for row in events if row['event'] == 'checkpoint']
    assert [row['phase'] for row in checkpoints] == list(range(5))
    assert events[0] == checkpoints[0] and events[-1] == checkpoints[-1]
    baseline = checkpoints[0]['heapLive']
    header = checkpoints[0]['regionHeader']
    assert header == 24 and baseline >= 0
    live, blocks = {}, {}
    phase = -1
    charged = requested = peak_charged = peak_requested = 0
    allocations = reused = node_count = 0
    seen = set()
    resize = None
    resizes = []
    for row in events:
        kind = row['event']
        if kind == 'checkpoint':
            phase += 1
            assert row['phase'] == phase and row['regionHeader'] == header
            assert row['heapLive'] == baseline + charged, 'heap live bytes disagree with allocation events'
            assert row['heapPeak'] == baseline + peak_charged, 'heap peak disagrees with allocation events'
            assert row['nodes'] == node_count
            assert resize is None
            continue
        assert row['phase'] == phase and 0 <= phase < 4
        if kind in ('allocate', 'release'):
            address = row['address']
            assert type(address) is int and address > 0 and address % 16 == 0
            if kind == 'allocate':
                assert address not in live, 'allocation overlaps a live identity'
                assert 0 <= row['requested'] <= row['charged'] and row['charged'] > 0
                live[address] = dict(requested=row['requested'], charged=row['charged'])
                charged += row['charged']
                requested += row['requested']
                allocations += 1
                reused += address in seen
                seen.add(address)
            else:
                assert address in live, 'release lacks its allocation event'
                old = live.pop(address)
                assert row['requested'] == 0 and row['charged'] == old['charged']
                if address in blocks:
                    assert blocks[address]['releasing'] and not blocks[address]['released']
                    blocks[address]['released'] = True
                charged -= old['charged']
                requested -= old['requested']
            assert row['heapLive'] == baseline + charged, 'heap live bytes disagree with allocation events'
            peak_charged = max(peak_charged, charged)
            peak_requested = max(peak_requested, requested)
        elif kind == 'block':
            address = row['block']
            assert address in live and address not in blocks
            assert row['node'] == row['used'] == 0 and row['bytes'] == header
            assert live[address]['requested'] == header + row['capacity']
            blocks[address] = dict(capacity=row['capacity'], charged=live[address]['charged'],
                                   used=0, nodes=0, releasing=False, released=False)
        elif kind == 'node':
            block = blocks[row['block']]
            assert row['block'] in live and not block['releasing']
            assert row['bytes'] in (16, 24) and row['capacity'] == block['capacity']
            assert row['node'] == row['block'] + header + block['used'] and row['node'] % 8 == 0
            block['used'] += row['bytes']
            block['nodes'] += 1
            assert row['used'] == block['used'] <= block['capacity']
            node_count += 1
        elif kind == 'block-release':
            block = blocks[row['block']]
            assert row['block'] in live and not block['releasing']
            assert row['node'] == 0 and row['bytes'] == header
            assert (row['used'], row['capacity']) == (block['used'], block['capacity'])
            block['releasing'] = True
        elif kind == 'resize-begin':
            assert resize is None and row['fresh'] == 0
            if row['old']:
                assert row['old'] in live, 'resize source lacks its allocation event'
                assert row['before'] <= live[row['old']]['requested']
            resize = dict(old=row['old'], before=row['before'], after=row['after'], fresh=None)
        elif kind in ('resize-copy', 'resize-end'):
            assert resize is not None
            assert all(row[key] == resize[key] for key in ('old', 'before', 'after'))
            assert row['fresh'] in live and live[row['fresh']]['requested'] == row['after']
            if kind == 'resize-copy':
                assert resize['fresh'] is None and row['fresh'] != row['old']
                assert not row['old'] or row['old'] in live
                resize.update(fresh=row['fresh'], requestedAtCopy=requested, chargedAtCopy=charged)
            else:
                assert resize['fresh'] == row['fresh'] and row['old'] not in live
                resizes.append(resize)
                resize = None
        else:
            raise AssertionError('unknown parser allocation event: ' + kind)
    assert not live and charged == requested == 0, 'parser allocations remain live'
    assert blocks and all(block['released'] for block in blocks.values()), 'region blocks remain live'
    assert node_count == nodes and sum(block['nodes'] for block in blocks.values()) == nodes
    assert sum(block['used'] for block in blocks.values()) == ((nodes + 1) // 2) * 16 + ((nodes - 1) // 2) * 24
    return dict(allocations=allocations, reusedAddresses=reused, baselineChargedBytes=baseline,
                peakRequestedBytes=peak_requested, peakChargedBytes=peak_charged,
                regionBlocks=len(blocks), regionRequestedBytes=sum(header + b['capacity'] for b in blocks.values()),
                regionChargedBytes=sum(b['charged'] for b in blocks.values()),
                regionNodeBytes=sum(b['used'] for b in blocks.values()),
                regionUnusedBytes=sum(b['capacity'] - b['used'] for b in blocks.values()),
                resizes=resizes, finalLiveAllocations=0,
                scope='Parser allocations above the live input/runtime baseline; charged bytes are size-class slots or large requests, not allocator-retained pages, RSS or reserved address space')
