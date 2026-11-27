"""Immutable service acceptance contracts, selected by their exact reference."""
NESTED_REFERENCE = '65719f7fc2277a5b97c5a790df941fea6c5eb4d7'
VALUE_REFERENCE = '5a9047178b88c801f37a279dfeca55b0e190bf07'
REFERENCES = {NESTED_REFERENCE, VALUE_REFERENCE}


def runtime_limit(reference, population):
    assert reference in REFERENCES and population in (64, 4096)
    if population == 64:
        return 1.02
    return .95 if reference == VALUE_REFERENCE else .90
