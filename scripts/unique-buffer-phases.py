#!/usr/bin/env python3
"""Insert statement-boundary clocks into separate buffer diagnostic programs."""
import re

C_CLOCK = r'''
#include <time.h>
static uint64_t buffer_phase_now(void) {
    struct timespec ts;
    if (clock_gettime(CLOCK_MONOTONIC, &ts) != 0) {
        fputs("clock_gettime failed\n", stderr);
        exit(1);
    }
    return (uint64_t)ts.tv_sec * 1000000000ULL + (uint64_t)ts.tv_nsec;
}
'''
C_FINISH = r'''uint64_t phase_returned = buffer_phase_now();
    fprintf(stderr, "{\"constructionNs\":%llu,\"readsNs\":%llu,\"releaseNs\":%llu,\"tailNs\":%llu}\n",
        (unsigned long long)(phase_constructed - phase_started),
        (unsigned long long)(phase_release - phase_constructed),
        (unsigned long long)(phase_released - phase_release),
        (unsigned long long)(phase_returned - phase_released));
'''


def replace_once(text, old, new):
    assert text.count(old) == 1, ('changed phase boundary', old, text.count(old))
    return text.replace(old, new)


def c_body(body, constructed, release, returned):
    opening = body.index('{\n') + 2
    body = body[:opening] + '    uint64_t phase_started = buffer_phase_now();\n' + body[opening:]
    body = replace_once(body, constructed, constructed + '\n    uint64_t phase_constructed = buffer_phase_now();')
    body = replace_once(body, release, 'uint64_t phase_release = buffer_phase_now();\n    ' + release + '\n    uint64_t phase_released = buffer_phase_now();')
    return replace_once(body, returned, C_FINISH + '    ' + returned)


def c_peer(code):
    start = code.index('static int64_t work(int64_t input) {')
    end = code.index('\n}', start) + 2
    body = c_body(code[start:end],
                  'for (size_t i = 0; i < length; i++) values[i] = (int64_t)i;',
                  'free(values);', 'return result;')
    return code[:start] + C_CLOCK + body + code[end:]


def fwp(code, entry):
    assert entry in ('unique', 'callback', 'scan')
    start = code.index(f'/* {entry} : I64 -> I64 */\nstatic int64_t w')
    end = code.index('\n}', start) + 2
    body = code[start:end]
    # The current three fixtures finish construction by binding the array to l1.
    # Reject changed emission instead of silently timing a different region.
    constructed = 'l1 = t2;'
    release = 'fwp_drop0(l1);' if entry == 'scan' else 'fwp_mem_free((void *)(uintptr_t)l1);'
    returned, = re.findall(r'return \(int64_t\)\([^\n]+;', body)
    body = c_body(body, constructed, release, returned)
    return code[:start] + C_CLOCK + body + code[end:]


def rust_peer(code):
    code = replace_once(code, 'use std::process;', 'use std::process;\nuse std::time::Instant;')
    start = code.index('fn work(input: i64) -> i64 {')
    end = code.index('\n}', start) + 2
    body = code[start:end]
    body = replace_once(body, 'fn work(input: i64) -> i64 {',
                        'fn work(input: i64) -> i64 {\n    let phase_started = Instant::now();')
    body = replace_once(body, '    let result = if ENTRY',
                        '    let phase_constructed = Instant::now();\n    let result = if ENTRY')
    body = replace_once(body, '    drop(values);',
                        '    let phase_release = Instant::now();\n    drop(values);\n    let phase_released = Instant::now();')
    body = replace_once(body, '\n    result\n}', r'''
    let phase_returned = Instant::now();
    eprintln!("{{\"constructionNs\":{},\"readsNs\":{},\"releaseNs\":{},\"tailNs\":{}}}",
        phase_constructed.duration_since(phase_started).as_nanos(),
        phase_release.duration_since(phase_constructed).as_nanos(),
        phase_released.duration_since(phase_release).as_nanos(),
        phase_returned.duration_since(phase_released).as_nanos());
    result
}''')
    return code[:start] + body + code[end:]
