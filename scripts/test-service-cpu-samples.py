#!/usr/bin/env python3
"""Keep unresolved service work, source IDs and independent operation accounting."""
import unittest

from cpu_samples import stacks, unknown_frame
from service_cpu_samples import attribute, fwp_functions, source_name


class ServiceSamplesTests(unittest.TestCase):
    def test_phase_and_operation_are_independent_and_keep_unknown_samples(self):
        text = ('2000 cpu-clock:u:\n 12 malloc (libc)\n 13 f1 (program)\n 14 service_run (program)\n\n'
                '1000 cpu-clock:u:\n 15 free (libc)\n 16 f2 (program)\n 14 service_run (program)\n\n'
                '500 cpu-clock:u:\n 17 [unknown] ([unknown])\n\n'
                '250 cpu-clock:u:\n')
        report = attribute(stacks(text),[dict(samples=4,period=3750)],peer='fwp',functions=['service','pending','dispatch'])
        self.assertEqual(report['serviceSamples'],2)
        self.assertEqual(report['samplesWithUnknownFrames'],1)
        self.assertEqual(report['samplesWithoutFrames'],1)
        self.assertEqual([(r['phase'],r['operation']) for r in report['rows']],
                         [('construction','allocation'),('dispatch','release'),
                          ('caller/runtime/unresolved','remaining operation'),('caller/runtime/unresolved','unavailable')])
        self.assertEqual(sum(row['period'] for row in report['rows']),3750)

    def test_anonymous_inlined_work_does_not_invent_a_phase(self):
        text = '1000 cpu-clock:u:\n 12 f1 (program)\n 14 service_run (program)\n'
        report = attribute(stacks(text),[dict(samples=1,period=1000)],peer='fwp',functions=['service','fn'])
        self.assertEqual(report['rows'][0]['phase'],'remaining service')
        for flat in ([dict(samples=2,period=1000)],[dict(samples=1,period=999)]):
            with self.assertRaises(AssertionError):
                attribute(stacks(text),flat,peer='fwp',functions=['service','fn'])
        with self.assertRaisesRegex(AssertionError,'no resolved service'):
            attribute(stacks(text.replace('service_run','caller')), [dict(samples=1,period=1000)],peer='fwp',functions=['service','fn'])

    def test_hexadecimal_function_names_are_not_unresolved_addresses(self):
        self.assertFalse(unknown_frame(dict(ip='123',symbol='f1')))
        self.assertFalse(unknown_frame(dict(ip='123',symbol='add')))
        self.assertTrue(unknown_frame(dict(ip='123',symbol='123')))
        self.assertTrue(unknown_frame(dict(ip='123',symbol='0x456')))
        self.assertTrue(unknown_frame(dict(ip='123',symbol='[unknown]')))

    def test_function_identity_comes_from_the_emitted_table(self):
        source = ('static const fwp_fninfo fwp_fn_table[] = {\n'
                  '    {1, e0, "service", &fwp_owned_info0},\n'
                  '    {2, 0, "pending", 0},\n};')
        names = fwp_functions(source)
        self.assertEqual(source_name('w1.constprop.0',names),'pending')
        self.assertEqual(source_name('fwp_owned_entry0',names),'service')
        self.assertIsNone(source_name('unrelated1',names))
        for invalid in ('',source+source,source.replace('"service"','"other"'),source.replace('{2, 0','{x, 0')):
            with self.assertRaises(AssertionError):
                fwp_functions(invalid)
        with self.assertRaises(AssertionError):
            source_name('f2',names)

    def test_peer_dispatch_requires_its_actual_service_parent(self):
        for peer, entry, callback in (
            ('c','service_run','callback'),
            ('rs','weak_callback_service[abcd]::service_run','weak_callback_service[abcd]::callback'),
            ('swift','WeakCallbackService.serviceRun(Swift.Int, Swift.Int) -> WeakCallbackService.Stats',
             'WeakCallbackService.callback(WeakCallbackService.Target, [Swift.Int64]) -> ()')):
            text = f'1000 cpu-clock:u:\n 12 {callback} (program)\n 14 {entry} (program)\n'
            report = attribute(stacks(text),[dict(samples=1,period=1000)],peer=peer,functions=None)
            self.assertEqual(report['rows'][0]['phase'],'dispatch')


if __name__ == '__main__':
    unittest.main()
