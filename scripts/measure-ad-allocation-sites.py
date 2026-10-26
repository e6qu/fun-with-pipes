#!/usr/bin/env python3
"""Runner-only attribution of derivative allocation requests to native call sites."""
import argparse
import bisect
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import re
import sys

ROOT = Path(__file__).resolve().parent.parent
sys.dont_write_bytecode = True
spec = importlib.util.spec_from_file_location('metadata', ROOT / 'scripts/measure-ad-metadata.py')
metadata = importlib.util.module_from_spec(spec)
spec.loader.exec_module(metadata)
run = metadata.run

HELPERS = r'''
static void *fwp_main_thread(void *);
/* This diagnostic has an explicit 1024-site limit, no profiling heap storage. */
static struct { uintptr_t pc; uint64_t requests, bytes; } allocation_sites[1024];
static void allocation_site(void *address, size_t bytes) {
    uintptr_t pc = (uintptr_t)address;
    size_t slot = (pc >> 4) & 1023;
    for (size_t visited = 0; visited < 1024; visited++, slot = (slot + 1) & 1023) {
        if (!allocation_sites[slot].pc || allocation_sites[slot].pc == pc) {
            allocation_sites[slot].pc = pc;
            allocation_sites[slot].requests++; allocation_sites[slot].bytes += bytes;
            return;
        }
    }
    fprintf(stderr, "allocation-site profile exceeded 1024 distinct addresses\n"); abort();
}
static void allocation_report(void) {
    fprintf(stderr,"{\"sites\":[");
    int comma = 0;
    for (size_t i = 0; i < 1024; i++) if (allocation_sites[i].pc) {
        fprintf(stderr,"%s{\"returnOffset\":%lld,\"requests\":%llu,\"requestedBytes\":%llu}",
            comma ? "," : "", (long long)((intptr_t)allocation_sites[i].pc - (intptr_t)&fwp_main_thread),
            (unsigned long long)allocation_sites[i].requests, (unsigned long long)allocation_sites[i].bytes);
        comma = 1;
    }
    fprintf(stderr,"]}\n");
}
'''


def instrument(original):
    code = metadata.checkpoint.instrument(original)
    marker = 'typedef uint64_t V;'
    assert code.count(marker) == 1
    code = code.replace(marker, marker + HELPERS)
    for name, parameters, condition in [
        ('fwp_heap_alloc', 'size_t n, int kind', 'iteration_active && kind!=0'),
        ('fwp_alloc_init', 'size_t n', 'iteration_active'),
    ]:
        signature = f'static inline void *{name}({parameters}) {{'
        assert code.count(signature) == 1
        code = code.replace(signature, f'static __attribute__((noinline)) void *{name}({parameters}) {{')
        count = f'if({condition}){{iteration_requests++;iteration_bytes+=n;}}'
        assert code.count(count) == 1
        code = code.replace(count, count[:-1] +
            'allocation_site(__builtin_extract_return_addr(__builtin_return_address(0)),n);}')
    marker = '    iteration_active=0;\n'
    assert code.count(marker) == 1
    return code.replace(marker, marker + '    allocation_report();\n')


def symbols(binary):
    text = run(['nm', '-an', binary]).stdout
    result = []
    for line in text.splitlines():
        match = re.fullmatch(r'([0-9a-fA-F]+)\s+[tT]\s+(\S+)', line.strip())
        if match:
            result.append((int(match[1], 16), match[2]))
    return sorted(result), text


def language_functions(code):
    result = {}
    description = None
    for part in re.split(r'(/\* [^\n]+ \*/\n)', code):
        if part.startswith('/* '):
            description = part[3:-4].strip()
        else:
            for name in re.findall(r'^static (?:V|fwp_r\d+|double|int\d+_t|uint\d+_t) ([fw]\d+)\(', part, re.M):
                result[name] = description
    return result


def attribute(binary, source, sites):
    entries, raw_symbols = symbols(binary)
    anchor = '_fwp_main_thread' if platform.system() == 'Darwin' else 'fwp_main_thread'
    bases = [address for address, name in entries if name == anchor]
    assert len(bases) == 1, bases
    # Return addresses point past the call; the preceding byte belongs to it.
    addresses = [bases[0] + site['returnOffset'] - 1 for site in sites]
    encoded = [hex(address) for address in addresses]
    if platform.system() == 'Darwin':
        decoded = run(['atos', '-o', binary, *encoded]).stdout
        descriptions = decoded.splitlines()
        assert len(descriptions) == len(sites), decoded
    else:
        decoded = run(['addr2line', '-a', '-f', '-i', '-e', binary, *encoded]).stdout
        descriptions = re.split(r'^0x[0-9a-fA-F]+\n', decoded, flags=re.M)[1:]
        assert len(descriptions) == len(sites), decoded
    functions = language_functions(source)
    starts = [address for address, _ in entries]
    result = []
    for site, address, description in zip(sites, addresses, descriptions, strict=True):
        assert '??' not in description and description.strip() != hex(address), description
        index = bisect.bisect_right(starts, address) - 1
        assert index >= 0
        function = entries[index][1]
        result.append(dict(site, binaryCallAddress=hex(address), nativeFunction=function,
            languageSignature=functions.get(function.removeprefix('_')),
            sourceLocation=description.strip()))
    return sorted(result, key=lambda row: row['requests'], reverse=True), raw_symbols, decoded


def main():
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'full allocation evidence runs on GitHub'
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    out = parser.parse_args().output.resolve()
    out.mkdir(parents=True, exist_ok=True)
    compiler = ROOT / 'target/release/fwp'
    environment = dict(os.environ, FWP_AD_WORKSPACE='1', FWP_GC_STRESS='0',
                       FWP_GC_VERIFY='0', FWP_REUSE_VERIFY='0')
    environment.pop('FWP_NO_OPT', None)
    results = {}
    for name in ['identity', 'map', 'sustained-map', 'nested']:
        program, expected = metadata.CASES[name]
        source = out / (name + '.fwp'); source.write_text(program)
        raw = run([compiler, 'run', '--interp', source], dict(environment, FWP_NO_OPT='1'))
        assert raw.stdout == expected and not raw.stderr
        emitted = out / (name + '.c')
        run([compiler, 'build', '--emit-c', source, '-o', emitted], environment)
        original = emitted.read_text()
        variants = {}
        for label, code in [('totals', metadata.checkpoint.instrument(original)), ('sites', instrument(original))]:
            cfile = out / f'{name}-{label}.c'; cfile.write_text(code)
            binary = out / f'{name}-{label}'
            command = [os.environ.get('CC', 'cc'), '-O2', '-g', '-std=gnu11', '-ffp-contract=off',
                       '-w', cfile, '-o', binary, '-lm', '-lpthread']
            run(command, environment)
            measured = run([binary], environment)
            assert measured.stdout == expected
            rows = list(map(json.loads, measured.stderr.splitlines()))
            tape, managed = rows[0], rows[-1]
            assert tape['finalTapeBytes'] == managed['finalChargedBytes'] == managed['collections'] == 0
            data = dict(tape=tape, managed=managed, command=list(map(str, command)),
                generatedSha256=hashlib.sha256(cfile.read_bytes()).hexdigest(),
                binarySha256=hashlib.sha256(binary.read_bytes()).hexdigest())
            if label == 'sites':
                sites = rows[1]['sites']
                assert sum(row['requests'] for row in sites) == managed['requests']
                assert sum(row['requestedBytes'] for row in sites) == managed['requestedBytes']
                data['sites'], nm, decoded = attribute(binary, code, sites)
                (out / f'{name}-symbols.txt').write_text(nm)
                (out / f'{name}-locations.txt').write_text(decoded)
            else:
                assert len(rows) == 2
            variants[label] = data
        assert variants['totals']['managed'] == variants['sites']['managed'], name
        assert variants['totals']['tape'] == variants['sites']['tape'], name
        results[name] = dict(source=program, variants=variants)
    report = dict(head=run(['git', 'rev-parse', 'HEAD']).stdout.strip(), results=results,
        hardware=platform.uname()._asdict(),
        cpu=run(['sysctl', '-n', 'machdep.cpu.brand_string'] if platform.system() == 'Darwin' else ['lscpu']).stdout,
        compiler=run([os.environ.get('CC', 'cc'), '--version']).stdout,
        scope='Allocation attribution, not timing. ARC and workspace reuse enabled. Initial constants excluded. '
              'Two allocation entry wrappers are deliberately not inlined to record return addresses; '
              'managed/tape totals must equal the existing aggregate instrumentation. Call addresses are '
              'normalized against fwp_main_thread and mapped through native symbols/debug locations. '
              'Raw interpreter output is the semantic reference. This is not a C/Rust performance comparison.')
    (out / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps({name: row['variants']['sites']['sites'][:12] for name, row in results.items()}, indent=2))


if __name__ == '__main__':
    main()
