#!/usr/bin/env python3
"""Exercise attribution scope, malformed counts and actual-control generation."""
import copy
import json
import unittest

from resource_frame_counts import PREFIX, decode, instrument

ROW = dict(function=2, context=8, variable='t4', node='t5', variants=0,
           fields=[dict(slot=0, observable=False, type='Array[I64]')])
SOURCE = '''typedef uint64_t V;
static void counters(void) { observed_retains++; observed_decrements++; }
static const fn functions[] = {{1, e2, "worker"}};
static void fwp_owner_release8(void *arg) { fwp_owner_ctx8 *c = arg; drop_array(c->v0); }
static V worker(V x) {
    fwp_owner_ctx8 t4 = {0}; fwp_cleanup t5; fwp_cleanup_push(&t5, fwp_owner_release8, &t4);
    fwp_rc_dup(x); t4.v0 = x;
    fwp_cleanup_pop(&t5);
    fwp_cleanup_push(&t5, fwp_owner_release8, &t4);
    /* original resource frame */ fwp_cleanup_pop(&t5); fwp_owner_release8(&t4);
    return x;
}
static V other(V x) {
    fwp_rc_dup(x); t4.v0 = x;
    return x;
}
static void *fwp_main_thread(void *arg) {
    return 0;
}
'''


class Frames(unittest.TestCase):
    def test_scope_and_real_owner_control(self):
        for extra in (False, True):
            code, selected = instrument(SOURCE, [ROW], extra)
            self.assertIn('static V other(V x) {\n    fwp_rc_dup(x); t4.v0 = x;', code)
            self.assertEqual(code.count('resource_work_frames[0][0]++;'), 2)
            self.assertEqual(code.count('resource_work_frames[0][1]++;'), 2)
            self.assertEqual(code.count('resource_work_frames[0][2]++;'), 1)
            self.assertEqual(selected['fields'][0]['sites'], 1)
            self.assertEqual('resource_work_extra = 1;' in code, extra)
            with self.assertRaises(AssertionError):
                instrument(code, [ROW])

    def test_reject_ordinary_context_and_changed_hold(self):
        for marker in ('/* original resource frame */ ', 'fwp_rc_dup(x); ',
                       'fwp_cleanup_pop(&t5);', '{1, e2, "worker"}'):
            with self.subTest(marker=marker), self.assertRaises((AssertionError, ValueError)):
                instrument(SOURCE.replace(marker, ''), [ROW])

    def test_only_direct_callable_types_are_dereferenced(self):
        for ty, expected in (('Fun(I64, I64)', True), ('Record([Fun(I64, I64)])', False)):
            row = copy.deepcopy(ROW)
            row['fields'][0].update(type=ty, observable=True)
            code, selected = instrument(SOURCE, [row])
            self.assertEqual(selected['fields'][0]['callable'], expected)
            self.assertEqual('CLO(work_value)->fn' in code, expected)

    def test_reject_incomplete_duplicate_or_invalid_dynamic_observations(self):
        _, selected = instrument(SOURCE, [ROW])
        good = dict(frames=[[2, 2, 1]], fields=[[1, 1, 1, 1]], closures=[[2, 1, 0, 1]])
        self.assertEqual(decode(PREFIX + json.dumps(good), selected), good)
        for bad in (good | {'fields': []}, good | {'frames': [[True, 2, 1]]},
                    good | {'fields': [[1, 2, 1, 1]]}, good | {'closures': [[3, 1, 0, 1]]},
                    good | {'closures': good['closures'] * 2}, good | {'closures': [[2, 1, 0, 2]]}):
            with self.subTest(bad=bad), self.assertRaises(AssertionError):
                decode(PREFIX + json.dumps(bad), selected)


if __name__ == '__main__':
    unittest.main()
