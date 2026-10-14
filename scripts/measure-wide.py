#!/usr/bin/env python3
"""Runner evidence for checked wide scalar/record workers and boxed boundaries."""
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import re
import statistics
import time

ROOT = Path(__file__).resolve().parent.parent
spec = importlib.util.spec_from_file_location('iteration', ROOT / 'scripts/measure-iteration.py')
iteration = importlib.util.module_from_spec(spec)
spec.loader.exec_module(iteration)
run = iteration.run


def main():
    import argparse
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'full evidence runs on GitHub'
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', required=True, type=Path)
    out = parser.parse_args().output.resolve()
    out.mkdir(parents=True, exist_ok=True)
    compiler = ROOT / 'target/release/fwp'
    cc = os.environ.get('CC', 'cc')
    environment = dict(os.environ, FWP_GC_STRESS='0', FWP_GC_VERIFY='0', FWP_REUSE_VERIFY='0')
    environment.pop('FWP_NO_OPT', None)
    cpp = os.environ.get('CXX', cc)
    results = {}
    workloads = {}
    for kind in ('I128', 'U128', 'F128'):
        suffix = kind.lower()
        decimal = '.0' if kind == 'F128' else ''
        workloads[suffix] = f"""rec sum-wide : {kind} -> {kind}
sum-wide = if (eq 0{decimal}{suffix}) (const 0{decimal}{suffix}) (fork add id (sub 1{decimal}{suffix} | sum-wide))
main = 256{decimal}{suffix} | sum-wide | echo
"""
    workloads['records'] = (ROOT / 'tests/fixtures/wide_records.fwp').read_text().replace('remaining = const 8', 'remaining = const 256')
    core_objects = []
    core_commands = []
    for suffix, text in workloads.items():
        source = out / (suffix + '.fwp')
        source.write_text(text)
        reference = run([compiler, 'run', '--interp', source], dict(environment, FWP_NO_OPT='1')).stdout
        if suffix != 'records':
            assert reference == ('3.2896e4\n' if suffix == 'f128' else '32896\n'), reference
        for enabled in ('0', '1'):
            label = suffix + ('-native' if enabled == '1' else '-boxed')
            env = dict(environment, FWP_WIDE_WORKERS=enabled)
            cfile = out / (label + '.c')
            run([compiler, 'build', '--gc', 'arc', '--emit-c', source, '-o', cfile], env)
            code = cfile.read_text()
            assert ('/* native wide worker:' in code) == (enabled == '1')
            workers = []
            worker_entries = set()
            for section in code.split('/* native wide worker:')[1:]:
                worker = section.split('\nstatic V f', 1)[0]
                assert 'fwp_box_' not in worker and 'fwp_alloc' not in worker
                workers.append(worker)
                worker_entries.add('f' + re.search(r'\bfwp_wide(\d+)\(', worker).group(1))
            profile = out / (label + '-profile.c')
            profile.write_text(iteration.instrument(code))
            if '#define FWP_EXACT_FLOAT 1' in code and not core_objects:
                for extension, tool, flags in (
                    ('float.c', cc, ['-std=c11']),
                    ('float.cpp', cpp, ['-std=c++20', '-fno-exceptions', '-fno-rtti']),
                ):
                    obj = out / (extension + '.o')
                    command = [tool, '-O2', '-fno-fast-math', '-ffp-contract=off', *flags,
                               '-c', cfile.with_suffix('.' + extension), '-o', obj]
                    run(command, env)
                    core_commands.append(list(map(str, command)))
                    core_objects.append(obj)
            commands = []
            for path, executable in ((cfile, out / label), (profile, out / (label + '-profile'))):
                obj = executable.with_suffix('.o')
                compile_command = [cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-fstack-usage', '-w', '-c', path, '-o', obj]
                link_command = [cc, obj, *core_objects, '-o', executable, '-lm', '-lpthread']
                for command in (compile_command, link_command):
                    run(command, env)
                    commands.append(list(map(str, command)))
            stack_usage = []
            for line in (out / (label + '.su')).read_text().splitlines():
                location, size, qualifier = line.split('\t')
                function = location.rsplit(':', 1)[-1]
                if function.startswith('fwp_wide') or function in worker_entries:
                    stack_usage.append(dict(function=function, bytes=int(size), qualifier=qualifier,
                                            boundary='worker' if function.startswith('fwp_wide') else 'generic-entry'))
            if enabled == '1':
                assert stack_usage, 'worker or its inlined generic entry must retain stack evidence'
            samples = []
            for _ in range(5):
                start = time.perf_counter_ns()
                actual = run([out / label], env)
                samples.append(time.perf_counter_ns() - start)
                assert actual.stdout == reference
            measured = run([out / (label + '-profile')], env)
            assert measured.stdout == reference
            counters = json.loads(measured.stderr)
            assert counters['collections'] == 0 and counters['finalChargedBytes'] <= 0, counters
            binary = out / label
            asm = ['otool', '-tvV', binary] if platform.system() == 'Darwin' else ['objdump', '-d', binary]
            (out / (label + '.asm')).write_text(run(asm).stdout)
            (out / (label + '.symbols')).write_text(run(['nm', binary]).stdout)
            results[label] = dict(output=reference, counters=counters, commands=commands,
                processWallNs=samples, medianProcessWallNs=statistics.median(samples),
                sourceSha256=hashlib.sha256(source.read_bytes()).hexdigest(),
                generatedSha256=hashlib.sha256(cfile.read_bytes()).hexdigest(), nativeWorkers=len(workers),
                nativeWorkerStack=stack_usage)
        assert results[suffix + '-native']['counters']['requests'] < results[suffix + '-boxed']['counters']['requests']
    report = dict(head=run(['git', 'rev-parse', 'HEAD']).stdout.strip(), hardware=platform.uname()._asdict(),
        cpu=run(['sysctl', '-n', 'machdep.cpu.brand_string'] if platform.system() == 'Darwin' else ['lscpu']).stdout,
        cc=run([cc, '--version']).stdout, cxx=run([cpp, '--version']).stdout, coreCommands=core_commands, rustc=run(['rustc', '--version', '--verbose']).stdout,
        recursiveSteps=256, results=results,
        scope='Equivalent checked arithmetic with worker lowering enabled/disabled. Fixed 256-step scalar sums and numeric record walks. Exact quad software arithmetic is linked identically in both variants. Process timings include startup and output; no speed threshold. Separate instrumented binaries count managed requests, retains and charged live storage, excluding allocator metadata. Native disassembly, symbols and compiler stack-usage reports are retained. Stack figures describe one invocation, not total recursive depth. No universal C/Rust parity claim.')
    (out / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps({name: r['counters'] for name, r in results.items()}, indent=2))


if __name__ == '__main__':
    main()
