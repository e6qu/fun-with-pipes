"""Require actual reuse where possible and retained Rc backing storage otherwise."""
import json
import unittest

from weak_operation_reuse import decode_output


class ReuseEvidence(unittest.TestCase):
    def test_native_representations_have_different_reuse_rules(self):
        for language, reused in (('c', 1), ('swift', 1024), ('rs', 0)):
            row = dict(rounds=1024, reused=reused, expired=1024, replacementLive=1024)
            self.assertEqual(decode_output(json.dumps(row, separators=(',', ':')) + '\n', language), row)

    def test_unobserved_reuse_and_wrong_lifetimes_fail(self):
        for language in ('c', 'rs', 'swift'):
            valid = dict(rounds=1024, reused=0 if language == 'rs' else 512, expired=1024, replacementLive=1024)
            for changes in ({'reused': 1 if language == 'rs' else 0}, {'reused': -1}, {'reused': 1025},
                            {'reused': True}, {'rounds': 0}, {'expired': 1023}, {'replacementLive': 0}, {'extra': 0}):
                with self.subTest(language=language, changes=changes), self.assertRaises(AssertionError):
                    decode_output(json.dumps(valid | changes, separators=(',', ':')) + '\n', language)

    def test_malformed_and_duplicate_fields_fail(self):
        for text in ('null\n', '[1024,0,1024,1024]\n',
                     '{"rounds":1024,"reused":12,"reused":0,"expired":1024,"replacementLive":1024}\n'):
            with self.subTest(text=text), self.assertRaises(AssertionError):
                decode_output(text, 'rs')


if __name__ == '__main__':
    unittest.main()
