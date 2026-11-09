"""Validate observed addresses and build an actual replacement-link fault control."""
import json

from weak_operation_source import once


def rebound_source(source, language):
    assert language in ('c', 'rs', 'swift')
    if language == 'c':
        return once(source, '        int revived = reference_lookup(weak);',
                    '        ReferenceWeak rebound = reference_downgrade(replacement);\n'
                    '        int revived = reference_lookup(rebound);\n'
                    '        reference_release_weak(rebound);')
    if language == 'rs':
        return once(source, '        let revived = lookup(&weak);',
                    '        let rebound = downgrade(&replacement);\n'
                    '        let revived = lookup(&rebound);\n'
                    '        release_weak(rebound);')
    return once(source, '        let revived = referenceLookup(weak)',
                '        let rebound = referenceDowngrade(replacement)\n'
                '        let revived = referenceLookup(rebound)\n'
                '        referenceReleaseWeak(consume rebound)')


def decode_output(text, language):
    assert language in ('c', 'rs', 'swift')
    row = json.loads(text)
    assert isinstance(row, dict) and set(row) == {'rounds', 'reused', 'expired', 'replacementLive'}
    assert all(type(value) is int for value in row.values())
    assert text == json.dumps(row, separators=(',', ':')) + '\n'
    assert row['rounds'] == row['expired'] == row['replacementLive'] == 1024
    if language == 'rs':
        assert row['reused'] == 0, 'Rust reused backing storage still held by Weak'
    else:
        assert 1 <= row['reused'] <= 1024, 'no actual target address reuse was observed'
    return row
