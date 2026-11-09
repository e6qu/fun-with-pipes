"""Reject missing release observations without assuming empty arrays allocate."""
import unittest

from returned_buffer_profiles import allocation_kind, check_release


class ReleaseEvidence(unittest.TestCase):
    def test_native_names_and_type_metadata_remain_distinct(self):
        rust = 'main;_RNvCsdbtMNeSi43d_15returned_buffer4make (factory.rs);allocate (alloc.rs);'
        self.assertEqual(allocation_kind(rust, 'rs'), 'storage')
        self.assertEqual(allocation_kind(rust.replace('4make', '4scan'), 'rs'), 'outside')
        self.assertEqual(allocation_kind('main;returned_buffer_make (factory.c);malloc;', 'c'), 'storage')
        prefix = 'main;$s14ReturnedBuffer10bufferMakeySays5Int64VGADF (factory.swift);'
        storage = prefix + '$ss22_ContiguousArrayBufferV20_consumeAndCreateNew;swift_allocObject;swift_slowAlloc;'
        metadata = prefix + '__swift_instantiateConcreteTypeFromMangledName;swift_getTypeByMangledName;allocate;'
        self.assertEqual(allocation_kind(storage, 'swift'), 'storage')
        self.assertEqual(allocation_kind(metadata, 'swift'), 'metadata')
        self.assertEqual(allocation_kind('main;swift_allocObject;swift_slowAlloc;', 'swift'), 'outside')
        with self.assertRaises(AssertionError):
            allocation_kind(prefix + 'unknown_allocation;', 'swift')

    def test_native_storage_and_actual_omission(self):
        ordinary = dict(allocations=65536, peak=524288, leaked=0)
        omitted = dict(allocations=65536, peak=8388608, leaked=8388608)
        check_release(ordinary, omitted, 16, 4096, 16)
        for before, after in (
            (dict(ordinary, leaked=1), omitted),
            (dict(ordinary, allocations=0), dict(omitted, allocations=0)),
            (ordinary, dict(omitted, allocations=65535)),
            (ordinary, dict(omitted, leaked=0)),
            (ordinary, dict(omitted, leaked=8388607)),
            (ordinary, dict(omitted, peak=-1)),
            (ordinary, dict(omitted, leaked=True)),
            (ordinary, dict(omitted, extra=0)),
        ):
            with self.subTest(before=before, after=after), self.assertRaises(AssertionError):
                check_release(before, after, 16, 4096, 16)

    def test_empty_storage_is_observed_not_invented(self):
        zero = dict(allocations=0, peak=0, leaked=0)
        check_release(zero, zero, 0, 4096, 16)
        before = dict(allocations=65536, peak=32768, leaked=0)
        after = dict(allocations=65536, peak=524288, leaked=524288)
        check_release(before, after, 0, 4096, 16)
        for ordinary, omitted in ((zero, after), (before, before), (zero, dict(zero, leaked=1))):
            with self.assertRaises(AssertionError):
                check_release(ordinary, omitted, 0, 4096, 16)


if __name__ == '__main__':
    unittest.main()
