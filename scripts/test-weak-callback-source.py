#!/usr/bin/env python3
"""Check that the native caller follows emitted field types and ordering."""
import unittest

from weak_callback_service import expected
from weak_callback_source import boundary


def emitted(names):
    fields = ', '.join('"' + name + '"' for name in names)
    types = ', '.join(['&d2'] * len(names))
    return f'''static const fwp_desc d2 = {{K_I64, "I64", .width = 0, .dup = NULL, .drop = NULL}};
static const char *const d1_n[] = {{{fields}}};
static const fwp_desc *const d1_f[] = {{{types}}};
static const int d1_o[] = {{5, 4, 0, 1, 3, 2, 8, 6, 9, 7}};
static const fwp_desc d1 = {{K_RECORD, "ServiceResult", 10, d1_n, d1_f, .width = 0, .order = d1_o, .dup = fwp_rc_dup, .drop = fwp_drop23}};
static V fwp_owned_entry8(V *a) {{ return 0; }}
{{1, e8, "service", &fwp_owned_info8}}
static void *fwp_main_thread(void *arg) {{
    fwp_exit_code = fwp_exec(&exec_spec0, fwp_argc, fwp_argv);
}}
'''


class Boundary(unittest.TestCase):
    def test_fields_follow_descriptor(self):
        names = list(reversed(sorted(expected(64, 0))))
        result = boundary(emitted(names))
        self.assertIn('fwp_owned_entry8(&argument)', result)
        for name in ('population', 'mode'):
            self.assertIn('OBJ(output)->f[' + str(names.index(name)) + ']', result)
        fields = ', '.join('(int64_t)OBJ(output)->f[' + str(names.index(name)) + ']'
                           for name in ('calls', 'cancelled', 'expired', 'errors', 'sent', 'received', 'sum', 'received_sum'))
        self.assertIn('ServiceStats result = {' + fields + '};', result)
        self.assertIn('fwp_rc_free_obj(output);', result)
        self.assertIn('fwp_heap.live != baseline', result)

    def test_unsafe_or_ambiguous_shapes_rejected(self):
        source = emitted(sorted(expected(64, 0)))
        for changed in (source.replace('K_I64', 'K_STR'), source.replace('K_RECORD', 'K_ARRAY'), source.replace('"service"', '"different"'),
                        source.replace('"received_sum"', '"unknown"'), source.replace('&d2,', '&d3,', 1),
                        source.replace('.dup = NULL', '.dup = fwp_rc_dup'),
                        source.replace('.drop = NULL', '.drop = fwp_drop23'),
                        source.replace('"ServiceResult"', '"OtherRecord"'),
                        source.replace('.width = 0, .order', '.width = 1, .order'),
                        source + emitted(sorted(expected(64, 0)))):
            with self.subTest(changed=changed), self.assertRaises(ValueError):
                boundary(changed)


if __name__ == '__main__':
    unittest.main()
