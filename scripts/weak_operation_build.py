"""Compile native reference operations separately from the explicit phase caller."""
import hashlib

from weak_operation_source import once


def build(args, folder, fixtures, emitted, run, env, language, level, variant, clock):
    assert language in ('c', 'rs', 'swift', 'fwp') and level in (1, 2)
    assert variant in ('ordinary', 'wrong-lookup', 'backward-clock', 'release-observed', 'omit-owner', 'omit-weak')
    diagnostic = variant in ('release-observed', 'omit-owner', 'omit-weak')
    assert not diagnostic or language in ('c', 'fwp')
    part = folder / f'{language}-{level}-{variant}'
    part.mkdir()
    binary = part / 'program'
    if language in ('c', 'fwp'):
        factory = part / 'factory.c'
        source = emitted if language == 'fwp' else (fixtures / 'weak_operation_peer.c').read_text()
        if variant == 'wrong-lookup':
            if language == 'fwp':
                source = once(source, '(&weak) == FWP_TRUE;', '(&weak) == FWP_FALSE;')
            else:
                source = once(source, '    if (!acquired) return 0;', '    if (!acquired) return 1;')
                source = once(source, '    return 1;', '    return 0;')
        factory.write_text(source)
        source = (fixtures / 'weak_operation_time.c').read_text()
        if variant == 'omit-owner':
            source = once(source, '        for (int64_t i = 0; i < population; i++) reference_release_owner(owners[i]);', '')
        elif variant == 'omit-weak':
            source = once(source, '        for (int64_t i = 0; i < population; i++) reference_release_weak(weak[i]);', '')
        caller = part / 'caller.c'
        caller.write_text(source)
        flags = ['-std=gnu11', '-O' + str(level), '-fno-lto', '-march=' + args.c_arch, '-fstack-usage',
                 '-I', fixtures, '-DREFERENCE_FWP=' + str(int(language == 'fwp')),
                 '-DREFERENCE_DIAGNOSTIC=' + str(int(diagnostic))]
        warnings = ['-w'] if language == 'fwp' else ['-Wall', '-Wextra', '-Werror']
        run([args.cc, *flags, *warnings, '-c', factory, '-o', part / 'factory.o'], (0, '', ''), env)
        run([args.cc, *flags, '-Wall', '-Wextra', '-Werror', '-c', caller, '-o', part / 'caller.o'], (0, '', ''), env)
        link = [args.cc, '-fno-lto', part / 'factory.o', part / 'caller.o', clock, '-lm', '-lpthread', '-ldl', '-o', binary]
        run(link, (0, '', ''), env)
    elif language == 'rs':
        flags = ['--edition=2021', '-C', 'opt-level=' + str(level), '-C', 'overflow-checks=yes', '-C', 'lto=off',
                 '-C', 'embed-bitcode=no', '-C', 'codegen-units=16', '-C', 'debuginfo=0', '-C', 'panic=unwind',
                 '-C', 'target-cpu=' + args.rust_cpu, '--target', args.target, '-D', 'warnings']
        source = (fixtures / 'weak_operation_peer.rs').read_text()
        if variant == 'wrong-lookup':
            source = once(source, 'weak.upgrade().is_some()', 'weak.upgrade().is_none()')
        factory = part / 'factory.rs'
        factory.write_text(source)
        library = part / 'libweak_operation.rlib'
        run([args.rustc, *flags, '--crate-name', 'weak_operation', '--crate-type', 'rlib', factory, '-o', library], (0, '', ''), env)
        run([args.ar, 'crs', part / 'libreference_clock.a', clock], (0, '', ''), env)
        link = [args.rustc, *flags, fixtures / 'weak_operation_time.rs', '--extern', f'weak_operation={library}',
                '-L', 'native=' + str(part), '-l', 'static=reference_clock', '-o', binary]
        run(link, (0, '', ''), env)
    else:
        flags = ['-swift-version', '6', '-target', args.target, '-warnings-as-errors',
                 *(['-Onone'] if level == 1 else ['-O', '-whole-module-optimization'])]
        source = (fixtures / 'weak_operation_peer.swift').read_text()
        if variant == 'wrong-lookup':
            source = once(source, 'else { return false }', 'else { return true }')
            source = once(source, 'withExtendedLifetime(acquired) { true }', 'withExtendedLifetime(acquired) { false }')
        factory = part / 'factory.swift'
        factory.write_text(source)
        run([args.swiftc, *flags, '-parse-as-library', '-module-name', 'WeakOperation', '-emit-module',
             '-emit-module-path', part / 'WeakOperation.swiftmodule', '-emit-object', factory, '-o', part / 'factory.o'], (0, '', ''), env)
        link = [args.swiftc, *flags, '-I', part, '-import-objc-header', fixtures / 'callable_phase_clock.h',
                fixtures / 'weak_operation_time.swift', part / 'factory.o', clock, '-o', binary]
        run(link, (0, '', ''), env)
    image = binary.read_bytes()
    assert image[:6] == b'\x7fELF\x02\x01'
    assert int.from_bytes(image[18:20], 'little') == {'aarch64': 183, 'x86_64': 62}[args.arch]
    metadata = dict(language=language, level=level, variant=variant, imageBytes=len(image),
                    binarySha256=hashlib.sha256(image).hexdigest(), link=list(map(str, link)))
    return binary, metadata
