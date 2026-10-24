#!/usr/bin/env python3
"""Compare full numerical output with a shared checksum consumer, without changing arithmetic."""

import argparse
from collections import Counter
import hashlib
import importlib.util
import json
import math
import os
from pathlib import Path
import platform
import random
import re
import shutil
import signal
import statistics
import struct
import subprocess
import time

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('coordinate', ROOT / 'scripts/measure-coordinate-work.py')
COORDINATE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(COORDINATE)
BATCHES = COORDINATE.BATCHES


def digest(raw):
    return hashlib.sha256(raw).hexdigest()


def build(command, environment, timeout, commands, directory):
    """Record compiler wall time separately; terminate its children on failure."""
    command = [str(p) for p in command]
    started = time.perf_counter_ns()
    failure = None
    process = None
    stdout, stderr = b'', b''
    try:
        with subprocess.Popen(command, env=environment, stdout=subprocess.PIPE,
                              stderr=subprocess.PIPE, start_new_session=True) as process:
            try:
                stdout, stderr = process.communicate(timeout=timeout)
            except BaseException:
                try:
                    os.killpg(process.pid, signal.SIGKILL)
                except ProcessLookupError:
                    pass
                stdout, stderr = process.communicate()
                raise
    except BaseException as error:
        failure = error
    returncode = process.returncode if process is not None else None
    commands.append(dict(command=command, stdout=stdout.decode(errors='replace'),
                         stderr=stderr.decode(errors='replace'), returncode=returncode,
                         elapsedNs=time.perf_counter_ns()-started, timeoutSeconds=timeout,
                         failure=type(failure).__name__ if failure else None,
                         failureMessage=str(failure) if failure else None))
    (directory / 'build-commands.json').write_text(json.dumps(commands, indent=2) + '\n')
    if failure is not None:
        raise failure
    if returncode:
        raise subprocess.CalledProcessError(returncode, command, stdout, stderr)


def output_variant(code, language):
    """Replace only this benchmark's final output, keeping its result release."""
    if language == 'fwp':
        assert '#define FWP_ARC_ONLY 1' in code
        ids = []
        for name in ['array._show-list', 'print']:
            match, = re.findall(r'/\* ' + re.escape(name) + r' : [^\n]+ \*/\nstatic V (f\d+)\(', code)
            ids.append(match)
        body, = re.findall(r'^static V f0\(void\) \{\n(.*?)^\}', code, re.M | re.S)
        (marker, array), = re.findall(r'(    V t\d+ = ' + ids[0] + r'\((l\d+)\);\n)', body)
        prefix, tail = body.split(marker)
        tail = marker + tail
        assert re.findall(r'^    V t\d+ = (f\d+)\(', tail, re.M) == ids
        release, = re.findall(r'^    (fwp_drop\d+\(' + array + r'\);)$', tail, re.M)
        assert re.search(r'^    return l\d+;\n$', tail, re.M)
        replacement = prefix + f'    descent_sink_values(fwp_array_data({array}), fwp_array_len({array}));\n    {release}\n    return FWP_UNIT;\n'
        declaration = 'extern void descent_sink_values(const void *, size_t);\nextern void descent_sink_report(void);\n'
        marker = 'static V f0(void) {\n'
        assert code.count(marker + body + '}') == 1
        changed = code.replace(marker + body + '}', declaration + marker + replacement + '}')
        return changed
    if language == 'c':
        start = code.index("    putchar('[');")
        end = code.index('    free(x);', start)
        assert code[start:end].count('printf(') == 1 and code[start:end].count('puts(') == 1
        changed = code[:start] + '    descent_sink_values(x, DIMENSIONS);\n' + code[end:]
        marker = 'int main(void) {'
        assert changed.count(marker) == 1
        return changed.replace(marker, 'extern void descent_sink_values(const void *, size_t);\nextern void descent_sink_report(void);\n\n' + marker)
    if language == 'rust':
        start = code.index('    let mut output = io::stdout().lock();')
        assert code[start:].endswith('    writeln!(output, "]")\n}\n')
        changed = code[:start] + '    unsafe { descent_sink_values(x.as_ptr().cast(), x.len()); }\n    Ok(())\n}\n'
        marker = 'use std::io::{self, Write};'
        assert changed.count(marker) == 1
        changed = changed.replace(marker, 'use std::ffi::c_void;\nuse std::io;')
        marker = 'fn main() -> io::Result<()> {'
        assert changed.count(marker) == 1
        return changed.replace(marker, 'extern "C" {\n    fn descent_sink_values(values: *const c_void, count: usize);\n    fn descent_sink_report();\n}\n\n' + marker)
    raise ValueError(language)


def repeated(code, language, repetitions, sink):
    changed = BATCHES.edit_source(output_variant(code, language) if sink else code, language, repetitions)
    if sink:
        if language == 'fwp':
            old = '{ r = f0(); }'
            new = old + ' descent_sink_report();'
        elif language == 'c':
            old = 'if (status) return status; } return 0; }'
            new = 'if (status) return status; } descent_sink_report(); return 0; }'
        else:
            old = ' { workload()?; } Ok(()) }'
            new = ' { workload()?; } unsafe { descent_sink_report(); } Ok(()) }'
        assert changed.count(old) == 1
        changed = changed.replace(old, new)
    return changed


def sink_vectors(raw, expected, repetitions):
    lines = raw.splitlines()
    assert len(lines) == repetitions
    vectors = []
    for line in lines:
        encoded = json.loads(line)
        assert isinstance(encoded, list) and len(encoded) == len(expected)
        assert all(type(value) is str and re.fullmatch('[0-9a-f]{16}', value) for value in encoded)
        values = [struct.unpack('>d', bytes.fromhex(value))[0] for value in encoded]
        assert all(math.isfinite(a) and math.isclose(a, b, rel_tol=1e-10, abs_tol=1e-10)
                   for a, b in zip(values, expected))
        vectors.append(encoded)
    assert all(row == vectors[0] for row in vectors)
    return vectors


def sink_checksum(vectors):
    value = 14695981039346656037
    for row in vectors:
        for word in [len(row), *[int(word, 16) for word in row]]:
            value = ((value ^ word) * 1099511628211) & ((1 << 64) - 1)
    return f'{len(vectors)} {value:016x}\n'.encode()


def peer_profile(code, language, omit):
    if omit and language == 'rust':
        # The sink path has no writeln return for the older full-output control
        # to intercept. Forget the same buffer immediately before returning.
        marker = '    unsafe { descent_sink_values(x.as_ptr().cast(), x.len()); }\n    Ok(())'
        if marker in code:
            assert code.count(marker) == 1
            code = code.replace(marker, marker.replace('    Ok(())', '    std::mem::forget(next);\n    Ok(())'))
            return COORDINATE.observe_peer_inputs(code, language, 'coordinate', 'checked')
    return COORDINATE.observe_peer_inputs(code, language, 'coordinate', 'missing-release' if omit else 'checked')


def orders(labels, samples, seed):
    count = len(labels)
    assert count >= 2 and count % 2 == 0 and len(set(labels)) == count
    assert samples > 0 and samples % count == 0
    base = [0]
    for i in range(1, count // 2):
        base.extend([i, count-i])
    base.append(count // 2)
    block = [[labels[(i + shift) % count] for i in base] for shift in range(count)]
    assert all(Counter(row[p] for row in block) == Counter(labels) for p in range(count))
    assert Counter((a, b) for row in block for a, b in zip(row, row[1:])) == Counter(
        {(a, b): 1 for a in labels for b in labels if a != b})
    rng = random.Random(seed)
    result = []
    for _ in range(samples // count):
        shuffled = list(block)
        rng.shuffle(shuffled)
        result.extend(shuffled)
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ['compiler', 'output']:
        parser.add_argument('--' + name, required=True, type=Path)
    for name in ['host', 'cc', 'rustc', 'c-arch', 'objdump', 'nm', 'time']:
        parser.add_argument('--' + name, required=True)
    for name in ['samples', 'warmups', 'order-seed', 'timeout', 'build-timeout']:
        parser.add_argument('--' + name, required=True, type=int)
    parser.add_argument('--control-max-difference', required=True, type=float)
    parser.add_argument('--case', required=True, action='append', metavar='COORDINATES:UPDATES:SOLVES')
    args = parser.parse_args()
    assert platform.system() == 'Linux'
    assert min(args.samples, args.warmups, args.timeout, args.build_timeout) > 0
    assert args.samples % 8 == 0 and 0 < args.control_max_difference < 1
    plans = [tuple(map(int, case.split(':'))) for case in args.case]
    assert all(len(plan) == 3 and plan[2] > 0 for plan in plans)
    assert len({plan[:2] for plan in plans}) == len(plans) and any(plan[:2] == (33, 199) for plan in plans)
    assert args.c_arch == {'x86_64': 'x86-64', 'aarch64': 'armv8-a'}[platform.machine()]
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    environment = {k: v for k, v in os.environ.items() if not k.startswith('FWP_') and k not in {'GH_TOKEN', 'GITHUB_TOKEN'}}
    environment.update(CC=args.cc, FWP_LTO='0', FWP_AD_WORKSPACE='1', FWP_PACKED_ARRAYS='1',
                       FWP_STACK='1', FWP_FREE='1', FWP_REUSE='1', FWP_ARRAY_FUSION='1',
                       FWP_GC='off', FWP_GC_STATS='0', FWP_GC_STRESS='0', FWP_GC_VERIFY='0', FWP_REUSE_VERIFY='0')
    flags = ['-O2', '-std=gnu11', '-ffp-contract=off', '-fno-fast-math', '-fno-lto', '-fstack-usage', '-march=' + args.c_arch]
    commands = []

    def run(command, env):
        result = subprocess.run([str(p) for p in command], env=env, capture_output=True, timeout=args.timeout)
        assert result.returncode == 0, (command, result.returncode, result.stderr.decode(errors='replace'))
        return result

    labels = ['fwp-full', 'fwp-sink', 'fwp-full-identical', 'fwp-sink-identical', 'c-full', 'c-sink', 'rust-full', 'rust-sink']
    results = {}
    for points, updates, repetitions in plans:
        assert 2 <= points <= 4096 and 0 <= updates <= 4091
        name = f'{points}-{updates}'
        directory = out / name
        directory.mkdir()
        expected = BATCHES.PEERS.AD.analytic(points, updates + 1)
        source = directory / 'input.fwp'
        source.write_text(BATCHES.PEERS.packed_program(points, updates))
        reference = run([args.compiler.resolve(), 'run', '--interp', source], dict(environment, FWP_NO_OPT='1'))
        assert not reference.stderr
        COORDINATE.check_vectors(reference.stdout, expected, 1)
        (directory / 'interpreter.stdout').write_bytes(reference.stdout)
        generated = directory / 'input.c'
        build([args.compiler.resolve(), 'build', '--gc', 'arc', '--memory', 'dynamic', '--emit-c', '-O2', source, '-o', generated],
              environment, args.build_timeout, commands, out)
        originals = {'fwp': generated.read_text()}
        originals['c'] = f'#define DIMENSIONS {points}\n#define UPDATES {updates}\n' + (ROOT / 'tests/fixtures/descent_coordinate.c').read_text()
        originals['rust'] = (ROOT / 'tests/fixtures/descent_coordinate.rs').read_text().replace(
            '// Measurement parameters are inserted here.', f'const DIMENSIONS: usize = {points};\nconst UPDATES: usize = {updates};')
        sink_objects = {}
        for mode, dump, omit in [('hash', 0, 0), ('dump', 1, 0), ('omit', 0, 1)]:
            obj = directory / ('sink-' + mode + '.o')
            build([args.cc, *flags, '-Wall', '-Wextra', '-Werror', '-DDESCENT_SINK_DUMP=' + str(dump),
                   '-DDESCENT_SINK_OMIT_LAST=' + str(omit), '-c', ROOT / 'tests/fixtures/descent_output_sink.c', '-o', obj],
                  environment, args.build_timeout, commands, out)
            sink_objects[mode] = obj
        binaries, outputs, metadata, profiles, controls, peer_profiles, statuses = {}, {}, {}, {}, {}, {}, {}

        def compile_program(label, language, code, mode, status):
            extension = '.rs' if language == 'rust' else '.c'
            path, binary = directory / (label + extension), directory / label
            path.write_text(code)
            objects = [sink_objects[mode]] if mode else []
            if language == 'rust':
                command = [args.rustc, '--crate-name', 'descent_output', '--edition=2021', '-D', 'warnings',
                           '-C', 'opt-level=2', '-C', 'overflow-checks=yes', '-C', 'codegen-units=1',
                           '-C', 'target-cpu=generic', '-C', 'lto=off', path, '-o', binary]
                for obj in objects:
                    command += ['-C', 'link-arg=' + str(obj)]
            else:
                command = [args.cc, *flags, *(['-w'] if language == 'fwp' else ['-Wall', '-Wextra', '-Werror']),
                           path, *objects, '-o', binary, '-lm', '-lpthread', '-ldl']
            build(command, environment, args.build_timeout, commands, out)
            binaries[label] = binary
            actual = subprocess.run([str(binary)], env=environment, capture_output=True, timeout=args.timeout)
            assert actual.returncode == status, (label, actual.returncode, actual.stderr.decode(errors='replace'))
            (directory / (label + '.stdout')).write_bytes(actual.stdout)
            (directory / (label + '.stderr')).write_bytes(actual.stderr)
            (directory / (label + '.status')).write_text(str(actual.returncode) + '\n')
            statuses[label] = status
            return actual

        for language in ['fwp', 'c', 'rust']:
            for sink in [False, True]:
                label = language + ('-sink' if sink else '-full')
                code = repeated(originals[language], language, repetitions, sink)
                actual = compile_program(label, language, code, 'hash' if sink else '', 0)
                assert not actual.stderr
                outputs[label] = actual.stdout
                if sink:
                    dump = compile_program(label + '-dump', language, code, 'dump', 0)
                    assert not dump.stderr
                    vectors = sink_vectors(dump.stdout, expected, repetitions)
                    assert actual.stdout == sink_checksum(vectors)
                    if (points, updates) == (33, 199):
                        broken = compile_program(label + '-omit', language, code, 'omit', 0)
                        assert not broken.stderr and broken.stdout != actual.stdout
                        controls[label] = dict(expected=actual.stdout.decode(), omittedLast=broken.stdout.decode())
                else:
                    COORDINATE.check_vectors(actual.stdout, expected, repetitions)
                    if language == 'fwp':
                        assert actual.stdout == reference.stdout * repetitions
                if language == 'fwp':
                    instrumented = BATCHES.PEERS.AD.RAW.instrument(BATCHES.PEERS.AD.PROFILE.instrument(originals[language]))
                    instrumented = BATCHES.observe_solves(repeated(instrumented, language, repetitions, sink), 'checked')
                    observed = compile_program(label + '-profile', language, instrumented, 'hash' if sink else '', 0)
                    assert observed.stdout == actual.stdout
                    rows = [json.loads(line) for line in observed.stderr.splitlines()]
                    checkpoints = [row for row in rows if 'solve' in row]
                    assert checkpoints == [dict(solve=i+1, managedLiveBytes=0, rawLiveBytes=0) for i in range(repetitions)]
                    managed, raw = [row for row in rows if 'solve' not in row]
                    assert managed['retains'] == managed['finalChargedBytes'] == managed['collections'] == 0
                    BATCHES.PEERS.AD.RAW.check_profile(raw['rawDerivativeStorage'], 0, True)
                    profiles[label] = dict(managed=managed, raw=raw, completedSolves=len(checkpoints),
                                          observationsSha256=digest(observed.stderr), first=checkpoints[0], last=checkpoints[-1])
                else:
                    for omit in ([False, True] if (points, updates) == (33, 199) else [False]):
                        profiled = label + ('-missing-release' if omit else '-profile')
                        observed = compile_program(profiled, language, peer_profile(code, language, omit),
                                                   'hash' if sink else '', 226 if omit else 0)
                        rows = [json.loads(line) for line in observed.stderr.splitlines()]
                        if omit:
                            assert rows == [dict(solve=1, inputRequests=2, inputRequestedBytes=16*points,
                                                inputLiveBytes=8*points, inputPeakBytes=16*points)]
                            controls[profiled] = dict(status=226, observations=rows)
                        else:
                            assert observed.stdout == actual.stdout
                            assert rows == [dict(solve=i, inputRequests=2*i, inputRequestedBytes=16*points*i,
                                                inputLiveBytes=0, inputPeakBytes=16*points) for i in range(1, repetitions+1)]
                            peer_profiles[label] = dict(completedSolves=len(rows), observationsSha256=digest(observed.stderr),
                                                        first=rows[0], last=rows[-1])
        for mode in ['full', 'sink']:
            label, copy = 'fwp-' + mode, 'fwp-' + mode + '-identical'
            shutil.copyfile(binaries[label], directory / copy)
            (directory / copy).chmod(binaries[label].stat().st_mode)
            shutil.copyfile(directory / (label + '.c'), directory / (copy + '.c'))
            binaries[copy], outputs[copy] = directory / copy, outputs[label]
            statuses[copy] = 0
            assert binaries[copy].read_bytes() == binaries[label].read_bytes()
        for label, binary in binaries.items():
            raw = binary.read_bytes()
            assert raw[:6] == b'\x7fELF\x02\x01'
            assert int.from_bytes(raw[18:20], 'little') == {'x86_64': 62, 'aarch64': 183}[platform.machine()]
            asm = run([args.objdump, '-d', binary], environment).stdout
            symbols = run([args.nm, binary], environment).stdout
            headers = run([args.objdump, '-h', binary], environment).stdout
            assert b'Disassembly of section' in asm
            if label.startswith('fwp'):
                assert not re.search(rb'\bfwp_gc_(?:scan|mark_all|sweep)\b', symbols)
            if '-sink' in label:
                assert b'descent_sink_values' in symbols and b'descent_sink_report' in symbols
            (directory / (label + '.asm')).write_bytes(asm)
            (directory / (label + '.symbols')).write_bytes(symbols)
            (directory / (label + '.headers')).write_bytes(headers)
            path = directory / (label + ('.rs' if label.startswith('rust') else '.c'))
            sizes = re.findall(rb'^\s*\d+\s+\.text\s+([0-9a-fA-F]+)\s', headers, re.M)
            assert sizes
            metadata[label] = dict(bytes=len(raw), sha256=digest(raw), sourceSha256=digest(path.read_bytes()), expectedStatus=statuses[label],
                                   disassemblySha256=digest(asm), instructionBytes=sum(int(s, 16) for s in sizes))
        assert len(metadata) == (24 if (points, updates) == (33, 199) else 17)
        sequence = orders(labels, args.samples, args.order_seed)
        for _ in range(args.warmups):
            for label in labels:
                actual = run([binaries[label]], environment)
                assert actual.stdout == outputs[label] and not actual.stderr
        samples = {label: [] for label in labels}
        for order in sequence:
            for label in order:
                start = time.perf_counter_ns()
                actual = run([binaries[label]], environment)
                samples[label].append(time.perf_counter_ns() - start)
                assert actual.stdout == outputs[label] and not actual.stderr
        medians = {label: statistics.median(rows) for label, rows in samples.items()}
        resident = {}
        for label in labels:
            actual = run([args.time, '-v', binaries[label]], environment)
            assert actual.stdout == outputs[label]
            match, = re.findall(rb'Maximum resident set size \(kbytes\):\s*(\d+)', actual.stderr)
            resident[label] = int(match) * 1024
            (directory / (label + '-rss.txt')).write_bytes(actual.stderr)
        copies = {mode: medians['fwp-' + mode] / medians['fwp-' + mode + '-identical'] for mode in ['full', 'sink']}
        frames = {p.name: dict(sha256=digest(p.read_bytes()), text=p.read_text()) for p in directory.glob('*.su')}
        assert frames
        results[name] = dict(dimensions=points, updates=updates, repetitions=repetitions, profiles=profiles, peerBufferProfiles=peer_profiles,
            controls=controls, inputSourceSha256=digest(source.read_bytes()), inputCSha256=digest(generated.read_bytes()),
            samplesNs=samples, orders=sequence, medianNs=medians, identicalCopyRatios=copies,
            controlsWithinBound={mode: abs(ratio-1) <= args.control_max_difference for mode, ratio in copies.items()},
            sinkToFullRatios={language: medians[language+'-sink']/medians[language+'-full'] for language in ['fwp', 'c', 'rust']},
            fwpToPeerRatios={mode: {language: medians['fwp-'+mode]/medians[language+'-'+mode] for language in ['c', 'rust']} for mode in ['full', 'sink']},
            peakProcessRssBytes=resident, cCompilerStackUsage=frames, binaries=metadata,
            outputSha256={label: digest(raw) for label, raw in outputs.items()})
        (out / 'results.json').write_text(json.dumps(results, indent=2) + '\n')
        print(name, 'sink/full', results[name]['sinkToFullRatios'], 'copy controls', copies, flush=True)
    source = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip()
    inputs = subprocess.check_output(['git', 'ls-files', 'src', 'runtime', 'lib', 'scripts', 'tests/fixtures',
                                      'Cargo.toml', 'Cargo.lock', 'build.rs'], cwd=ROOT, text=True).splitlines()
    inputs += ['scripts/measure-descent-output.py', 'scripts/test-descent-output.py', 'tests/fixtures/descent_output_sink.c']
    report = dict(source=source, sourceHashes={name: digest((ROOT/name).read_bytes()) for name in sorted(set(inputs))},
        host=args.host, machine=platform.machine(), cpu=run(['lscpu'], environment).stdout.decode(),
        compilerSha256=digest(args.compiler.read_bytes()), cCompiler=run([args.cc, '--version'], environment).stdout.decode(),
        rustCompiler=run([args.rustc, '-Vv'], environment).stdout.decode(), commands=commands,
        configuration={k: str(v) if isinstance(v, Path) else v for k, v in vars(args).items()},
        settings={k: v for k, v in environment.items() if k.startswith('FWP_') or k == 'CC'}, results=results,
        scope='Complete repeated solves with ordinary formatted output or a shared external checksum consumer. '
        'Full-output fwp formats the numeric array directly; neither fwp mode creates an output list. '
        'The sink replaces formatted output with checksum work in all three implementations. '
        'This difference is not pure output time or pure arithmetic time. Arithmetic, input creation, update buffers, '
        'bounds checks and cleanup remain. No LTO; the same separately compiled C consumer reads every result coordinate. '
        'Compilation, dump validation, memory profiles and RSS probes are excluded from timed samples. '
        'Each compiler command has a separate explicit deadline and recorded wall time; build-commands.json '
        'is updated after each attempt, including failures. These wall times include host scheduling delays. '
        'C/Rust reuse two numerical buffers; fwp constructs immutable arrays. Memory profiles cover fwp managed/raw storage '
        'and only the numerical buffers in C/Rust; those scopes are not directly comparable. Instrumentation can prevent '
        'allocation elimination, so its counts are not an allocation trace of the timed executable. Process RSS covers each complete '
        'process. One run does not establish a compiler speed improvement.')
    (out / 'comparison.json').write_text(json.dumps(report, indent=2) + '\n')


if __name__ == '__main__':
    main()
