"""Validate complete callable phase records without accepting timing claims."""
import re

COUNTS = (0, 1, 16, 4096)
FIELDS = ("requests", "requestedBytes", "frees", "retains", "releases",
          "applications", "peakRequestedBytes", "finalRequestedBytes",
          "initialChargedBytes", "finalChargedBytes", "initialCountBytes",
          "finalCountBytes")


def code_sizes(instructions, language):
    if language not in ("c", "rust", "fwp") or not instructions:
        raise ValueError("missing native instructions or unknown peer")
    spans = {}
    functions = {}
    for instruction in instructions:
        encoding = "".join(instruction["encoding"].split())
        if not encoding or len(encoding) % 2 or not re.fullmatch(r"[0-9a-fA-F]+", encoding):
            raise ValueError("missing instruction bytes")
        size = len(encoding) // 2
        key = (instruction["section"], int(instruction["address"], 16))
        if key in spans:
            raise ValueError("duplicate decoded address")
        spans[key] = size
        name = instruction["function"].removeprefix("_")
        functions[name] = functions.get(name, 0) + size
    ordered = sorted(spans)
    for left, right in zip(ordered, ordered[1:]):
        if left[0] == right[0] and left[1] + spans[left] > right[1]:
            raise ValueError("overlapping decoded instructions")
    worker = {name: size for name, size in functions.items()
              if name in ("returned_make", "returned_direct")
              or (language == "fwp" and re.fullmatch(r"(?:[fwe]|fs|fwp_(?:owned_entry|args))\d+(?:\..*)?", name))
              or (language in ("c", "rust") and re.search(r"addition|composition", name))}
    if "returned_make" not in worker or "returned_direct" not in worker:
        raise ValueError("missing separately compiled factory or direct control")
    return dict(workerDecodedBytes=sum(worker.values()), workerFunctions=worker,
                allDecodedBytes=sum(spans.values()),
                scope="Decoded worker instructions include inlined arithmetic and any decoded alignment padding. "
                      "Shared fwp runtime helpers and observation/recovery functions are excluded from workers, "
                      "but included in the complete listing and text-section report.")


def phases(text, case):
    if case not in ("success", "omit-release", "recovery"):
        raise ValueError("unknown callable control")
    keys = ([(kind, n, 3) for kind in range(2) for n in (0, 8)]
            if case == "recovery" else
            [(kind, n, phase) for kind in range(2) for n in COUNTS for phase in range(3)])
    lines = text.splitlines()
    if len(lines) != len(keys):
        raise ValueError("missing or duplicate callable phase")
    result = []
    live = charged = metadata = 0
    for line, key in zip(lines, keys, strict=True):
        fields = line.split()
        if len(fields) != 4 + len(FIELDS) or fields[0] != "phase":
            raise ValueError("malformed callable phase")
        numbers = [int(value) for value in fields[1:]]
        if tuple(numbers[:3]) != key or any(value < 0 for value in numbers):
            raise ValueError("changed callable phase order or negative count")
        row = dict(zip(FIELDS, numbers[3:], strict=True))
        if row["initialChargedBytes"] != charged or row["initialCountBytes"] != metadata:
            raise ValueError("discontinuous storage observation")
        if row["peakRequestedBytes"] < max(live, row["finalRequestedBytes"]):
            raise ValueError("peak is smaller than live storage")
        if bool(row["requests"]) != bool(row["requestedBytes"]):
            raise ValueError("allocation count and requested bytes disagree")
        if row["finalRequestedBytes"] > live + row["requestedBytes"]:
            raise ValueError("unattributed requested storage")
        if row["releases"] < row["frees"]:
            raise ValueError("a callable was freed without releasing its owner")
        kind, n, phase = key
        if phase == 0:
            if not row["requests"] or row["frees"] or row["applications"]:
                raise ValueError("construction did not create an escaped callable")
        elif phase == 1:
            if row["requests"] or row["frees"] or row["finalRequestedBytes"] != live:
                raise ValueError("repeated scalar calls changed callable storage")
            if bool(row["applications"]) != bool(n):
                raise ValueError("invocation was not observed")
            if row["retains"] != row["releases"]:
                raise ValueError("borrowed invocation left a counted owner")
        elif phase == 2:
            if row["requests"] or row["applications"] or row["retains"]:
                raise ValueError("destruction created work unrelated to release")
            if case == "omit-release":
                if row["frees"] or row["releases"] or row["finalRequestedBytes"] != live:
                    raise ValueError("missing-release control unexpectedly released storage")
            elif not row["frees"] or row["finalRequestedBytes"] or row["finalChargedBytes"]:
                raise ValueError("callable storage survives normal destruction")
        elif (row["requests"] < 2 or row["requests"] != row["frees"]
              or row["finalRequestedBytes"] or row["finalChargedBytes"]):
            raise ValueError("failure and retry did not restore payload storage")
        live, charged, metadata = (row["finalRequestedBytes"], row["finalChargedBytes"],
                                   row["finalCountBytes"])
        result.append(dict(kind=kind, calls=n, phase=phase, **row))
    if case == "omit-release":
        if not live or not charged:
            raise ValueError("missing-release control did not expose retained storage")
    elif live or charged:
        raise ValueError("final payload storage is not empty")
    return result
