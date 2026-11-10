"""Describe original lifetime holders without changing the C they emit."""
import json
import re

from weak_callback_service import replace_once, unique_fields

PREFIX = 'FWP_RESOURCE_FIELDS '
MARKER = '        assert!(!protection.is_empty(), "empty original resource region");'
OBSERVER = r'''
        let observed_fields: Vec<_> = entries.iter().enumerate().map(|(slot, (_, ty))| {
            let mut name = String::new();
            crate::json::escape(&format!("{ty:?}"), &mut name);
            format!("{{\"slot\":{slot},\"observable\":{},\"type\":{name}}}", self.g.resource_type(ty))
        }).collect();
        eprintln!("FWP_RESOURCE_FIELDS {{\"function\":{},\"context\":{id},\"variable\":\"{ctx}\",\"node\":\"{node}\",\"variants\":{},\"fields\":[{}]}}",
            self.me, variants.len(), observed_fields.join(","));
'''


def instrument(source):
    assert PREFIX not in source
    return replace_once(source, MARKER, MARKER + OBSERVER)


def decode(stderr):
    rows = []
    contexts = set()
    for line in stderr.splitlines():
        assert line.startswith(PREFIX), line
        row = json.loads(line[len(PREFIX):], object_pairs_hook=unique_fields)
        assert set(row) == {'function', 'context', 'variable', 'node', 'variants', 'fields'}
        for key in ('function', 'context', 'variants'):
            assert type(row[key]) is int and row[key] >= 0
        assert row['context'] not in contexts, 'repeated cleanup context'
        contexts.add(row['context'])
        for key in ('variable', 'node'):
            assert isinstance(row[key], str) and re.fullmatch(r't[0-9]+', row[key])
        assert type(row['fields']) is list
        assert row['fields'] or row['variants'] > 0
        for slot, field in enumerate(row['fields']):
            assert set(field) == {'slot', 'observable', 'type'}
            assert type(field['slot']) is int and field['slot'] == slot
            assert type(field['observable']) is bool
            assert isinstance(field['type'], str) and field['type']
        rows.append(row)
    return rows


def validate_contexts(source, rows):
    """Reject ordinary cleanup records mislabeled as original lifetime holders."""
    for row in rows:
        context, variable, node = row['context'], row['variable'], row['node']
        declaration = f'fwp_owner_ctx{context} {variable} = '
        release = f'static void fwp_owner_release{context}(void *arg) '
        original = (f'/* original resource frame */ fwp_cleanup_pop(&{node}); '
                    f'fwp_owner_release{context}(&{variable});')
        assert source.count(declaration) == 1, ('context declaration', context)
        assert source.count(release) == 1, ('release definition', context)
        assert original in source, ('not an original resource frame', context)
    return {
        'frames': len(rows),
        'fields': sum(len(row['fields']) for row in rows),
        'plainFields': sum(not field['observable'] for row in rows for field in row['fields']),
        'variants': sum(row['variants'] for row in rows),
    }
