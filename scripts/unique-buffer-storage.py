#!/usr/bin/env python3
"""Separate allocation/ownership diagnostics; never instrument timing binaries."""
import importlib.util
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('arc_costs', ROOT / 'scripts/measure-arc-costs.py')
ARC = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(ARC)


def replace_once(text, old, new):
    assert text.count(old) == 1, ('changed storage boundary', old, text.count(old))
    return text.replace(old, new)


def c_peer(code):
    ledger = (ROOT / 'tests/fixtures/unique_buffer_storage.c').read_text()
    code = replace_once(code, 'static int64_t work(int64_t input) {', ledger + '\nstatic int64_t work(int64_t input) {')
    code = replace_once(code, 'length ? malloc(length * sizeof(*values)) : NULL',
                        'length ? buffer_allocate(length * sizeof(*values)) : NULL')
    code = replace_once(code, '    free(values);', '    buffer_release(values);')
    code = replace_once(code, 'int64_t result = work(input);',
                        'int64_t result = work(input);\n        if (buffer_pointer || buffer_size) fail("buffer still live", 225);')
    marker = '    printf("%" PRId64 "\\n", checksum);'
    return replace_once(code, marker, marker + r'''
    fprintf(stderr, "{\"requests\":%zu,\"requestedBytes\":%zu,\"peakRequestedBytes\":%zu,\"finalRequestedBytes\":%zu}\n",
            buffer_requests, buffer_bytes, buffer_peak, buffer_size);''')


def rust_peer(code):
    ledger = (ROOT / 'tests/fixtures/unique_buffer_storage.rs').read_text()
    # Keep imported modules at the top of the generated file, too.
    imports = '\n'.join(line for line in ledger.splitlines() if line.startswith('use '))
    definitions = '\n'.join(line for line in ledger.splitlines() if not line.startswith('use '))
    code = replace_once(code, 'use std::process;', 'use std::process;\n' + imports + '\n' + definitions)
    code = replace_once(code, 'let result = black_box(work(black_box(length)));', '''BUFFER_ACTIVE.store(true, Ordering::SeqCst);
        let result = black_box(work(black_box(length)));
        BUFFER_ACTIVE.store(false, Ordering::SeqCst);
        if BUFFER_LIVE.load(Ordering::SeqCst) != 0 { fail("buffer still live", 225); }''')
    marker = '    println!("{checksum}");'
    return replace_once(code, marker, marker + r'''
    eprintln!("{{\"requests\":{},\"requestedBytes\":{},\"peakRequestedBytes\":{},\"finalRequestedBytes\":{}}}",
        BUFFER_REQUESTS.load(Ordering::SeqCst), BUFFER_BYTES.load(Ordering::SeqCst),
        BUFFER_PEAK.load(Ordering::SeqCst), BUFFER_LIVE.load(Ordering::SeqCst));''')


def fwp(code):
    code = ARC.PROFILE.instrument(code)
    code = ARC.instrument_metadata(code)
    code, sites = ARC.OWNERSHIP.instrument(code)
    call, = re.findall(r'int64_t result = \(int64_t\)f\d+\(\(V\)input\);', code)
    code = replace_once(code, call, '''size_t buffer_before = fwp_heap.live;
        ''' + call + '''
        if (fwp_heap.live != buffer_before) fail("buffer still live", 225);''')
    return code, sites


def parse_fwp(stderr, sites):
    rows = stderr.splitlines()
    metadata_rows = [line for line in rows if line.startswith(b'{"allocationRequests"')]
    managed_rows = [line for line in rows if line.startswith(b'{"requests"')]
    assert len(metadata_rows) == len(managed_rows) == 1
    metadata, managed = ARC.parse_metadata(b'\n'.join(metadata_rows + managed_rows))
    ownership = ARC.parse_profile(b'\n'.join(line for line in rows if line not in metadata_rows), sites)
    assert ownership['managed'] == managed
    return dict(metadata=metadata, **ownership)
