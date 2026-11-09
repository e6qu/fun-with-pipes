"""Observe actual fwp allocation paths and region suballocations, without wrappers."""
from parser_memory_source import ROOT, fwp, once


def instrument(generated, fault):
    assert fault in ('none', 'omit-region-release', 'omit-allocation-event', 'wrong-slot-size')
    source = fwp(generated, True)
    prototypes = '''
static void parser_heap_event(const char *, const void *, size_t, size_t, size_t);
static void parser_region_event(const char *, const void *, const void *, size_t, size_t, size_t);
static void parser_resize_event(const char *, const void *, const void *, size_t, size_t);
'''
    source = once(source, 'typedef uint64_t V;', 'typedef uint64_t V;\n' + prototypes)
    # These five charge sites cover big, slow, free-list, bump and alloc_init
    # success. Calls stay after the original allocator charge, with its real p/n.
    assert source.count('fwp_heap_charge(sz);') == 4
    source = source.replace('fwp_heap_charge(sz);',
        'fwp_heap_charge(sz);\n    parser_heap_event("allocate", p, n, sz, fwp_heap.live);')
    source = once(source, 'fwp_heap_charge(n);',
        'fwp_heap_charge(n);\n    parser_heap_event("allocate", p, n, n, fwp_heap.live);')
    for size in ('slot', 'size'):
        boundary = f'fwp_heap.freed += (double)m->{size};'
        source = once(source, boundary, boundary +
            f'\n        parser_heap_event("release", p, 0, m->{size}, fwp_heap.live);')
    source = once(source, '    fresh->capacity = capacity;\n        region->blocks = fresh;',
        '    fresh->capacity = capacity;\n'
        '        parser_region_event("block", fresh, NULL, sizeof(fwp_region_block), 0, capacity);\n'
        '        region->blocks = fresh;')
    source = once(source, '    return PTR(node);',
        '    parser_region_event("node", block, node, bytes, block->used, block->capacity);\n    return PTR(node);')
    source = once(source, '        fwp_mem_free(block);',
        '        parser_region_event("block-release", block, NULL, sizeof(fwp_region_block), block->used, block->capacity);\n'
        + ('        (void)block;' if fault == 'omit-region-release' else '        fwp_mem_free(block);'))
    start = 'static void *fwp_mem_realloc(void *p, size_t old, size_t n) {\n'
    source = once(source, start + '    void *r = fwp_alloc(n);',
        start + '    parser_resize_event("resize-begin", p, NULL, old, n);\n    void *r = fwp_alloc(n);')
    source = once(source, '    void *r = fwp_alloc(n);\n    if (p) {',
        '    void *r = fwp_alloc(n);\n    parser_resize_event("resize-copy", p, r, old, n);\n    if (p) {')
    boundary = '        memcpy(r, p, old < n ? old : n);\n        fwp_mem_free(p);\n    }\n    return r;'
    source = once(source, boundary, boundary.replace('    return r;',
        '    parser_resize_event("resize-end", p, r, old, n);\n    return r;'))
    observer = (ROOT / 'tests/fixtures/parser_heap_events.c').read_text()
    if fault == 'omit-allocation-event':
        observer = once(observer, '    if (!parser_event_active()) return;\n    if (printf("{\\"event\\":\\"%s\\",\\"phase\\":%d,\\"address\\":%llu,"',
            '    if (!parser_event_active()) return;\n    if (!strcmp(kind, "allocate")) return;\n'
            '    if (printf("{\\"event\\":\\"%s\\",\\"phase\\":%d,\\"address\\":%llu,"')
    if fault == 'wrong-slot-size':
        observer = once(observer, '               requested, charged, live) < 0)',
                        '               requested, charged + 16, live) < 0)')
    return source + '\n' + observer
