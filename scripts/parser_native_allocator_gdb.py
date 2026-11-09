"""Observe actual libc allocation events between native parser checkpoints.

The debugger reads live allocation headers and debug arguments. It never calls
inferior functions, changes allocator state or reads a released allocation.
"""
import hashlib
import json
import os
from pathlib import Path
import traceback

import gdb

OUTPUT = Path(os.environ['FWP_PARSER_ALLOCATOR_EVENTS'])
REPORT = dict(events=[], objects=[], errors=[], sourceLocations=[])
PHASE = None
OWNER_THREAD = None
OPERATION = None
SERIAL = 0
STOPPED = []
EXIT_CODE = None
HEADER_BYTES = None
CHUNK_TYPE = None


def save():
    OUTPUT.write_text(json.dumps(REPORT, indent=2) + '\n')


def stopped(event):
    global STOPPED
    STOPPED = list(event.breakpoints) if isinstance(event, gdb.BreakpointEvent) else []


def exited(event):
    global EXIT_CODE
    EXIT_CODE = event.exit_code if hasattr(event, 'exit_code') else -1


def argument(frame, name):
    value = frame.read_var(name)
    if value.is_optimized_out:
        raise RuntimeError('unavailable allocator argument: ' + name)
    return int(value)


def chunk(address):
    if not address:
        return None
    data = gdb.Value(address).cast(CHUNK_TYPE.pointer()).dereference()
    size = int(data['mchunk_size'])
    extent = size & ~7
    if extent < HEADER_BYTES or extent % 8:
        raise RuntimeError('invalid live allocator chunk extent')
    return dict(address=address, bytes=extent, mapped=bool(size & 2))


def allocation(pointer):
    return chunk(pointer - HEADER_BYTES) if pointer else None


def record(kind, **values):
    if len(REPORT['events']) >= 4096:
        raise RuntimeError('native parser event limit exceeded')
    REPORT['events'].append(dict(kind=kind, phase=PHASE, operation=OPERATION,
                                 thread=list(gdb.selected_thread().ptid), **values))


class Returned(gdb.FinishBreakpoint):
    def __init__(self, frame, function, root, pointer_kind):
        super().__init__(frame, internal=True)
        self.function = function
        self.root = root
        self.pointer_kind = pointer_kind

    def out_of_scope(self):
        REPORT['errors'].append('unexpected unwind at ' + self.function)


def observe():
    global PHASE, OWNER_THREAD, OPERATION, SERIAL, STOPPED, HEADER_BYTES, CHUNK_TYPE
    gdb.events.stop.connect(stopped)
    gdb.events.exited.connect(exited)
    for command in ('set pagination off', 'set confirm off', 'set auto-load off',
                    'set debuginfod enabled off', 'set disable-randomization off'):
        gdb.execute(command)
    gdb.execute('start')
    for obj in gdb.objfiles():
        path = Path(obj.filename)
        if path.is_file():
            REPORT['objects'].append(dict(path=str(path), buildId=obj.build_id,
                debugOwner=obj.owner.filename if obj.owner else None,
                sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    assert int(gdb.parse_and_eval('sizeof(void *)')) == 8
    CHUNK_TYPE = gdb.lookup_type('struct malloc_chunk')
    HEADER_BYTES = int(gdb.parse_and_eval('(size_t)&((struct malloc_chunk *)0)->fd'))
    assert HEADER_BYTES == 2 * int(gdb.parse_and_eval('sizeof(size_t)')) == 16
    REPORT['chunkHeaderBytes'] = HEADER_BYTES
    names = ('parser_memory_checkpoint', '__libc_malloc', '__libc_realloc', '__libc_free',
             '_int_malloc', '_int_realloc', '_int_free', 'mremap_chunk', 'munmap_chunk')
    points = {gdb.Breakpoint(name, internal=True): name for name in names}
    for point, name in points.items():
        if point.pending:
            raise RuntimeError('missing installed allocator symbol: ' + name)
    while EXIT_CODE is None:
        STOPPED = []
        gdb.execute('continue')
        if EXIT_CODE is not None:
            break
        if len(STOPPED) != 1:
            raise RuntimeError('ambiguous or unexpected allocator stop')
        point = STOPPED[0]
        frame = gdb.newest_frame()
        if isinstance(point, Returned):
            if OPERATION is None:
                raise RuntimeError('allocator return without its operation')
            if point.pointer_kind == 'void':
                pointer, layout = None, None
            else:
                value = point.return_value
                if value is None or value.is_optimized_out:
                    raise RuntimeError('unavailable allocator return: ' + point.function)
                pointer = int(value)
                layout = chunk(pointer) if point.pointer_kind == 'chunk' else allocation(pointer)
            record('api-return' if point.root else 'internal-return',
                   function=point.function, pointer=pointer, chunk=layout)
            if point.root:
                OPERATION = None
            save()
            continue
        name = points[point]
        if name == 'parser_memory_checkpoint':
            phase = argument(frame, 'phase')
            assert phase == (0 if PHASE is None else PHASE + 1) and phase <= 4
            assert OPERATION is None
            if OWNER_THREAD is None:
                OWNER_THREAD = list(gdb.selected_thread().ptid)
            assert list(gdb.selected_thread().ptid) == OWNER_THREAD
            PHASE = phase
            record('checkpoint')
            save()
            continue
        if PHASE is None or PHASE == 4:
            continue
        if list(gdb.selected_thread().ptid) != OWNER_THREAD:
            raise RuntimeError('allocation from another thread during a native parser observation')
        root = OPERATION is None
        if root:
            if name not in ('__libc_malloc', '__libc_realloc', '__libc_free'):
                raise RuntimeError('internal allocation without an observed public operation: ' + name)
            SERIAL += 1
            OPERATION = SERIAL
        location = frame.find_sal()
        REPORT['sourceLocations'].append(dict(function=name, line=location.line,
            file=location.symtab.fullname() if location.symtab else None))
        values = dict(function=name)
        pointer_kind = None
        if name in ('__libc_malloc', '_int_malloc'):
            values['requested'] = argument(frame, 'bytes')
            pointer_kind = 'allocation'
        elif name == '__libc_realloc':
            values.update(pointer=argument(frame, 'oldmem'), requested=argument(frame, 'bytes'))
            values['chunk'] = allocation(values['pointer'])
            pointer_kind = 'allocation'
        elif name == '__libc_free':
            values['pointer'] = argument(frame, 'mem')
            values['chunk'] = allocation(values['pointer'])
            pointer_kind = 'void' if root else None
        elif name == '_int_realloc':
            values.update(chunk=chunk(argument(frame, 'oldp')), oldBytes=argument(frame, 'oldsize'),
                          adjustedBytes=argument(frame, 'nb'))
            pointer_kind = 'allocation'
        elif name == 'mremap_chunk':
            values.update(chunk=chunk(argument(frame, 'p')), adjustedBytes=argument(frame, 'new_size'))
            pointer_kind = 'chunk'
        else:
            values['chunk'] = chunk(argument(frame, 'p'))
        record('api-enter' if root else 'internal-enter', **values)
        if pointer_kind is not None:
            Returned(frame, name, root, pointer_kind)
        save()
    REPORT['exitCode'] = EXIT_CODE
    if EXIT_CODE != 0 or PHASE != 4 or OPERATION is not None or REPORT['errors']:
        raise RuntimeError('incomplete native parser allocator execution')


try:
    observe()
except Exception as error:
    REPORT['errors'].append(dict(error=str(error), traceback=traceback.format_exc()))
    save()
    gdb.execute('quit 1')
else:
    save()
    gdb.execute('quit 0')
