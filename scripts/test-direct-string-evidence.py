#!/usr/bin/env python3
"""Check exact source pairing, raw-buffer observers and fixed acceptance rules."""
import argparse
import copy
import importlib.util
import json
from pathlib import Path
import subprocess
import tempfile
import unittest

SPEC = importlib.util.spec_from_file_location('direct_strings', Path(__file__).with_name('direct-string-evidence.py'))
CHECK = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(CHECK)
ROOT = Path(__file__).resolve().parent.parent
RUNTIME = (ROOT / 'runtime/fwp_rt_prims.c').read_text()
FROZEN = json.loads((ROOT / 'tests/fixtures/direct-string-reference.json').read_text())
CC = None


class Evidence(unittest.TestCase):
    def test_reference_changes_only_the_declared_bodies(self):
        source = '/* prefix */\n' + RUNTIME + '\n/* suffix */\n'
        reference, patch = CHECK.reference_source(source, RUNTIME, FROZEN)
        restored = reference
        for change in patch['changes']:
            restored = restored.replace(change['reference'], change['candidate'])
        self.assertEqual(restored, source)
        self.assertIn('/* prefix */', reference)
        self.assertEqual(patch['source'], CHECK.REFERENCE)
        with self.assertRaises(AssertionError):
            CHECK.reference_source(source.replace('size_t count = 0;', 'size_t count = 1;'), RUNTIME, FROZEN)
        with self.assertRaises(AssertionError):
            CHECK.reference_source(source + CHECK.function(source, CHECK.NAMES[0]), RUNTIME, FROZEN)

    def test_missing_round_and_unstable_copy_are_rejected(self):
        paired = {key: [1000] * 16 for key in ['reference', 'reference-copy', 'candidate', 'candidate-copy']}
        context = {key: [1000] * 16 for key in ['c', 'rust', 'candidate', 'candidate-copy']}
        for key in ['candidate', 'candidate-copy']:
            paired[key] = [900] * 16
        self.assertTrue(CHECK.timing_decision('65536:1024', paired, context)['speedClaim'])
        damaged = copy.deepcopy(paired)
        damaged['reference-copy'] = [1020] * 16
        result = CHECK.timing_decision('65536:1024', damaged, context)
        self.assertFalse(result['speedClaim'])
        self.assertIn('paired-reference', result['failures'][0])
        damaged['reference-copy'].pop()
        with self.assertRaises(AssertionError):
            CHECK.timing_decision('65536:1024', damaged, context)

    def test_small_speed_does_not_hide_large_failure(self):
        paired = {key: [1000] * 16 for key in ['reference', 'reference-copy', 'candidate', 'candidate-copy']}
        context = {key: [1000] * 16 for key in ['c', 'rust', 'candidate', 'candidate-copy']}
        for key in ['candidate', 'candidate-copy']:
            paired[key] = [960] * 16
        self.assertEqual(CHECK.timing_decision('4096:64', paired, context)['failures'], [])
        self.assertFalse(CHECK.timing_decision('4096:64', paired, context)['speedClaim'])
        self.assertTrue(CHECK.timing_decision('65536:1024', paired, context)['failures'])

    def test_live_or_unobserved_raw_storage_cannot_pass(self):
        managed = CHECK.MANAGED['4096:64']
        raw = dict(rawRequests=1640, rawRequestedBytes=104960, rawPeakBytes=64,
                   rawFinalBytes=0, replaceCalls=8192, repeatCalls=0)
        self.assertEqual(CHECK.profile_failures('4096:64', 'reference', managed, raw), [])
        self.assertTrue(CHECK.profile_failures('4096:64', 'candidate', managed, raw))
        for key in raw:
            damaged = dict(raw)
            damaged[key] += 1
            self.assertTrue(CHECK.profile_failures('4096:64', 'reference', managed, damaged), key)
        for key in managed:
            damaged = dict(managed)
            damaged[key] += 1
            self.assertTrue(CHECK.profile_failures('4096:64', 'reference', damaged, raw), key)

    def test_code_and_stack_costs_are_not_hidden_by_allocation_savings(self):
        section = '.text 1000 0\n.rodata 100 0\n'
        stack = 'a.c:1:1:f\t16\tstatic\na.c:2:1:g\t512\tstatic\n'
        result = CHECK.representation_decision(section, section, stack, stack)
        self.assertEqual(result['failures'], [])
        result = CHECK.representation_decision(section, '.text 5097 0\n.rodata 1125 0\n',
            stack, 'a.c:1:1:f\t273\tstatic\na.c:2:1:g\t513\tstatic\na.c:3:1:h\t16\tdynamic\n')
        self.assertEqual(len(result['failures']), 5)
        self.assertEqual(len(result['frameChanges']), 3)

    def test_malformed_size_reports_are_rejected(self):
        section = '.text 1000 0\n.rodata 100 0\n'
        stack = 'a.c:1:1:f\t16\tstatic\n'
        self.assertEqual(CHECK.representation_decision(
            section + '.note.gnu.build-id 36 652\n',
            section + '.note.gnu.build-id 36 652\n', stack, stack)['failures'], [])
        for invalid in ['a.c:1:1:f\t-1\tstatic\n', 'a.c:1:1:f\t16\tunknown\n',
                        'a.c:f\t16\tstatic\n', stack + stack]:
            with self.subTest(stack=invalid), self.assertRaises(AssertionError):
                CHECK.representation_decision(section, section, stack, invalid)
        for invalid in ['.text 1000 0\n.rodata -1 0\n', section + '.text 1 0\n']:
            with self.subTest(section=invalid), self.assertRaises(AssertionError):
                CHECK.representation_decision(section, invalid, stack, stack)

    def test_compiled_raw_observer_detects_growth_free_and_scope(self):
        header = r'''
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
typedef uintptr_t V;
typedef struct { size_t len; char d[]; } fwp_str;
#define STR(v) ((fwp_str *)(uintptr_t)(v))
#define PTR(v) ((V)(uintptr_t)(v))
static int iteration_active;
static void fwp_trap(const char *message) { fputs(message, stderr); exit(125); }
static void *fwp_alloc_leaf(size_t n) { void *p=malloc(n); assert(p); return p; }
static V fwp_str_new(const char *s, size_t n) {
    fwp_str *r=fwp_alloc_leaf(sizeof(*r)+n+1);
    r->len=n; memcpy(r->d,s,n); r->d[n]=0; return PTR(r);
}
static size_t fwp_count_arg(V n) { return (size_t)n; }
static const char *fwp_memmem(const char *s,size_t n,const char *p,size_t k) {
    if(k>n)return NULL;
    for(size_t i=0;i<=n-k;i++)if(!memcmp(s+i,p,k))return s+i;
    return NULL;
}
'''
        ops = (ROOT / 'runtime/fwp_rt_ops.c').read_text()
        buffers = ops[ops.index('typedef struct { char *d;'):ops.index('/* ------------------------------------------------------------------ floats */')]
        main = r'''
int main(void) {
    V s=fwp_str_new("a",1), from=fwp_str_new("a",1), to=fwp_str_new("b",1);
    V ignored=fwp_p_str_repeat(3,s); free(STR(ignored));
    iteration_active=1;
    V repeated=fwp_p_str_repeat(130,s);
    assert(STR(repeated)->len==130 && STR(repeated)->d[129]=='a');
    V replaced=fwp_p_replace(from,to,s);
    assert(STR(replaced)->len==1 && STR(replaced)->d[0]=='b');
    free(STR(repeated)); free(STR(replaced));
    iteration_active=0;
    fwp_buf unrelated={0}; buf_puts(&unrelated,"unmeasured");
    V value=buf_to_str(&unrelated); free(STR(value));
    free(STR(s));free(STR(from));free(STR(to));
    /* Ownership observation point: before runtime teardown. */
    return 0;
}
'''
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            for label, bodies in [('reference', FROZEN['functions']),
                                  ('candidate', {name: CHECK.function(RUNTIME, name) for name in CHECK.NAMES})]:
                code = CHECK.instrument_raw(header + buffers + '\n'.join(bodies.values()) + main)
                for broken in [False, True]:
                    if broken:
                        code = CHECK.replace_once(code, 'if (direct_scope) direct_live -= b->cap;', '(void)0;')
                    source, binary = root / 'probe.c', root / 'probe'
                    source.write_text(code)
                    compiled = subprocess.run([CC, '-O2', '-std=c11', '-Wall', '-Wextra', '-Werror',
                        '-Wno-unused-function', source, '-o', binary], capture_output=True, timeout=30)
                    self.assertEqual((compiled.returncode, compiled.stdout, compiled.stderr), (0, b'', b''))
                    result = subprocess.run([binary], capture_output=True, timeout=10)
                    self.assertEqual((result.returncode, result.stdout), (0, b''))
                    raw = json.loads(result.stderr)
                    self.assertEqual((raw['replaceCalls'], raw['repeatCalls']), (1, 1))
                    if label == 'candidate':
                        self.assertEqual([raw[key] for key in ['rawRequests','rawRequestedBytes','rawPeakBytes','rawFinalBytes']], [0,0,0,0])
                    else:
                        self.assertEqual((raw['rawRequests'], raw['rawRequestedBytes']), (4,512))
                        self.assertEqual(raw['rawFinalBytes'], 320 if broken else 0)
                        self.assertEqual(raw['rawPeakBytes'], 320 if broken else 256)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--cc', required=True)
    args = parser.parse_args()
    CC = args.cc
    unittest.main(argv=['test-direct-string-evidence.py'])
