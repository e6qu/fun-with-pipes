"""Actual release omissions and native allocation checks for returned buffers."""
import re

from returned_buffer_source import replace_once

LANGUAGES = ('c', 'rs', 'swift')
INPUTS = ((0, 4096, 16), (16, 4096, 16))


def allocation_kind(stack, language):
    """Classify recorded frames; unknown Swift factory paths must be reviewed."""
    assert language in LANGUAGES
    frames = [frame.split(' (', 1)[0] for frame in stack.split(';') if frame]
    if language == 'c':
        return 'storage' if 'returned_buffer_make' in frames else 'outside'
    if language == 'rs':
        # Pinned rustc emits v0 symbols; heaptrack retains them without demangling.
        return 'storage' if any(re.fullmatch(r'_RNvC[A-Za-z0-9]+_15returned_buffer4make', frame)
                                for frame in frames) else 'outside'
    if not any(frame.startswith('$s14ReturnedBuffer10bufferMake') for frame in frames):
        return 'outside'
    if '__swift_instantiateConcreteTypeFromMangledName' in frames:
        return 'metadata'
    assert 'swift_allocObject' in frames and 'swift_slowAlloc' in frames, stack
    assert any('_ContiguousArrayBuffer' in frame for frame in frames), stack
    return 'storage'


def omit_release(source, language, owner):
    assert language in LANGUAGES and owner in ('first', 'second')
    if language == 'c':
        statement = f'        for (int64_t i = 0; i < population; i++) returned_buffer_release({owner}[i]);'
        return replace_once(source, statement, '        /* Deliberately leave these owners unreleased. */')
    if language == 'rs':
        statement = f'for value in {owner}.drain(..) {{ release(value); }}'
        return replace_once(source, statement, f'for value in {owner}.drain(..) {{ std::mem::forget(value); }}')
    statement = f'        for index in 0..<Int(population) {{ bufferRelease({owner}.advanced(by: index).move()) }}'
    # Fresh raw slots avoid initializing over live nontrivial values next batch.
    # Deallocating their memory does not destroy the Array owners. This extra
    # slot allocation is control-only and is outside the attributed factory.
    source = replace_once(source, f'    let {owner} = UnsafeMutablePointer<[Int64]>.allocate',
                          f'    var {owner} = UnsafeMutablePointer<[Int64]>.allocate')
    return replace_once(source, statement,
                        f'        {owner}.deallocate() // Deliberately omit destroying Array owners.\n'
                        f'        {owner} = UnsafeMutablePointer<[Int64]>.allocate(capacity: Int(population))')


def check_release(ordinary, omitted, length, population, batches):
    assert (length, population, batches) in INPUTS
    for row in (ordinary, omitted):
        assert set(row) == {'allocations', 'peak', 'leaked'}, row
        assert all(type(value) is int and value >= 0 for value in row.values()), row
    assert ordinary['leaked'] == 0, ordinary
    assert omitted['allocations'] == ordinary['allocations'], (ordinary, omitted)
    if length:
        assert ordinary['allocations'] >= population * batches, ordinary
        assert omitted['leaked'] >= length * 8 * population * batches, omitted
    elif ordinary['allocations'] == 0:
        assert omitted == dict(allocations=0, peak=0, leaked=0), omitted
    else:
        assert omitted['leaked'] > 0, omitted
    # Peak attribution is taken at the process heap peak, not the factory's own
    # maximum. No ordering between the two attributed peak values is required.
