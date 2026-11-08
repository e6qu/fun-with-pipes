#!/usr/bin/env python3
"""Native correctness and failure controls; driver clock values are not assessed."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess

from process_wait import run_capture
from structured_ad_costs import ROOT, cases, driver, entry_and_drops, program
from structured_ad_observations import check_reports, instrument, replace_once


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, required=True)
    parser.add_argument('--cc', required=True)
    parser.add_argument('--c-arch', choices=('armv8-a', 'x86-64'), required=True)
    parser.add_argument('--platform', choices=('linux', 'darwin'), required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    output = args.output.resolve(); output.mkdir(parents=True, exist_ok=False)
    compiler = args.compiler.resolve()
    environment = {key: value for key, value in os.environ.items()
                   if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment.update(CC=args.cc, FWP_LTO='0', FWP_STACK='1', FWP_ARRAY_FUSION='1',
        FWP_PACKED_ARRAYS='1', FWP_VRET='1', FWP_FRAME_FIELDS='1', FWP_AD_WORKSPACE='1', LC_ALL='C')
    flags = ['-O2', '-std=gnu11', '-ffp-contract=off', '-fno-fast-math', '-fno-lto', '-march=' + args.c_arch]
    libraries = ['-lm', '-lpthread'] + (['-ldl'] if args.platform == 'linux' else [])
    (output / 'identity.json').write_text(json.dumps(dict(
        source=subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip(),
        compilerSha256=hashlib.sha256(compiler.read_bytes()).hexdigest(), flags=flags,
        ccVersion=subprocess.check_output([args.cc, '--version'], text=True),
        settings={key: value for key, value in environment.items() if key.startswith('FWP_')}), indent=2)+'\n')

    def run(command, label, expected_status):
        command = list(map(str, command))
        result = run_capture(command, timeout=180, cwd=ROOT, env=environment,
            input_data=None, input_stream=None, text=True, encoding='utf-8', check=False)
        (output / (label + '.stdout')).write_text(result.stdout)
        (output / (label + '.stderr')).write_text(result.stderr)
        with (output / 'commands.jsonl').open('a') as log:
            log.write(json.dumps(dict(command=command, label=label, status=result.returncode,
                                      expectedStatus=expected_status))+'\n')
        assert result.returncode == expected_status, (command, result.returncode, result.stdout, result.stderr)
        return result

    def compile_source(source, label):
        cfile = output / (label + '.c'); cfile.write_text(source)
        binary = output / label
        result = run([args.cc, *flags, cfile, '-o', binary, *libraries], label + '-compile', 0)
        assert not result.stderr, result.stderr
        return binary

    saved = {}
    for family, count, method in (('neighbors', 0, 'reverse'), ('neighbors', 3, 'reverse'),
                                  ('independent', 16, 'tensor'), ('dense', 3, 'forward'),
                                  ('neighbors', 3, 'local'), ('independent', 16, 'local')):
        case = next(value for value in cases() if value['family'] == family and value['count'] == count)
        label = case['name'] + '-' + method
        fwp = output / (label + '.fwp'); fwp.write_text(program(family, method))
        emitted = output / (label + '-generated.c')
        result = run([compiler, 'build', '--fn', 'measure', '--emit-c', '-O2', fwp, '-o', emitted], label + '-emit', 0)
        assert not result.stderr, result.stderr
        generated = emitted.read_text()
        source = driver(generated, case)
        binary = compile_source(source, label)
        result = run([binary, count], label + '-ordinary', 0)
        ordinary = json.loads(result.stdout)
        assert not result.stderr and ordinary['initialLiveBytes'] == ordinary['finalLiveBytes']
        measured = instrument(source)
        binary = compile_source(measured, label + '-observed')
        for workspace in (True, False):
            environment['FWP_AD_WORKSPACE'] = str(int(workspace))
            result = run([binary, count], label + '-observed-' + str(int(workspace)), 0)
            observed = json.loads(result.stdout)
            assert observed['checksum'] == ordinary['checksum']
            assert observed['retainedManagedBytesAfterCall'] == ordinary['retainedManagedBytesAfterCall']
            managed, raw = [json.loads(line) for line in result.stderr.splitlines()]
            check_reports(managed, raw['rawDerivativeStorage'], count, case['repeats'], method, workspace)
            if method == 'local':
                assert managed['requests'] <= case['repeats'] * (2 * count + 2), managed
                assert raw['rawDerivativeStorage']['peakBytes'] == 0
        environment['FWP_AD_WORKSPACE'] = '1'
        saved[label] = dict(generated=generated, ordinary=source, observed=measured)
        print(label, 'correct output, aliases, managed owners and raw tape release', flush=True)

    dense = saved['dense-3-forward']
    _, drop_values, _ = entry_and_drops(dense['generated'])
    for label, source, before, after, status in (
        ('bad-result', dense['ordinary'], '        V cursor = result;',
         '        OBJ(result)->f[0] = fwp_from_f64(10000.0);\n        V cursor = result;', 212),
        ('changed-input', dense['ordinary'], '        verify_input(input_alias, count);',
         '        OBJ(input_alias)->f[0] = fwp_from_f64(10000.0);\n        verify_input(input_alias, count);', 213),
        ('missing-input-drop', dense['ordinary'], drop_values + '(input_alias);', '(void)input_alias;', 214),
        ('missing-constant-cleanup', dense['ordinary'], '    fwp_caf_finish();\n    release +=',
         '    /* omitted constant cleanup */\n    release +=', 214),
        ('missing-raw-free', saved['neighbors-3-reverse']['observed'], 'ad_raw_free(b->ops);', '(void)b->ops;', 232),
    ):
        binary = compile_source(replace_once(source, before, after), label)
        run([binary, 3], label + '-run', status)
        print(label, 'rejected:', status, flush=True)

    # One allocated list cell, one added owner, one shared drop and one last-owner
    # destruction. The generated list destructor also visits the Nil tail.
    source = dense['generated'].replace('int main(int argc, char **argv)', 'int original_main(int argc, char **argv)')
    source += '''\n/* Complete-gradient call: known-work observer control. */
int main(void) {
    fwp_heap_start(); fwp_fns=fwp_fn_table; fwp_init_consts(); fwp_tasks_init();
    size_t initial=fwp_heap.live;
    /* Structured gradient observer starts here. */
    V value=fwp_rc_fresh(fwp_cons(0,0)); fwp_rc_dup(value);
    DROP_VALUE(value); DROP_VALUE(value);
    if(fwp_heap.live!=initial)return 214;
    /* Structured gradient observer stops here. */
    puts("{}"); fwp_caf_finish(); fwp_native_tasks_finish(); return 0;
}
'''.replace('DROP_VALUE', drop_values)
    measured = instrument(source)
    expected = dict(requests=1, requestedBytes=24, retainCalls=1, retains=1,
        dropCalls=0, dropChanges=0, releaseCalls=3, sharedReleases=1, lastOwners=1,
        uncountedReleases=1, peakChargedBytes=32, finalChargedBytes=0)
    for label, source, agrees in (
        ('known-cell', measured, True),
        ('missing-allocation-event', measured.replace('iteration_requests++;', '/* omitted request */'), False),
        ('doubled-allocation-event', measured.replace('iteration_requests++;', 'iteration_requests+=2;'), False),
    ):
        binary = compile_source(source, label)
        result = run([binary], label + '-run', 0)
        managed, raw = [json.loads(line) for line in result.stderr.splitlines()]
        assert (managed == expected) == agrees, (label, managed, expected)
        assert raw['rawDerivativeStorage']['finalBytes'] == 0
        print(label, 'observer agreement:', agrees, flush=True)
    print('Six native cases, five rejected runtime faults and three known-work observer controls pass.')


if __name__ == '__main__':
    main()
