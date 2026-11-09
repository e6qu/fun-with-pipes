"""Compile service work separately from its result-reporting caller."""
from pathlib import Path

FIXTURES = Path(__file__).resolve().parent.parent / 'tests/fixtures'


def build_native(args, folder, language, source, variant, level, mode, debug, clock, caller, run, env):
    assert language in ('c', 'rs', 'swift', 'fwp') and level in (1, 2)
    assert mode in ('plain', 'diagnostic') and type(debug) is bool
    assert language != 'fwp' or clock is not None
    part = folder / f'{language}-{variant}-{level}-{mode}'
    part.mkdir()
    extension = 'c' if language == 'fwp' else language
    factory = part / ('factory.' + extension)
    factory.write_text(source)
    client = part / ('caller.' + extension)
    client.write_text(caller)
    binary = part / 'program'
    if language in ('c', 'fwp'):
        (part / 'weak_callback_service.h').write_bytes((FIXTURES / 'weak_callback_service.h').read_bytes())
        if clock is not None:
            (part / 'callable_phase_clock.h').write_bytes((FIXTURES / 'callable_phase_clock.h').read_bytes())
        flags = ['-std=' + ('gnu11' if language == 'fwp' else 'c11'), '-O' + str(level), '-fno-lto', '-ffp-contract=off', '-march=' + args.c_arch,
                 '-DSERVICE_FWP=' + str(int(language == 'fwp')),
                 *(['-fstack-usage'] if clock is not None else []), '-DSERVICE_DIAGNOSTIC=' + str(int(mode == 'diagnostic')),
                 *(['-g'] if debug else [])]
        run([args.cc, *flags, *(['-w'] if language == 'fwp' else ['-Wall', '-Wextra', '-Werror']), '-c', factory, '-o', part / 'factory.o'], (0, '', ''), env)
        run([args.cc, *flags, '-Wall', '-Wextra', '-Werror', '-c', client, '-o', part / 'caller.o'], (0, '', ''), env)
        command = [args.cc, '-fno-lto', part / 'factory.o', part / 'caller.o',
                   *([] if clock is None else [clock]), *(['-lm', '-lpthread', '-ldl'] if language == 'fwp' else []), '-o', binary]
    elif language == 'rs':
        flags = ['--edition=2021', '-C', 'opt-level=' + str(level), '-C', 'overflow-checks=yes',
                 '-C', 'lto=off', '-C', 'embed-bitcode=no', '-C', 'panic=unwind',
                 '-C', 'debuginfo=' + ('2' if debug else '0'), '-C', 'target-cpu=' + args.rust_cpu,
                 '--target', args.target, '-D', 'warnings', '--check-cfg', 'cfg(service_plain,service_diagnostic)',
                 '--cfg', 'service_' + mode]
        library = part / 'libweak_callback_service.rlib'
        run([args.rustc, *flags, '--crate-type', 'rlib', '--crate-name', 'weak_callback_service',
             factory, '-o', library], (0, '', ''), env)
        native_clock = []
        if clock is not None:
            run([args.ar, 'crs', part / 'libservice_clock.a', clock], (0, '', ''), env)
            native_clock = ['-L', 'native=' + str(part), '-l', 'static=service_clock']
        command = [args.rustc, *flags, client, '--extern', f'weak_callback_service={library}',
                   *native_clock, '-o', binary]
    else:
        flags = ['-swift-version', '6', '-target', args.target, '-warnings-as-errors',
                 *(['-Onone'] if level == 1 else ['-O', '-whole-module-optimization']),
                 *(['-g'] if debug else [])]
        run([args.swiftc, *flags, '-parse-as-library', '-module-name', 'WeakCallbackService', '-emit-module',
             '-emit-module-path', part / 'WeakCallbackService.swiftmodule', '-emit-object', factory,
             '-o', part / 'factory.o'], (0, '', ''), env)
        command = [args.swiftc, *flags, '-I', part,
                   *([] if clock is None else ['-import-objc-header', FIXTURES / 'callable_phase_clock.h']),
                   client, part / 'factory.o', *([] if clock is None else [clock]), '-o', binary]
    linked = run(command, (0, '', ''), env)
    return binary, linked
