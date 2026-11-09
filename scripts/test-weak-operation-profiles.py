"""Check attribution boundaries and reject missing or contradictory release data."""
import copy
import unittest

from weak_operation_profiles import allocation_kind, check_stages, decode_output


def observations(language):
    rows = []
    for stage in range(4):
        keep_target = stage < 2 or (language == 'rs' and stage == 2)
        rows.append(dict(target=dict(allocations=64, peak=1536, leaked=1536 if keep_target else 0),
                         weak=dict(allocations=64 if language != 'rs' and stage else 0,
                                   peak=2048 if language != 'rs' and stage else 0,
                                   leaked=2048 if language != 'rs' and stage in (1, 2) else 0),
                         **{'type-metadata': dict(allocations=0, peak=0, leaked=0)}))
    return rows


class StorageEvidence(unittest.TestCase):
    def test_value_and_backing_storage_have_different_lifetimes(self):
        for language in ('c', 'rs', 'swift'):
            check_stages(observations(language), language, 64)
        with self.assertRaises(AssertionError):
            check_stages(observations('rs'), 'swift', 64)
        with self.assertRaises(AssertionError):
            check_stages(observations('c'), 'rs', 64)

    def test_missing_doubled_and_unreleased_events_fail(self):
        for language in ('c', 'rs', 'swift'):
            good = observations(language)
            for stage, group, key, value in (
                (0, 'target', 'allocations', 0), (1, 'target', 'allocations', 128),
                (3, 'target', 'leaked', 24), (2, 'target', 'leaked', 1),
                (3, 'weak', 'leaked', 32), (0, 'weak', 'allocations', 1),
                (0, 'target', 'leaked', True), (0, 'target', 'peak', -1),
                (2, 'type-metadata', 'leaked', 1), (0, 'target', 'extra', 0),
            ):
                changed = copy.deepcopy(good)
                changed[stage][group][key] = value
                with self.subTest(language=language, stage=stage, group=group, key=key), self.assertRaises(AssertionError):
                    check_stages(changed, language, 64)

    def test_actual_factory_names_and_unrelated_runtime_frames(self):
        self.assertEqual(allocation_kind('main;reference_make (factory.c);malloc;', 'c'), 'target')
        self.assertEqual(allocation_kind('main;reference_downgrade (factory.c);malloc;', 'c'), 'weak')
        self.assertEqual(allocation_kind('main;_RNvCs123abc_14weak_operation4make (factory.rs);alloc;', 'rs'), 'target')
        self.assertEqual(allocation_kind('main;_RNvCs123abc_14weak_operation9downgrade (factory.rs);alloc;', 'rs'), 'weak')
        target = 'main;$s13WeakOperation13referenceMake (factory.swift);swift_allocObject;swift_slowAlloc;'
        weak = 'main;$s13WeakOperation18referenceDowngrade (factory.swift);swift_weakInit;malloc;'
        metadata = 'main;$s13WeakOperation13referenceMake;swift_getSingletonMetadata;malloc;'
        self.assertEqual(allocation_kind(target, 'swift'), 'target')
        self.assertEqual(allocation_kind(weak, 'swift'), 'weak')
        self.assertEqual(allocation_kind(metadata, 'swift'), 'type-metadata')
        for language in ('c', 'rs', 'swift'):
            self.assertEqual(allocation_kind('main;swift_allocObject;malloc;', language), 'outside')
        with self.assertRaises(AssertionError):
            allocation_kind('main;$s13WeakOperation13referenceMake;unrecognized;', 'swift')
        with self.assertRaises(AssertionError):
            allocation_kind('main;$s13WeakOperation18referenceDowngrade;unrecognized;', 'swift')

    def test_result_oracle_rejects_wrong_live_expired_and_field_types(self):
        decode_output('{"population":64,"stage":2,"live":64,"expired":0}\n', 64, 2)
        for text in ('{"population":64,"stage":2,"live":0,"expired":64}\n',
                     '{"population":64,"stage":2,"live":64,"expired":false}\n',
                     '{"population":64,"stage":2,"live":0,"live":64,"expired":0}\n',
                     '{"population":64,"stage":2,"live":64,"expired":0,"extra":0}\n',
                     'null\n'):
            with self.subTest(text=text), self.assertRaises(AssertionError):
                decode_output(text, 64, 2)


if __name__ == '__main__':
    unittest.main()
