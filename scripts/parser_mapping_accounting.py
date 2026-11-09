"""Validate mapping permissions, residency and explicit kernel accounting flags."""
import hashlib
import json

from parser_process_memory import CONTROL_NAME, accounting, check_kernel_accounting, mappings, validate_mapping_control


def check_accounting(result, folder, reservation):
    assert reservation in ('accounted', 'no-reserve')
    validate_mapping_control(result, folder)
    policies = []
    rows = []
    for snapshot in result['snapshots']:
        memory = mappings((folder / snapshot['file']).read_text())
        assert snapshot['accounting'] == accounting(memory)
        policy_path = folder / snapshot['kernelAccountingFile']
        assert hashlib.sha256(policy_path.read_bytes()).hexdigest() == snapshot['kernelAccountingSha256']
        policy = json.loads(policy_path.read_text())
        check_kernel_accounting(policy)
        policies.append((policy['kernel'], policy['policy']))
        rows.append([row for row in memory if row['name'] == CONTROL_NAME])
    assert all(policy == policies[0] for policy in policies), 'host changed overcommit policy during observation'
    mode = policies[0][1]['overcommit_memory']
    assert mode in (0, 1, 2)
    no_reserve = reservation == 'no-reserve' and mode != 2
    for phase in (1, 2, 3):
        flags = rows[phase][0]['flags']
        assert ('nr' in flags) == no_reserve, ('unexpected reservation flags', phase, flags, mode)
        assert ('ac' in flags) == (phase >= 2 and not no_reserve), ('unexpected accounting flags', phase, flags, mode)
    return dict(overcommitMode=mode, noReserveRequested=reservation == 'no-reserve',
                noReserveObserved=no_reserve,
                phases=[dict(phase=phase, flags=row[0]['flags'] if row else [],
                             accountableKiB=accounting(row)['accountableMappingKiB'],
                             noReserveKiB=accounting(row)['noReserveMappingKiB'],
                             residentKiB=row[0]['fields']['Rss'] if row else 0) for phase, row in enumerate(rows)])
