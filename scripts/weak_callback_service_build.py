"""Compile service work separately from its result-reporting caller."""
from pathlib import Path

FIXTURES = Path(__file__).resolve().parent.parent / 'tests/fixtures'


def build_native(args, folder, language, source, variant, level, mode, debug, caller, run, env):
    assert language in ('c', 'rs', 'swift') and level in (1, 2)
    assert mode in ('plain', 'diagnostic') and type(debug) is bool
    part = folder / f'{language}-{variant}-{level}-{mode}'
    part.mkdir()
    factory = part / ('factory.' + language)
    factory.write_text(source)
    client = part / ('caller.' + language)
    client.write_text(caller)
    binary = part / 'program'
    if language == 'c':
        (part / 'weak_callback_service.h').write_bytes((FIXTURES / 'weak_callback_service.h').read_bytes())
        flags = ['-std=c11', '-O' + str(level), '-fno-lto', '-ffp-contract=off', '-march=' + args.c_arch,
                 '-Wall', '-Wextra', '-Werror', '-DSERVICE_DIAGNOSTIC=' + str(int(mode == 'diagnostic')),
                 *(['-g'] if debug else [])]
        run([args.cc, *flags, '-c', factory, '-o', part / 'factory.o'], (0, '', ''), env)
        run([args.cc, *flags, '-c', client, '-o', part / 'caller.o'], (0, '', ''), env)
        command = [args.cc, '-fno-lto', part / 'factory.o', part / 'caller.o', '-o', binary]
    elif language == 'rs':
        flags = ['--edition=2021', '-C', 'opt-level=' + str(level), '-C', 'overflow-checks=yes',
                 '-C', 'lto=off', '-C', 'embed-bitcode=no', '-C', 'panic=unwind',
                 '-C', 'debuginfo=' + ('2' if debug else '0'), '-C', 'target-cpu=' + args.rust_cpu,
                 '--target', args.target, '-D', 'warnings', '--check-cfg', 'cfg(service_plain,service_diagnostic)',
                 '--cfg', 'service_' + mode]
        library = part / 'libweak_callback_service.rlib'
        run([args.rustc, *flags, '--crate-type', 'rlib', '--crate-name', 'weak_callback_service',
             factory, '-o', library], (0, '', ''), env)
        command = [args.rustc, *flags, client, '--extern', f'weak_callback_service={library}', '-o', binary]
    else:
        flags = ['-swift-version', '6', '-target', args.target, '-warnings-as-errors',
                 *(['-Onone'] if level == 1 else ['-O', '-whole-module-optimization']),
                 *(['-g'] if debug else [])]
        run([args.swiftc, *flags, '-parse-as-library', '-module-name', 'WeakCallbackService', '-emit-module',
             '-emit-module-path', part / 'WeakCallbackService.swiftmodule', '-emit-object', factory,
             '-o', part / 'factory.o'], (0, '', ''), env)
        command = [args.swiftc, *flags, '-I', part, client, part / 'factory.o', '-o', binary]
    linked = run(command, (0, '', ''), env)
    return binary, linked
