#!/usr/bin/env python3
"""Add explicit Linux process-memory checkpoints to separate buffer programs."""
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parent.parent
PROTOTYPE = 'void buffer_memory_checkpoint(const char *stage);\n'


def replace_once(text, old, new):
    assert text.count(old) == 1, ('changed memory checkpoint', old, text.count(old))
    return text.replace(old, new)


def c_peer(code):
    code = replace_once(code, 'static int64_t work(int64_t input) {', PROTOTYPE + 'static int64_t work(int64_t input) {')
    code = replace_once(code, '    int64_t result = 0;', '    buffer_memory_checkpoint("constructed");\n    int64_t result = 0;')
    code = replace_once(code, '    free(values);', '    free(values);\n    buffer_memory_checkpoint("released");')
    code = replace_once(code, 'int main(int argc, char **argv) {', 'int main(int argc, char **argv) {\n    buffer_memory_checkpoint("entry");')
    code = replace_once(code, 'int64_t result = work(input);', 'int64_t result = work(input);\n        buffer_memory_checkpoint("returned");')
    code = replace_once(code, '    return 0;', '    buffer_memory_checkpoint("before-exit");\n    return 0;')
    return code


def fwp(code, entry, scan_storage):
    assert entry in ('unique', 'callback', 'scan')
    code = replace_once(code, 'typedef uint64_t V;', 'typedef uint64_t V;\n' + PROTOTYPE)
    start = code.index(f'/* {entry} : I64 -> I64 */')
    end = code.index('\n}', start) + 2
    body = code[start:end]
    if entry == 'scan' and scan_storage == 'elided':
        opening = body.index('{\n') + 2
        body = body[:opening] + '    buffer_memory_checkpoint("before-work");\n' + body[opening:]
        returned, = re.findall(r'return \(int64_t\)\([^\n]+;', body)
        body = replace_once(body, returned, 'int64_t checkpoint_result = ' + returned.removeprefix('return ')
            + '\n    buffer_memory_checkpoint("after-work");\n    return checkpoint_result;')
    else:
        body = replace_once(body, 'l1 = t2;', 'l1 = t2;\n    buffer_memory_checkpoint("constructed");')
        release = 'fwp_drop0(l1);' if entry == 'scan' else 'fwp_mem_free((void *)(uintptr_t)l1);'
        body = replace_once(body, release, release + '\n    buffer_memory_checkpoint("released");')
    code = code[:start] + body + code[end:]
    code = replace_once(code, 'int main(int argc, char **argv) {', 'int main(int argc, char **argv) {\n    buffer_memory_checkpoint("entry");')
    code = replace_once(code, '    buffer_benchmark();', '    buffer_benchmark();\n    buffer_memory_checkpoint("returned");')
    # After joining the runtime thread; allocator reservations may still remain.
    return replace_once(code, '    return fwp_exit_code;', '    buffer_memory_checkpoint("before-exit");\n    return fwp_exit_code;')


def rust_peer(code):
    code = replace_once(code, 'use std::process;', '''use std::process;
use std::ffi::c_char;
extern "C" { fn buffer_memory_checkpoint(stage: *const c_char); }''')
    code = replace_once(code, '    let result = if ENTRY', '    unsafe { buffer_memory_checkpoint(c"constructed".as_ptr()); }\n    let result = if ENTRY')
    code = replace_once(code, '    drop(values);', '    drop(values);\n    unsafe { buffer_memory_checkpoint(c"released".as_ptr()); }')
    code = replace_once(code, 'fn main() {', 'fn main() {\n    unsafe { buffer_memory_checkpoint(c"entry".as_ptr()); }')
    code = replace_once(code, 'let result = black_box(work(black_box(length)));', 'let result = black_box(work(black_box(length)));\n        unsafe { buffer_memory_checkpoint(c"returned".as_ptr()); }')
    return replace_once(code, '    println!("{checksum}");', '    println!("{checksum}");\n    drop(args);\n    unsafe { buffer_memory_checkpoint(c"before-exit".as_ptr()); }')
