#!/usr/bin/env python3
"""Verify matched derivative baselines without accepting noisy comparisons."""
import argparse
import gzip
import hashlib
import importlib.util
import json
import math
from pathlib import Path
import statistics

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('baseline_checks', ROOT / 'scripts/check-descent-baselines.py')
CHECK = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(CHECK)
SPEC = importlib.util.spec_from_file_location('descent_schedule', ROOT / 'scripts/descent-baselines.py')
SCHEDULE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(SCHEDULE)
SPEC = importlib.util.spec_from_file_location('descent', ROOT / 'scripts/measure-descent-peers.py')
DESCENT = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(DESCENT)
LABELS = ['fwp-ad-history', 'fwp-ad', 'fwp-explicit', 'fwp-packed',
          'c-explicit', 'rust-explicit', 'fwp-ad-identical']
GROUPS = {'3-0': 42, '3-1': 42, '3-199': 21, '3-1999': 7, '33-199': 7, '129-199': 7}
SOLVES = {'3-0': 32768, '3-1': 512, '3-199': 32, '3-1999': 4, '33-199': 32, '129-199': 8}


def reference_contract(protocol):
    """The exact edits and preserved files shared by both archive readers."""
    assert protocol in ('owned-numeric', 'gradient-call', 'packed-pair', 'scalar-constant', 'recording-lookup', 'recording-inline', 'recording-capacity', 'recording-context'), protocol
    gradient = protocol == 'gradient-call'
    expected_paths = {'src/cgen.rs', 'lib/autodiff.fwp'} if gradient else {'src/cgen.rs'}
    expected_transformation = 'scoped input borrowing, numeric fold fields, single-root seeding and consumed array scratch' if gradient else 'consuming scalar array maps and exclusive coordinate-list reuse'
    if protocol == 'packed-pair':
        expected_transformation = 'reuse of the consumed private neighboring-record buffer'
    if protocol == 'scalar-constant':
        expected_transformation = 'exact immediate scalar constants and acyclic cached aliases'
    if protocol == 'recording-lookup':
        expected_transformation = 'validated tape lookup reuse within bounded nonsuspending numeric workers'
    if protocol == 'recording-inline':
        expected_paths = {'runtime/fwp_rt_kernel.c'}
        expected_transformation = 'forced inlining of the checked F64 scalar append body'
    if protocol == 'recording-capacity':
        expected_paths = {'runtime/fwp_rt_kernel.c'}
        expected_transformation = 'inlined checked reserve gate with shared tape growth'
    expected_preserved = set(('src/ownership.rs', 'src/ir.rs', 'src/rc.rs', 'src/rc/borrows.rs', 'src/cgen/owned_numeric.rs', 'src/cgen/scoped_calls.rs', 'src/cgen/fold_fields.rs', 'src/opt/scoped.rs', 'src/cgen/packed_inputs.rs', 'src/cgen/numeric_parameters.rs', 'src/cgen/packed_records.rs', 'src/cgen/range_zip.rs', 'src/fuse.rs', 'src/opt.rs', 'runtime/fwp_rt.c', 'runtime/fwp_rt_heap.c', 'runtime/fwp_rt_prims.c', 'runtime/fwp_rt_task.c', 'runtime/fwp_rt_kernel.c', 'src/numerics.rs', 'src/interp.rs', 'lib/list.fwp')) if gradient else {'src/ir.rs', 'src/rc.rs', 'src/rc/borrows.rs', 'src/cgen/owned_numeric.rs', 'runtime/fwp_rt_task.c', 'runtime/fwp_rt_heap.c', 'src/cgen/packed_inputs.rs', 'src/cgen/numeric_parameters.rs', 'src/fuse.rs', 'runtime/fwp_rt_prims.c', 'src/ownership.rs', 'src/opt/scoped.rs', 'runtime/fwp_rt.c', 'runtime/fwp_rt_kernel.c', 'src/opt.rs', 'lib/list.fwp', 'src/cgen/range_zip.rs', 'lib/autodiff.fwp', 'src/cgen/packed_records.rs'}
    if protocol in ('packed-pair', 'scalar-constant', 'recording-lookup', 'recording-inline', 'recording-capacity', 'recording-context'):
        expected_preserved |= {'src/escape.rs', 'src/cgen/scoped_calls.rs',
                               'src/cgen/fold_fields.rs', 'src/numerics.rs', 'src/interp.rs'}
    if protocol in ('scalar-constant', 'recording-lookup', 'recording-inline', 'recording-capacity', 'recording-context'):
        expected_preserved.add('src/cgen/constant_values.rs')
    if protocol in ('recording-lookup', 'recording-inline', 'recording-capacity', 'recording-context'):
        expected_preserved.add('src/cgen/recording.rs')
    if protocol in ('recording-inline', 'recording-capacity'):
        expected_preserved.remove('runtime/fwp_rt_kernel.c')
        expected_preserved.add('src/cgen.rs')
    if protocol == 'recording-context':
        expected_transformation = 'validated recording state shared through closed numeric calls and loops'
    return expected_transformation, expected_paths, expected_preserved


def check_report(report, source, protocol):
    assert protocol in {'grouped', 'repeated', 'recording', 'eager-captures', 'array-lists', 'record-zip', 'record-fold', 'packed-records', 'callback-owners', 'scalar-map-zip', 'range-zip', 'gradient-array', 'scalar-array-map', 'scalar-array-identity', 'final-iteration', 'matched-option', 'packed-input', 'owned-numeric', 'gradient-call', 'packed-pair', 'scalar-constant', 'recording-lookup', 'recording-inline', 'recording-capacity', 'recording-context'}
    paired = protocol in {'recording', 'eager-captures', 'array-lists', 'record-zip', 'record-fold', 'packed-records', 'callback-owners', 'scalar-map-zip', 'range-zip', 'gradient-array', 'scalar-array-map', 'scalar-array-identity', 'final-iteration', 'matched-option', 'packed-input', 'owned-numeric', 'gradient-call', 'packed-pair', 'scalar-constant', 'recording-lookup', 'recording-inline', 'recording-capacity', 'recording-context'}
    samples, seed = (49, 20261101) if protocol == 'array-lists' else (98, 20261029)
    labels = (['fwp-ad-history', 'fwp-ad', 'fwp-ad-history-reference', 'fwp-ad-reference',
               'c-explicit', 'rust-explicit', 'fwp-ad-identical'] if paired else LABELS)
    assert report['source'] == source
    if protocol in ('matched-option', 'packed-input', 'owned-numeric', 'gradient-call', 'packed-pair', 'scalar-constant', 'recording-lookup', 'recording-inline', 'recording-capacity', 'recording-context'):
        assert report['settings']['FWP_VRET'] == report['settings']['FWP_FRAME_FIELDS'] == '1'
    config = report['configuration']
    assert (config['samples'], config['warmups'], config['order_seed'],
            config['phase_samples'], config['phase_warmups']) == (samples, 2, seed, 12, 2)
    host = report['qualification']
    assert host['source'] == source and host['qualified'] and not host['failures']
    if protocol == 'array-lists':
        # This protocol records each native host before building; unlike the
        # older repeated-solve baseline, it did not freeze one CPU model.
        actual = host['actual']
        assert actual == host['expected']
        assert report['machine'] in {'aarch64', 'x86_64'}
        assert actual['system'] == 'Linux' and actual['machine'] == report['machine']
        assert actual['processors'] == 4
        assert all(actual[key] for key in ('cpu', 'cVersion', 'rustVersion'))
        assert actual['cpu'] in host['lscpu']
        assert report['cCompiler'].splitlines()[0] == actual['cVersion']
        assert report['rustCompiler'].splitlines()[0] == actual['rustVersion']
        assert config['comparison'] == protocol and report['referenceCompiler'] is None
    else:
        check_frozen_host(report, protocol)
    assert report['commands'] and all(c['status'] == 0 and not c['stderr'] for c in report['commands'])
    assert set(report['results']) == set(GROUPS)
    for name, row in report['results'].items():
        dimensions, updates = map(int, name.split('-'))
        assert (row['dimensions'], row['updates']) == (dimensions, updates)
        processes = GROUPS[name] if protocol == 'grouped' else 7
        solves = 1 if protocol == 'grouped' else SOLVES[name]
        assert row['processesPerLabel'] == processes
        if protocol != 'grouped':
            assert row['solvesPerProcess'] == solves
        else:
            assert 'solvesPerProcess' not in row
        case = f'{dimensions}:{updates}:{processes}' + (f':{solves}' if protocol != 'grouped' else '')
        assert case in config['case'] and len(config['case']) == 6
        assert row['orders'] == [SCHEDULE.execution_order(labels, processes, index, seed) for index in range(samples)]
        assert set(row['samplesNs']) == set(row['medianNs']) == set(row['outputSha256']) == set(labels)
        for label, values in row['samplesNs'].items():
            assert len(values) == samples and all(type(value) is int and value > 0 for value in values)
            assert row['medianNs'][label] == statistics.median(values)
        for label, ratios in row['ratios'].items():
            for peer, value in ratios.items():
                assert value == row['medianNs'][label] / row['medianNs'][peer]
        if protocol not in {'grouped', 'array-lists', 'record-zip', 'record-fold', 'packed-records', 'callback-owners', 'scalar-map-zip', 'range-zip', 'gradient-array', 'scalar-array-map', 'scalar-array-identity', 'final-iteration', 'matched-option', 'packed-input', 'owned-numeric', 'gradient-call', 'packed-pair', 'scalar-constant', 'recording-lookup', 'recording-inline', 'recording-capacity', 'recording-context'}:
            ratio = row['medianNs']['fwp-ad'] / row['medianNs']['fwp-ad-identical']
            assert max(ratio, 1 / ratio) <= 1.02, (name, ratio)
        CHECK.check_observations(name, row, updates * solves,
                                 "recording" if paired else "baseline")
    if protocol in {'eager-captures', 'record-zip', 'record-fold', 'packed-records', 'callback-owners', 'scalar-map-zip', 'range-zip', 'gradient-array', 'scalar-array-map', 'scalar-array-identity', 'final-iteration', 'matched-option', 'packed-input', 'owned-numeric', 'gradient-call', 'packed-pair', 'scalar-constant', 'recording-lookup', 'recording-inline', 'recording-capacity', 'recording-context'}:
        assert config['comparison'] == protocol


def check_frozen_host(report, protocol):
    expected_host = dict(system='Linux', machine=report['machine'], processors=4,
                        rustVersion='rustc 1.99.1 (58cf8f9c3 2026-10-13)')
    if report['machine'] == 'aarch64':
        expected_host.update(cpu='Neoverse-N2', cVersion='gcc (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0')
    else:
        assert report['machine'] == 'x86_64'
        expected_host.update(cpu='AMD EPYC 7763 64-Core Processor', cVersion='gcc (Ubuntu 15.2.0-16ubuntu1) 15.2.0')
        if protocol == 'recording-context':
            expected_host['cpu'] = ['AMD EPYC 7763 64-Core Processor',
                                    'AMD EPYC 9V74 80-Core Processor',
                                    'AMD EPYC 9V45 96-Core Processor']
    actual = report['qualification']['actual']
    declared = report['qualification']['expected']
    assert not SCHEDULE.host_failures(actual, declared)
    # Preserve the original exact-host records; the amended protocol must name
    # the complete approved set rather than silently widening its own policy.
    assert declared == expected_host or (
        protocol == 'recording-context' and report['machine'] == 'x86_64'
        and declared == expected_host | {'cpu': 'AMD EPYC 7763 64-Core Processor'})
    assert set(actual) == set(expected_host)
    assert not SCHEDULE.host_failures(actual, expected_host)


def check_archive(archive_path, protocol):
    archive = json.loads(archive_path.read_text())
    assert set(archive['sessions']) == {'arm-1', 'arm-2', 'amd-1', 'amd-2'}
    identities = set()
    source_hashes = None
    failed_sessions = 0
    for label, session in archive['sessions'].items():
        source = session['source'] if protocol in {'eager-captures', 'record-zip', 'record-fold', 'packed-records', 'callback-owners', 'scalar-map-zip', 'range-zip', 'gradient-array', 'scalar-array-map', 'scalar-array-identity', 'final-iteration', 'matched-option', 'packed-input', 'owned-numeric', 'gradient-call', 'packed-pair', 'scalar-constant', 'recording-lookup', 'recording-inline', 'recording-capacity', 'recording-context'} else archive['source']
        run = session['run'] if protocol in {'eager-captures', 'record-zip', 'record-fold', 'packed-records', 'callback-owners', 'scalar-map-zip', 'range-zip', 'gradient-array', 'scalar-array-map', 'scalar-array-identity', 'final-iteration', 'matched-option', 'packed-input', 'owned-numeric', 'gradient-call', 'packed-pair', 'scalar-constant', 'recording-lookup', 'recording-inline', 'recording-capacity', 'recording-context'} else archive['run']
        job = session['job']
        identity = (job['runner_id'], job['started_at'], job['completed_at'])
        assert identity not in identities
        identities.add(identity)
        assert job['run_id'] == run and job['head_sha'] == source
        assert job['status'] == 'completed'
        failed = protocol == 'recording' or (protocol in {'eager-captures', 'record-zip', 'record-fold', 'packed-records', 'callback-owners', 'scalar-map-zip', 'range-zip', 'gradient-array', 'scalar-array-map', 'scalar-array-identity', 'final-iteration', 'matched-option', 'packed-input', 'owned-numeric', 'gradient-call', 'packed-pair', 'scalar-constant', 'recording-lookup', 'recording-inline', 'recording-capacity', 'recording-context'} and bool(session['budgetFailures']))
        assert job['conclusion'] == ('failure' if failed else 'success')
        for kind in ['report', 'log']:
            raw = gzip.decompress((archive_path.parent / session[kind]).read_bytes())
            assert len(raw) == session[kind + 'Bytes']
            assert hashlib.sha256(raw).hexdigest() == session[kind + 'Sha256']
            if kind == 'report':
                report = json.loads(raw)
        check_report(report, source, protocol)
        assert report['machine'] == ('aarch64' if label.startswith('arm') else 'x86_64')
        assert report['configuration']['session'] == int(label[-1])
        assert len(session['files']) == (1334 if protocol in {'recording', 'eager-captures', 'record-zip', 'record-fold', 'packed-records', 'callback-owners', 'scalar-map-zip', 'range-zip', 'gradient-array', 'scalar-array-map', 'scalar-array-identity', 'final-iteration', 'matched-option', 'packed-input', 'owned-numeric', 'gradient-call', 'packed-pair', 'scalar-constant', 'recording-lookup', 'recording-inline', 'recording-capacity', 'recording-context'} else 1157)
        if protocol == 'recording':
            assert archive['decision'] == 'not-accepted'
            assert report['configuration']['comparison'] == 'scalar-recording'
            failures = DESCENT.paired_budget_failures(report['results'], 'scalar-recording')
            assert failures and failures == session['budgetFailures']
            assert all(f['metric'] == 'candidate/reference time' for f in failures)
            reference = report['referenceCompiler']
            assert reference['source'] == archive['source']
            for file, field in [('fwp', 'compilerSha256'), ('ownership-reference.rs', 'referenceOwnershipSha256'),
                                ('reference.patch', 'patchSha256')]:
                assert session['referenceFiles'][file]['sha256'] == reference[field]
            assert hashlib.sha256(session['referencePatch'].encode()).hexdigest() == reference['patchSha256']
        if protocol in {'eager-captures', 'record-zip', 'record-fold', 'packed-records', 'callback-owners', 'scalar-map-zip', 'range-zip', 'gradient-array', 'scalar-array-map', 'scalar-array-identity', 'final-iteration', 'matched-option', 'packed-input', 'owned-numeric', 'gradient-call', 'packed-pair', 'scalar-constant', 'recording-lookup', 'recording-inline', 'recording-capacity', 'recording-context'}:
            failures = DESCENT.paired_budget_failures(report['results'], protocol)
            assert session['budgetFailures'] == failures
            failed_sessions += bool(failures)
            reference = report['referenceCompiler']
            assert reference['source'] == source
            if protocol == 'callback-owners':
                assert reference['scope'] == 'callback-owners'
                assert reference['disabledTransformation'] == 'complete field transfers and numeric callback input owners'
                assert set(reference['files']) == {'src/cgen.rs', 'src/cgen/packed_records.rs'}
                assert set(reference['unchanged']) == {'src/ownership.rs', 'src/cgen/field_transfers.rs', 'src/cgen/numeric_parameters.rs'}
                expected_files = {'fwp': reference['compilerSha256'], 'reference.patch': reference['patchSha256']}
                for path, hashes in reference['files'].items():
                    assert hashes['candidateSha256'] == report['sourceHashes'][path]
                    expected_files['reference-' + Path(path).name] = hashes['referenceSha256']
                for path, expected_hash in reference['unchanged'].items():
                    assert report['sourceHashes'][path] == expected_hash
            elif protocol in ('owned-numeric', 'gradient-call', 'packed-pair', 'scalar-constant', 'recording-lookup', 'recording-inline', 'recording-capacity', 'recording-context'):
                expected_transformation, expected_paths, expected_preserved = reference_contract(protocol)
                assert reference['disabledTransformation'] == expected_transformation
                assert set(reference['candidate']) == set(reference['reference']) == expected_paths
                assert set(reference['unchanged']) == expected_preserved
                expected_files = {'fwp': reference['compilerSha256'], 'reference.patch': reference['patchSha256']}
                for path, checksum in reference['candidate'].items():
                    assert checksum == report['sourceHashes'][path]
                    expected_files['source/' + path] = reference['reference'][path]
                for path, checksum in reference['unchanged'].items():
                    assert checksum == report['sourceHashes'][path]
                assert reference['ownershipSha256'] == report['sourceHashes']['src/ownership.rs']
            elif protocol == 'packed-input':
                assert reference['disabledTransformation'] == 'scoped objective specialization and private numeric input packing'
                assert set(reference['candidate']) == set(reference['reference']) == {'src/cgen.rs', 'src/mono.rs'}
                assert set(reference['unchanged']) == {'runtime/fwp_rt_task.c', 'runtime/fwp_rt_heap.c', 'src/cgen/packed_inputs.rs', 'src/cgen/numeric_parameters.rs', 'src/fuse.rs', 'runtime/fwp_rt_prims.c', 'src/ownership.rs', 'src/opt/scoped.rs', 'runtime/fwp_rt.c', 'runtime/fwp_rt_kernel.c', 'src/opt.rs', 'lib/list.fwp', 'src/cgen/range_zip.rs', 'lib/autodiff.fwp', 'src/cgen/packed_records.rs'}
                expected_files = {'fwp': reference['compilerSha256'], 'reference.patch': reference['patchSha256']}
                for path, checksum in reference['candidate'].items():
                    assert checksum == report['sourceHashes'][path]
                    expected_files['source/' + path] = reference['reference'][path]
                for path, checksum in reference['unchanged'].items():
                    assert checksum == report['sourceHashes'][path]
                assert reference['ownershipSha256'] == report['sourceHashes']['src/ownership.rs']
            elif protocol == 'matched-option':
                assert reference['disabledTransformation'] == 'direct fields for matched list last, nth and final iteration results'
                assert set(reference['candidate']) == set(reference['reference']) == {'src/cgen.rs'}
                assert set(reference['unchanged']) == {'src/fuse.rs', 'src/prims_std.rs', 'src/ownership.rs', 'src/opt.rs', 'runtime/fwp_rt.c', 'runtime/fwp_rt_prims.c', 'runtime/fwp_rt_task.c', 'runtime/fwp_rt_heap.c', 'lib/list.fwp', 'lib/autodiff.fwp'}
                expected_files = {'fwp': reference['compilerSha256'], 'reference.patch': reference['patchSha256']}
                for path, checksum in reference['candidate'].items():
                    assert checksum == report['sourceHashes'][path]
                    expected_files['source/' + path] = reference['reference'][path]
                for path, checksum in reference['unchanged'].items():
                    assert checksum == report['sourceHashes'][path]
                assert reference['ownershipSha256'] == report['sourceHashes']['src/ownership.rs']
            elif protocol == 'final-iteration':
                assert reference['disabledTransformation'] == 'direct list last and unused numeric iteration history removal'
                assert set(reference['candidate']) == set(reference['reference']) == {'src/fuse.rs', 'lib/list.fwp'}
                assert set(reference['unchanged']) == {'src/cgen.rs', 'src/prims_std.rs', 'src/ownership.rs', 'src/opt.rs', 'runtime/fwp_rt_prims.c', 'runtime/fwp_rt_heap.c', 'lib/autodiff.fwp'}
                expected_files = {'fwp': reference['compilerSha256'], 'reference.patch': reference['patchSha256']}
                for path, checksum in reference['candidate'].items():
                    assert checksum == report['sourceHashes'][path]
                    expected_files['source/' + path] = reference['reference'][path]
                for path, checksum in reference['unchanged'].items():
                    assert checksum == report['sourceHashes'][path]
                assert reference['ownershipSha256'] == report['sourceHashes']['src/ownership.rs']
            elif protocol == 'gradient-array':
                assert reference['disabledTransformation'] == 'owned gradient arrays and direct array/list zip'
                assert set(reference['candidate']) == set(reference['reference']) == {'lib/autodiff.fwp', 'runtime/fwp_rt_kernel.c', 'src/cgen.rs', 'src/fuse.rs', 'src/interp.rs', 'src/ir.rs', 'src/numerics.rs'}
                expected_files = {'fwp': reference['compilerSha256'], 'reference.patch': reference['patchSha256']}
                for path, checksum in reference['candidate'].items():
                    assert checksum == report['sourceHashes'][path]
                    expected_files['source/' + path] = reference['reference'][path]
                assert reference['ownershipSha256'] == report['sourceHashes']['src/ownership.rs']
                assert reference['frozenPatchSha256'] == report['sourceHashes']['scripts/gradient-array-candidate.patch']
            else:
                if protocol == 'scalar-array-identity':
                    assert reference['disabledTransformation'] == 'F64 identity array-map elimination'
                    assert reference['candidateOptimizerSha256'] == report['sourceHashes']['src/opt.rs']
                    assert set(reference['unchanged']) == {'src/interp.rs', 'runtime/fwp_rt_num.c', 'src/cgen.rs'}
                    for path, checksum in reference['unchanged'].items():
                        assert report['sourceHashes'][path] == checksum, path
                    reference_source = ('optimizer-reference.rs', 'referenceOptimizerSha256')
                elif protocol == 'eager-captures':
                    assert reference['disabledTransformation'] == 'once-used eager capture bindings'
                    assert reference['candidateOptimizerSha256'] == report['sourceHashes']['src/opt.rs']
                    reference_source = ('optimizer-reference.rs', 'referenceOptimizerSha256')
                elif protocol == 'record-zip':
                    assert reference['disabledTransformation'] == 'flat numeric record zip/map fusion'
                    assert reference['candidateFusionSha256'] == report['sourceHashes']['src/fuse.rs']
                    reference_source = ('fusion-reference.rs', 'referenceFusionSha256')
                else:
                    expected = ('direct closed scalar array map callbacks' if protocol == 'scalar-array-map'
                        else 'private range-to-zip storage' if protocol == 'range-zip'
                        else 'scalar map-to-zip buffer storage' if protocol == 'scalar-map-zip'
                                else 'packed temporary numeric-record storage' if protocol == 'packed-records'
                                else 'direct numeric-record left folds')
                    assert reference['disabledTransformation'] == expected
                    assert reference['candidateCodegenSha256'] == report['sourceHashes']['src/cgen.rs']
                    reference_source = ('codegen-reference.rs', 'referenceCodegenSha256')
                assert reference['ownershipSha256'] == report['sourceHashes']['src/ownership.rs']
                expected_files = {file: reference[field] for file, field in
                                  [('fwp', 'compilerSha256'), reference_source, ('reference.patch', 'patchSha256')]}
            for file, expected_hash in expected_files.items():
                assert session['referenceFiles'][file]['sha256'] == expected_hash
            assert hashlib.sha256(session['referencePatch'].encode()).hexdigest() == reference['patchSha256']
            assert session['files']['comparison.json']['sha256'] == session['reportSha256']
            # A replacement host may run a later workflow-only commit. Every
            # measured compiler/runtime/input/tool hash must still agree.
            if source_hashes is None:
                source_hashes = report['sourceHashes']
            assert report['sourceHashes'] == source_hashes
        for name, row in report['results'].items():
            for image, metadata in row['binaries'].items():
                file = session['files'][name + '/' + image]
                assert (file['bytes'], file['sha256']) == (metadata['bytes'], metadata['sha256'])
            for phase, count in [('warmup', 2), ('sample', 98)]:
                assert all(f'{name}/{phase}-{index:03d}.json' in session['files'] for index in range(count))
            derived = session['derived'][name]
            assert set(derived['instructionSections']) == set(row['binaries'])
            assert all(value.get('.text', 0) > 0 for value in derived['instructionSections'].values())
            assert derived['identicalMedianRatio'] == row['ratios']['fwp-ad']['fwp-ad-identical']
            ratios = [a / b for a, b in zip(row['samplesNs']['fwp-ad'], row['samplesNs']['fwp-ad-identical'])]
            paired = [max(ratio, 1 / ratio) for ratio in ratios]
            assert derived['identicalPairedP95'] == sorted(paired)[math.ceil(.95 * len(paired)) - 1]
    if protocol in {'eager-captures', 'record-zip', 'record-fold', 'packed-records', 'callback-owners', 'scalar-map-zip', 'range-zip', 'gradient-array', 'scalar-array-map', 'scalar-array-identity', 'final-iteration', 'matched-option', 'packed-input', 'owned-numeric', 'gradient-call', 'packed-pair', 'scalar-constant', 'recording-lookup', 'recording-inline', 'recording-capacity', 'recording-context'}:
        assert archive['decision'] == ('not-accepted' if failed_sessions else 'accepted')
        print(f'Four {protocol} sessions audited; {failed_sessions} failed sessions retained')
    else:
        print(f'Four {protocol} sessions audited; all original outcomes retained')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--archive', type=Path, required=True)
    parser.add_argument('--protocol', choices=['grouped', 'repeated', 'recording', 'eager-captures', 'record-zip', 'record-fold', 'packed-records', 'callback-owners', 'scalar-map-zip', 'range-zip', 'gradient-array', 'scalar-array-map', 'scalar-array-identity', 'final-iteration', 'matched-option', 'packed-input', 'owned-numeric', 'gradient-call', 'packed-pair', 'scalar-constant', 'recording-lookup', 'recording-inline', 'recording-capacity', 'recording-context'], required=True)
    args = parser.parse_args()
    check_archive(args.archive, args.protocol)
