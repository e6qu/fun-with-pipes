"""Separate service storage from caller formatting and one-time type metadata."""
import json
import re

from weak_callback_service import CASES, expected, unique_fields

LANGUAGES = ('c', 'rs', 'swift')
GROUPS = ('service', 'type-metadata')
COSTS = ('allocations', 'peak', 'leaked')


def decode_case(output, population, mode):
    assert (population, mode) in CASES
    row = json.loads(output, object_pairs_hook=unique_fields)
    assert isinstance(row, dict) and all(type(value) is int for value in row.values())
    assert row == expected(population, mode), row
    return row


def allocation_kind(stack, language):
    assert language in LANGUAGES
    frames = [frame.split(' (', 1)[0] for frame in stack.split(';') if frame]
    if language == 'c':
        inside = 'service_run' in frames
    elif language == 'rs':
        inside = any(re.fullmatch(r'_RNvC[A-Za-z0-9]+_21weak_callback_service11service_run', frame)
                     or frame.startswith('weak_callback_service::service_run') for frame in frames)
    else:
        inside = any(frame.startswith('$s19WeakCallbackService10serviceRun') for frame in frames)
    if not inside:
        return 'outside'
    if language == 'swift' and any(frame.startswith((
            '__swift_instantiateConcreteTypeFromMangledName', 'swift_getTypeByMangledName',
            'swift_getSingletonMetadata', 'swift_getGenericMetadata')) for frame in frames):
        return 'type-metadata'
    return 'service'


def check_costs(costs, language, population, variant):
    assert language in LANGUAGES and population in (64, 4096)
    assert set(costs) == set(GROUPS)
    for row in costs.values():
        assert set(row) == set(COSTS)
        assert all(type(value) is int and value >= 0 for value in row.values())
    service = costs['service']
    # Every pending payload exists before dispatch. No attribution is a failed
    # observation, not evidence of allocation-free execution.
    assert service['allocations'] >= population
    assert service['peak'] >= population * 16 * 8
    if language == 'c':
        assert service['allocations'] == population + 4
    if language != 'swift':
        assert costs['type-metadata'] == dict.fromkeys(COSTS, 0)
    if variant == 'ordinary':
        assert service['leaked'] == 0, costs
    else:
        assert language == 'c'
        assert variant in ('omitted-payload-release', 'omitted-registration-release')
        assert service['leaked'] == (population * 128 if variant == 'omitted-payload-release' else 16), costs
