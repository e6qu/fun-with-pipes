"""Compile native buffer factories separately from their selected callers."""
import hashlib

from returned_buffer_source import replace_once


def build(args, folder, fixtures, emitted, run, env, language, shared, level, variant, mode, clock):
    assert language in ('c', 'rs', 'swift', 'fwp') and shared in (0, 1) and level in (1, 2)
    assert mode in ('checks', 'phases', 'profiles')
    assert (clock is None) == (mode == 'checks')
    assert variant in ('ordinary', 'wrong-scan', 'release-observed', 'omitted-release')
    assert mode == 'checks' or variant in ('ordinary', 'wrong-scan')
    assert variant in ('ordinary', 'wrong-scan') or language in ('c', 'fwp')
    assert language != 'fwp' or isinstance(emitted, str)
    caller_name = 'returned_buffer_caller' if mode == 'checks' else 'returned_buffer_time'
    part = folder / f'{language}-{shared}-{level}-{variant}'
    part.mkdir()
    binary = part / 'program'
    diagnostic = variant in ('release-observed', 'omitted-release')
    cflags = ['-std=gnu11', f'-O{level}', '-fno-lto', '-march=' + args.c_arch,
              '-I', fixtures, '-DBUFFER_SHARED=' + str(shared),
              '-DBUFFER_DIAGNOSTIC=' + str(int(diagnostic)), '-DRETURNED_FWP=' + str(int(language == 'fwp'))]
    if mode == 'profiles':
        cflags += ['-g']
    if language in ('c', 'fwp'):
        source = emitted if language == 'fwp' else (fixtures / 'returned_buffer_peer.c').read_text()
        if variant == 'wrong-scan':
            if language == 'fwp':
                source = replace_once(source, '(&value);\n}\nvoid returned_buffer_release',
                                             '(&value) + 1;\n}\nvoid returned_buffer_release')
            else:
                source = replace_once(source, '    return sum;', '    return sum + 1;')
        factory = part / 'factory.c'
        factory.write_text(source)
        caller = part / 'caller.c'
        source = (fixtures / (caller_name + '.c')).read_text()
        if variant == 'omitted-release':
            source = replace_once(source, '        returned_buffer_release(first);', '')
        caller.write_text(source)
        warnings = ['-w'] if language == 'fwp' else ['-Wall', '-Wextra', '-Werror']
        run([args.cc, *cflags, *warnings, '-c', factory, '-o', part / 'factory.o'], (0, '', ''), env)
        run([args.cc, *cflags, '-Wall', '-Wextra', '-Werror', '-c', caller, '-o', part / 'caller.o'], (0, '', ''), env)
        link = [args.cc, '-fno-lto', part / 'factory.o', part / 'caller.o',
                *([] if mode == 'checks' else [clock]), '-lm', '-lpthread', '-ldl', '-o', binary]
        run(link, (0, '', ''), env)
    elif language == 'rs':
        flags = ['--edition=2021', '-C', 'opt-level=' + str(level), '-C', 'overflow-checks=yes',
                 '-C', 'lto=off', '-C', 'embed-bitcode=no', '-C', 'target-cpu=' + args.rust_cpu,
                 '--target', args.target, '-D', 'warnings', '--check-cfg', 'cfg(buffer_shared)']
        if mode == 'profiles':
            flags += ['-C', 'debuginfo=2']
        if shared:
            flags += ['--cfg', 'buffer_shared']
        source = (fixtures / 'returned_buffer_peer.rs').read_text()
        if variant == 'wrong-scan':
            source = replace_once(source, '    sum\n}', '    sum + 1\n}')
        factory = part / 'factory.rs'
        factory.write_text(source)
        library = part / 'libreturned_buffer.rlib'
        run([args.rustc, *flags, '--crate-name', 'returned_buffer', '--crate-type', 'rlib', factory, '-o', library], (0, '', ''), env)
        native_clock = []
        if mode != 'checks':
            # A trailing link-arg object comes after Rust's system libraries.
            # Declare the clock as a native library so its dependencies resolve
            # in the normal link order, including ARM64 stack protection.
            run([args.ar, 'crs', part / 'libbuffer_clock.a', clock], (0, '', ''), env)
            native_clock = ['-L', 'native=' + str(part), '-l', 'static=buffer_clock']
        link = [args.rustc, *flags, fixtures / (caller_name + '.rs'), '--extern', f'returned_buffer={library}',
                *native_clock, '-o', binary]
        run(link, (0, '', ''), env)
    else:
        flags = ['-swift-version', '6', '-target', args.target, '-warnings-as-errors',
                 *(['-Onone'] if level == 1 else ['-O', '-whole-module-optimization'])]
        if mode == 'profiles':
            flags += ['-g']
        if shared:
            flags += ['-D', 'BUFFER_SHARED']
        source = (fixtures / 'returned_buffer_peer.swift').read_text()
        if variant == 'wrong-scan':
            source = replace_once(source, '    return sum\n}', '    return sum + 1\n}')
        factory = part / 'factory.swift'
        factory.write_text(source)
        run([args.swiftc, *flags, '-parse-as-library', '-module-name', 'ReturnedBuffer', '-emit-module',
             '-emit-module-path', part / 'ReturnedBuffer.swiftmodule', '-emit-object', factory, '-o', part / 'factory.o'], (0, '', ''), env)
        link = [args.swiftc, *flags, '-I', part, *([] if mode == 'checks' else
                ['-import-objc-header', fixtures / 'callable_phase_clock.h']),
                fixtures / (caller_name + '.swift'), part / 'factory.o',
                *([] if mode == 'checks' else [clock]), '-o', binary]
        run(link, (0, '', ''), env)
    metadata = dict(language=language, shared=shared, level=level, variant=variant,
                    binarySha256=hashlib.sha256(binary.read_bytes()).hexdigest(), link=list(map(str, link)))
    return binary, metadata
