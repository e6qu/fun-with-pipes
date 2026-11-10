"""Separate diagnostic compiler instrumentation for actual nested-lifetime proof visits."""
import json

from weak_callback_service import replace_once, unique_fields

PREFIX = 'FWP_RESOURCE_PROOF '
COUNTERS = ('freshVisits', 'bodyVisits', 'aliasVisits')
RUST = ('OBSERVED_FRESH', 'OBSERVED_BODY', 'OBSERVED_ALIAS')


def instrument(source):
    assert PREFIX not in source and all(name not in source for name in RUST)
    declarations = '\nthread_local! {\n' + ''.join(
        f'    static {name}: std::cell::Cell<usize> = const {{ std::cell::Cell::new(0) }};\n'
        for name in RUST) + '}\n'
    declarations += '''
fn observed_report(locals: usize, selected: usize, rejected: bool) {
    eprintln!("FWP_RESOURCE_PROOF {{\\"locals\\":{},\\"selected\\":{},\\"rejected\\":{},\\"freshVisits\\":{},\\"bodyVisits\\":{},\\"aliasVisits\\":{}}}",
        locals, selected, rejected, OBSERVED_FRESH.get(), OBSERVED_BODY.get(), OBSERVED_ALIAS.get());
}
'''
    source = replace_once(source, 'use crate::ir::{Expr, Local, Pat};',
                          'use crate::ir::{Expr, Local, Pat};\n' + declarations)
    for marker, counter in (
        ('fn fresh_bindings(expr: &Expr, seen: &mut HashSet<Local>) -> bool {', 'OBSERVED_FRESH'),
        ('    fn visit(&mut self, expr: &Expr) {', 'OBSERVED_BODY'),
        ('    fn covered(&self, value: &Expr) -> bool {', 'OBSERVED_ALIAS'),
    ):
        source = replace_once(source, marker, marker + f'\n        {counter}.set({counter}.get() + 1);')
    marker = '    if !fresh_bindings(root, &mut (0..arity).collect()) {\n'
    source = replace_once(source, marker,
        ''.join(f'    {name}.set(0);\n' for name in RUST) + marker +
        '        observed_report(locals, 0, true);\n')
    return replace_once(source, '    scan.selected\n}',
        '    observed_report(locals, scan.selected.values().map(HashSet::len).sum(), false);\n    scan.selected\n}')


def decode(stderr):
    rows = []
    for line in stderr.splitlines():
        assert line.startswith(PREFIX), line
        row = json.loads(line[len(PREFIX):], object_pairs_hook=unique_fields)
        assert set(row) == {'locals', 'selected', 'rejected', *COUNTERS}
        assert type(row['rejected']) is bool
        assert all(type(row[key]) is int and row[key] >= 0 for key in ('locals', 'selected', *COUNTERS))
        assert row['freshVisits'] > 0
        if row['rejected']:
            assert row['selected'] == row['bodyVisits'] == row['aliasVisits'] == 0
        else:
            assert row['freshVisits'] == row['bodyVisits']
            assert row['aliasVisits'] <= row['bodyVisits']
        rows.append(row)
    return rows
