#!/usr/bin/env python3
"""Reject fabricated parser timing, storage and phase-boundary evidence."""

import copy
import hashlib
import importlib.util
from pathlib import Path
import unittest

READER_SPEC = importlib.util.spec_from_file_location('parser_reader', Path(__file__).with_name('inspect-parser-workspace.py'))
READER = importlib.util.module_from_spec(READER_SPEC)
READER_SPEC.loader.exec_module(READER)
MEASURE_SPEC = importlib.util.spec_from_file_location('parser_measure', Path(__file__).with_name('measure-parser-workspace.py'))
MEASURE = importlib.util.module_from_spec(MEASURE_SPEC)
MEASURE_SPEC.loader.exec_module(MEASURE)


class ParserEvidence(unittest.TestCase):
    def setUp(self):
        self.settings = dict(samples=6, rounds=32768, small_rounds=32768, max_control_ratio=1.10)

        def sample(label, count):
            total = {'baseline': 100_000_000, 'baseline-copy': 102_000_000,
                     'candidate': 60_000_000, 'c': 30_000_000, 'rust': 40_000_000}.get(label, 100_000_000)
            value = dict(rounds=count, nodes=31, result=-8, totalNs=total,
                         tokenizeNs=total // 5, constructNs=total // 2,
                         walkAndReleaseNs=total * 3 // 10, releaseNs=total // 10,
                         peakHeapSlotBytes=8192, allocatedHeapSlotBytes=8192 * count,
                         finalLiveBytes=0, regionBlocks=0, regionRequestedBytes=0,
                         regionRoundedBytes=0, regionUnusedBytes=0, regionPayloadBytes=0, heapAllocations=100 * count)
            if label.startswith('baseline'):
                value['releaseNs'] = None
            if label == 'candidate-profile':
                value.update(regionBlocks=2 * count, regionRequestedBytes=768 * count,
                             regionRoundedBytes=768 * count, regionUnusedBytes=104 * count,
                             regionPayloadBytes=720 * count)
            if label in ['c', 'rust']:
                value.update(nodeSize=24, nodeCapacityBytes=768, tokenCapacityBytes=512, allocations=6)
            return value

        self.row = dict(nodes=31, depth=5, result=-8, rounds=32768,
                        control=[], samples=[], profiles={})
        for label in ['baseline-profile', 'candidate-profile', 'c', 'rust']:
            self.row['profiles'][label] = [sample(label, n) for n in [1, 16, 256]]
        for index in range(6):
            for key, order in [('control', ['baseline', 'baseline-copy']),
                               ('samples', ['baseline', 'candidate', 'c', 'rust'])]:
                self.row[key].append({label: sample(label, 32768) for label in
                                      (order if index % 2 == 0 else order[::-1])})
        noise = abs(1.02 - 1)
        self.row.update(controlEnvelope=noise, allowedCandidateRatio=1 + 2 * noise,
                        ratios=dict(baseline=0.6, c=2.0, rust=1.5))

    def test_complete_record(self):
        self.assertEqual(READER.check_case('small', self.row, self.settings), [])

    def test_missing_sample_or_peer(self):
        for key in ['control', 'samples']:
            row = copy.deepcopy(self.row); row[key].pop()
            with self.assertRaises(AssertionError):
                READER.check_case('small', row, self.settings)
        del self.row['samples'][0]['rust']
        with self.assertRaises(AssertionError):
            READER.check_case('small', self.row, self.settings)

    def test_changed_budget_or_hidden_regression(self):
        self.row['allowedCandidateRatio'] += 0.2
        with self.assertRaises(AssertionError):
            READER.check_case('small', self.row, self.settings)
        self.setUp()
        for pair in self.row['samples']:
            candidate = pair['candidate']
            for key in ['totalNs', 'tokenizeNs', 'constructNs', 'walkAndReleaseNs', 'releaseNs']:
                candidate[key] *= 2
        self.row['ratios'] = dict(baseline=1.2, c=4.0, rust=3.0)
        self.assertEqual(READER.check_case('small', self.row, self.settings),
                         ['small: candidate exceeds the frozen timing budget'])

    def test_rejected_noise_keeps_candidate_absent(self):
        row = copy.deepcopy(self.row)
        value = row['control'][0]['baseline-copy']
        for key in ['totalNs', 'tokenizeNs', 'constructNs', 'walkAndReleaseNs']:
            value[key] *= 2
        noise = abs(2.04 - 1)
        row.update(controlEnvelope=noise, allowedCandidateRatio=1 + 2 * noise, samples=[])
        del row['ratios']
        self.assertEqual(READER.check_case('small', row, self.settings),
                         ['small: unstable identical-code timing control'])
        row['samples'] = self.row['samples']
        with self.assertRaises(AssertionError):
            READER.check_case('small', row, self.settings)

    def test_wrong_value_leak_or_inconsistent_phase(self):
        for field in ['result', 'finalLiveBytes', 'tokenizeNs']:
            row = copy.deepcopy(self.row); row['samples'][0]['candidate'][field] += 1
            with self.assertRaises(AssertionError):
                READER.check_case('small', row, self.settings)

    def test_block_rounding_and_unused_bytes(self):
        for field in ['regionPayloadBytes', 'regionRequestedBytes', 'regionRoundedBytes', 'regionUnusedBytes']:
            row = copy.deepcopy(self.row)
            row['profiles']['candidate-profile'][1][field] = 0
            with self.assertRaises(AssertionError):
                READER.check_case('small', row, self.settings)

    def test_retained_growth(self):
        row = copy.deepcopy(self.row)
        row['profiles']['candidate-profile'][2]['peakHeapSlotBytes'] += 4096
        with self.assertRaises(AssertionError):
            READER.check_case('small', row, self.settings)

    def test_compiler_scale_requires_real_exported_roots(self):
        code = b'/* job0 : String -> I64 */\n/* job1 : String -> I64 */\nfwp_region region = {0};'
        row = dict(emittedBytes=len(code), sha256=hashlib.sha256(code).hexdigest(),
                   selectedEntries=1, samples=[dict(seconds=0.1, maxRssKiB=1000)] * 3)
        READER.check_compilation('2', 'candidate', row, code)
        for broken in [b'int main(void) {}', code.replace(b'job1', b'missing')]:
            matching = dict(row, emittedBytes=len(broken), sha256=hashlib.sha256(broken).hexdigest())
            with self.assertRaises(AssertionError):
                READER.check_compilation('2', 'candidate', matching, broken)
        no_regions = code.replace(b'fwp_region region = {0};', b'')
        matching = dict(row, emittedBytes=len(no_regions), sha256=hashlib.sha256(no_regions).hexdigest(), selectedEntries=0)
        READER.check_compilation('2', 'baseline', matching, no_regions)
        with self.assertRaises(AssertionError):
            READER.check_compilation('2', 'candidate', matching, no_regions)

    def test_input_shapes_and_independent_oracle(self):
        for depth, left, expected_nodes in [(5, False, 31), (9, False, 511), (13, False, 8191), (64, True, 127)]:
            text, nodes, expected = MEASURE.input_case(depth, left)
            tokens = text.split()
            self.assertEqual(nodes, expected_nodes)
            self.assertEqual(len(tokens), nodes)
            self.assertEqual(tokens.count('+'), (nodes - 1) // 2)
            self.assertEqual(sum(int(t) for t in tokens if t != '+'), expected)

    def test_missing_or_ambiguous_phase_boundary_is_rejected(self):
        code = '''typedef uint64_t V;
/* calculate : String -> I64 */
static int64_t w0(V l0) {
    V t1 = f1(l0);
    fwp_wr2 t2 = w2(l1);
    return t2.f0;
}
static V f0(V l0) { V r = (V)(int64_t)(w0(l0)); return r; }
/* words : String -> List[String] */
static V f1(V l0) {
    return l0;
}
int main(void) {}
'''
        emitted = MEASURE.instrument(code, False, False)
        self.assertIn('uint64_t token_start', emitted)
        self.assertIn('uint64_t construct_start', emitted)
        self.assertNotIn('@', emitted)
        for broken in [code.replace('static V f0(', 'static V f4('), code.replace('f1(l0)', 'f3(l0)'),
                       code.replace('    V t1 = f1(l0);', '    V t1 = f1(l0);\n    V t3 = f1(l0);')]:
            with self.assertRaises(AssertionError):
                MEASURE.instrument(broken, False, False)


if __name__ == '__main__':
    unittest.main()
