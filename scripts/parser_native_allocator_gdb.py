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
RETURNS = []
RETURN_REGISTER = None


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


class Returned(gdb.Breakpoint):
    def __init__(self, frame, function, root, pointer_kind, details):
        caller = frame.older()
        while caller is not None and caller.type() in (gdb.INLINE_FRAME, gdb.TAILCALL_FRAME):
            caller = caller.older()
        if caller is None or caller.type() != gdb.NORMAL_FRAME:
            raise RuntimeError('missing real allocator caller: ' + function)
        self.address = caller.pc()
        self.stack = int(caller.read_register('sp'))
        super().__init__('*' + hex(self.address), internal=True)
        self.function = function
        self.root = root
        self.pointer_kind = pointer_kind
        self.details = details
        RETURNS.append(self)


def observe():
    global PHASE, OWNER_THREAD, OPERATION, SERIAL, STOPPED, HEADER_BYTES, CHUNK_TYPE, RETURN_REGISTER
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
    CHUNK_TYPE = gdb.lookup_type('struct malloc_chunk')
    assert CHUNK_TYPE.pointer().sizeof == 8
    fields = {field.name: field for field in CHUNK_TYPE.fields()}
    HEADER_BYTES = fields['fd'].bitpos // 8
    assert HEADER_BYTES == 2 * fields['mchunk_size'].type.sizeof == 16
    architecture = gdb.newest_frame().architecture().name()
    RETURN_REGISTER = {'i386:x86-64': 'rax', 'aarch64': 'x0'}[architecture]
    REPORT['architecture'] = architecture
    REPORT['chunkHeaderBytes'] = HEADER_BYTES
    names = ('parser_memory_checkpoint', '__libc_malloc', '__libc_realloc', '__libc_free',
             '_int_malloc', '_int_realloc', '_int_free', '__mremap', 'munmap_chunk')
    points = {gdb.Breakpoint(name, internal=True): name for name in names}
    for point, name in points.items():
        if point.pending:
            raise RuntimeError('missing installed allocator symbol: ' + name)
    while EXIT_CODE is None:
        STOPPED = []
        gdb.execute('continue')
        if EXIT_CODE is not None:
            break
        if not STOPPED:
            raise RuntimeError('ambiguous or unexpected allocator stop')
        frame = gdb.newest_frame()
        returning = [point for point in STOPPED if isinstance(point, Returned)]
        if returning:
            # Tail calls can share a real caller. Observe its actual return once,
            # then close the nested calls in reverse entry order. FinishBreakpoint
            # instead treats some tail-eliminated libc frames as unwound.
            if len(returning) != len(STOPPED) or any(point not in RETURNS for point in returning):
                raise RuntimeError('mixed allocator entry/return stop')
            returning.sort(key=RETURNS.index, reverse=True)
            for point in returning:
                if point is not RETURNS[-1] or frame.pc() != point.address or int(frame.read_register('sp')) != point.stack:
                    raise RuntimeError('allocator return caller/order mismatch')
                if list(gdb.selected_thread().ptid) != OWNER_THREAD:
                    raise RuntimeError('allocator return on a different thread')
                if OPERATION is None:
                    raise RuntimeError('allocator return without its operation')
                if point.pointer_kind == 'void':
                    pointer, layout = None, None
                else:
                    value = frame.read_register(RETURN_REGISTER)
                    if value.is_optimized_out:
                        raise RuntimeError('unavailable allocator return: ' + point.function)
                    pointer = int(value) & ((1 << 64) - 1)
                    # The remap result is a mapping address, not a malloc user
                    # pointer. Its header is updated later by libc; do not read it.
                    layout = None if point.pointer_kind == 'mapping' else allocation(pointer)
                record('api-return' if point.root else 'internal-return',
                       function=point.function, pointer=pointer, chunk=layout,
                       returnAddress=point.address, callerStack=point.stack,
                       mapping=point.details.get('mapping'))
                RETURNS.pop()
                point.delete()
                if point.root:
                    OPERATION = None
            save()
            continue
        if len(STOPPED) != 1:
            raise RuntimeError('ambiguous allocator entry')
        point = STOPPED[0]
        name = points[point]
        if name == 'parser_memory_checkpoint':
            phase = argument(frame, 'phase')
            assert phase == (0 if PHASE is None else PHASE + 1) and phase <= 4
            assert OPERATION is None and not RETURNS
            # A calibration can transfer its owned allocations at a checkpoint.
            # The parser reader separately requires exactly one thread; every
            # operation must still complete on the checkpoint's owning thread.
            OWNER_THREAD = list(gdb.selected_thread().ptid)
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
        elif name == '__mremap':
            values['mapping'] = dict(address=argument(frame, 'addr'), oldBytes=argument(frame, 'old_len'),
                                     newBytes=argument(frame, 'new_len'), flags=argument(frame, 'flags'))
            pointer_kind = 'mapping'
        else:
            values['chunk'] = chunk(argument(frame, 'p'))
        record('api-enter' if root else 'internal-enter', **values)
        if pointer_kind is not None:
            Returned(frame, name, root, pointer_kind, values)
        save()
    REPORT['exitCode'] = EXIT_CODE
    if EXIT_CODE != 0 or PHASE != 4 or OPERATION is not None or RETURNS or REPORT['errors']:
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
